import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/catalog/domain/entities/checkout_catalog.dart';
import 'package:refreshi_checkout/features/catalog/presentation/pages/catalog_page.dart';
import 'package:refreshi_checkout/features/checkout/domain/entities/checkout_draft.dart';
import 'package:refreshi_checkout/features/checkout/presentation/pages/checkout_page.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order_placement.dart';
import 'package:refreshi_checkout/features/orders/presentation/pages/order_details_page.dart';

import '../helpers/app_harness.dart';
import '../helpers/fixtures.dart';

void main() {
  late AppHarness app;
  const nextDraft = CheckoutDraft(idempotencyKey: 'key-2');

  setUp(() {
    app = AppHarness();
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
  });

  Finder service(String id) => find.byKey(Key('service.$id'));

  group('catalog', () {
    testWidgets('selecting services updates the bar and caps the selection at two', (tester) async {
      await app.pump(tester);
      expect(find.text('No bags selected'), findsOneWidget);

      await tester.tap(service('bag_bakery'));
      await app.settle(tester);
      expect(find.text('R65,00').hitTestable(), findsWidgets);
      expect(tester.widget<Text>(find.byKey(const Key('catalog.total'))).data, 'R65,00');

      await tester.tap(service('bag_grocer'));
      await app.settle(tester);
      expect(tester.widget<Text>(find.byKey(const Key('catalog.total'))).data, 'R154,00');

      // The third card is disabled, so tapping it changes nothing.
      await tester.tap(service('bag_cafe'));
      await app.settle(tester);
      expect(tester.widget<Text>(find.byKey(const Key('catalog.total'))).data, 'R154,00');
      verify(app.saveDraft(any)).called(2);
    });

    testWidgets('continue opens checkout', (tester) async {
      app.draft(Fixtures.completeDraft);
      await app.pump(tester);
      await tester.tap(find.byKey(const Key('catalog.continue')));
      await app.settle(tester);
      expect(find.byType(CheckoutPage), findsOneWidget);
      expect(app.path, '/checkout');
    });

    testWidgets('a load failure offers a retry', (tester) async {
      when(app.getCatalog(any)).thenAnswer((_) async => left(const Failure.network()));
      await app.pump(tester);
      expect(find.text(const Failure.network().userMessage), findsOneWidget);

      when(app.getCatalog(any)).thenAnswer((_) async => right(Fixtures.catalog));
      await tester.tap(find.text('Try again'));
      await app.settle(tester);
      expect(service('bag_cafe'), findsOneWidget);
    });

    testWidgets('uses a single column and short label on phones', (tester) async {
      app.draft(Fixtures.completeDraft);
      await app.pump(tester, size: const Size(400, 800));
      expect(find.text('Checkout'), findsOneWidget);
      await tester.dragUntilVisible(service('bag_grocer'), find.byType(CustomScrollView), const Offset(0, -200));
      await app.settle(tester);
      expect(tester.getTopLeft(service('bag_grocer')).dx, tester.getTopLeft(service('bag_bakery')).dx);
    });
  });

  group('checkout', () {
    testWidgets('choosing a slot and card, then confirming, lands on the order', (tester) async {
      app.draft(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_bakery']));
      when(app.submitCheckout(any)).thenAnswer((_) async => right(Fixtures.placement()));
      await app.pump(tester, path: '/checkout');

      Finder confirm() => find.byKey(const Key('checkout.confirm'));
      expect(tester.widget<FilledButton>(confirm()).onPressed, isNull);

      await tester.tap(find.byKey(Key('slot.${Fixtures.slot.id}')));
      await tester.tap(find.byKey(Key('paymentMethod.${Fixtures.visa.id}')));
      await app.settle(tester);
      expect(tester.widget<FilledButton>(confirm()).onPressed, isNotNull);

      when(app.loadDraft(any)).thenAnswer((_) async => right(nextDraft));
      await tester.tap(confirm());
      await app.settle(tester);

      expect(find.byType(OrderDetailsPage), findsOneWidget);
      expect(app.path, '/orders/ord_1');
      verify(
        app.submitCheckout(
          Fixtures.emptyDraft.copyWith(
            serviceIds: ['bag_bakery'],
            slotId: Fixtures.slot.id,
            paymentMethodId: Fixtures.visa.id,
          ),
        ),
      ).called(1);
    });

    testWidgets('a double click while the request is in flight submits once', (tester) async {
      app.draft(Fixtures.completeDraft);
      final gate = Completer<Either<Failure, OrderPlacement>>();
      when(app.submitCheckout(any)).thenAnswer((_) => gate.future);
      await app.pump(tester, path: '/checkout');

      final confirm = find.byKey(const Key('checkout.confirm'));
      await tester.tap(confirm);
      await tester.pump();
      await tester.tap(confirm, warnIfMissed: false);
      await tester.pump();

      expect(tester.widget<FilledButton>(confirm).onPressed, isNull, reason: 'disabled while submitting');
      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      when(app.loadDraft(any)).thenAnswer((_) async => right(nextDraft));
      gate.complete(right(Fixtures.placement()));
      await app.settle(tester);

      verify(app.submitCheckout(any)).called(1);
      expect(find.byType(OrderDetailsPage), findsOneWidget);
    });

    testWidgets('a replayed order tells the customer they were not charged twice', (tester) async {
      app.draft(Fixtures.completeDraft);
      when(app.submitCheckout(any)).thenAnswer((_) async => right(Fixtures.placement(replayed: true)));
      await app.pump(tester, path: '/checkout');

      await tester.tap(find.byKey(const Key('checkout.confirm')));
      await app.settle(tester);

      expect(find.textContaining('haven\'t been charged twice'), findsOneWidget);
    });

    testWidgets('a reload mid-submission resumes and finishes the order', (tester) async {
      app.draft(Fixtures.completeDraft.copyWith(submissionInFlight: true));
      when(app.submitCheckout(any)).thenAnswer((_) async {
        when(app.loadDraft(any)).thenAnswer((_) async => right(nextDraft));
        return right(Fixtures.placement());
      });
      await app.pump(tester, path: '/checkout');

      expect(find.byType(OrderDetailsPage), findsOneWidget);
      // The messenger renders it in each Scaffold mid-transition, hence findsWidgets.
      expect(find.text('Your order was completed after the page reloaded.'), findsWidgets);
    });

    testWidgets('shows the resuming banner while the resumed request runs', (tester) async {
      app.draft(Fixtures.completeDraft.copyWith(submissionInFlight: true));
      when(app.submitCheckout(any)).thenAnswer((_) => Completer<Either<Failure, OrderPlacement>>().future);
      await app.pump(tester, path: '/checkout');
      expect(find.textContaining('Picking up where you left off'), findsOneWidget);
    });

    testWidgets('a failure is shown and the customer can retry', (tester) async {
      app.draft(Fixtures.completeDraft);
      when(app.submitCheckout(any)).thenAnswer((_) async => left(const Failure.network()));
      await app.pump(tester, path: '/checkout');

      await tester.tap(find.byKey(const Key('checkout.confirm')));
      await app.settle(tester);

      expect(find.text(const Failure.network().userMessage), findsOneWidget);
      expect(tester.widget<FilledButton>(find.byKey(const Key('checkout.confirm'))).onPressed, isNotNull);
    });

    testWidgets('an idempotency conflict links to the existing order', (tester) async {
      app.draft(Fixtures.completeDraft);
      when(app.submitCheckout(any))
          .thenAnswer((_) async => left(const Failure.idempotencyConflict(existingOrderId: 'ord_1')));
      await app.pump(tester, path: '/checkout');
      await tester.tap(find.byKey(const Key('checkout.confirm')));
      await app.settle(tester);

      // The checkout is spent: reserving again can only conflict again.
      expect(tester.widget<FilledButton>(find.byKey(const Key('checkout.confirm'))).onPressed, isNull);
      expect(find.text('Use the options above to continue.'), findsOneWidget);
      await tester.tap(find.text('View that order'));
      await app.settle(tester);
      expect(app.path, '/orders/ord_1');
    });

    testWidgets('an idempotency conflict can start a new checkout', (tester) async {
      app.draft(Fixtures.completeDraft);
      when(app.submitCheckout(any)).thenAnswer((_) async => left(const Failure.idempotencyConflict()));
      when(app.startNewCheckout(any)).thenAnswer((_) async => right(nextDraft));
      await app.pump(tester, path: '/checkout');
      await tester.tap(find.byKey(const Key('checkout.confirm')));
      await app.settle(tester);

      expect(find.text('View that order'), findsNothing, reason: 'no order id to link to');
      await tester.tap(find.text('Start a new checkout'));
      await app.settle(tester);
      expect(find.text('Your bag is empty'), findsOneWidget);
    });

    testWidgets('an empty checkout links back to the catalog', (tester) async {
      await app.pump(tester, path: '/checkout');
      expect(find.text('Your bag is empty'), findsOneWidget);
      await tester.tap(find.text('See today\'s bags'));
      await app.settle(tester);
      expect(find.byType(CatalogPage).hitTestable(), findsOneWidget);
    });

    testWidgets('a catalog failure on a direct visit offers a retry', (tester) async {
      when(app.getCatalog(any)).thenAnswer((_) async => left(const Failure.network()));
      app.draft(Fixtures.completeDraft);
      await app.pump(tester, path: '/checkout');
      expect(find.text('Try again').hitTestable(), findsOneWidget);

      when(app.getCatalog(any)).thenAnswer((_) async => right(Fixtures.catalog));
      await tester.tap(find.text('Try again').hitTestable());
      await app.settle(tester);
      expect(find.byKey(const Key('checkout.confirm')), findsOneWidget);
    });

    testWidgets('lays out in one column on phones and can switch days', (tester) async {
      app.draft(Fixtures.completeDraft);
      await app.pump(tester, path: '/checkout', size: const Size(400, 900));
      expect(find.byKey(Key('slot.${Fixtures.slotNextDay.id}')), findsNothing);

      await tester.tap(find.byKey(const Key('day.2030-01-03')));
      await app.settle(tester);
      expect(find.byKey(Key('slot.${Fixtures.slotNextDay.id}')), findsOneWidget);
      await tester.dragUntilVisible(
        find.byKey(const Key('summary.total')),
        find.byType(ListView).first,
        const Offset(0, -300),
      );
      expect(find.byKey(const Key('summary.total')), findsOneWidget);
    });
  });

  group('guidance', () {
    testWidgets('the catalog explains the limit once two bags are chosen', (tester) async {
      await app.pump(tester);
      expect(find.text('Limit reached · tap a bag to swap'), findsNothing);
      await tester.tap(service('bag_bakery'));
      await tester.tap(service('bag_grocer'));
      await app.settle(tester);
      expect(find.text('Limit reached · tap a bag to swap'), findsOneWidget);
    });

    testWidgets('checkout says what is missing before it can be placed', (tester) async {
      app.draft(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_bakery']));
      await app.pump(tester, path: '/checkout');
      expect(find.text('Choose a pickup window and a card to continue.'), findsOneWidget);

      await tester.tap(find.byKey(Key('slot.${Fixtures.slot.id}')));
      await app.settle(tester);
      expect(find.text('Choose a card to continue.'), findsOneWidget);

      await tester.tap(find.byKey(Key('paymentMethod.${Fixtures.visa.id}')));
      await app.settle(tester);
      expect(find.byKey(const Key('summary.hint')), findsNothing);
    });

    testWidgets('asks for a window when only the card is chosen', (tester) async {
      app.draft(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_bakery'], paymentMethodId: Fixtures.visa.id));
      await app.pump(tester, path: '/checkout');
      expect(find.text('Choose a pickup window to continue.'), findsOneWidget);
    });

    testWidgets('on phones the reserve button sits in a sticky bar', (tester) async {
      app.draft(Fixtures.completeDraft);
      when(app.submitCheckout(any)).thenAnswer((_) async => right(Fixtures.placement()));
      await app.pump(tester, path: '/checkout', size: const Size(400, 800));

      // Visible without scrolling, unlike the receipt at the bottom of the page.
      expect(find.byKey(const Key('checkout.confirm')).hitTestable(), findsOneWidget);
      expect(find.text('R154,00').hitTestable(), findsWidgets);
      await tester.tap(find.byKey(const Key('checkout.confirm')));
      await app.settle(tester);
      verify(app.submitCheckout(any)).called(1);
    });

    testWidgets('the phone bar shows what is missing', (tester) async {
      app.draft(Fixtures.emptyDraft.copyWith(serviceIds: ['bag_bakery']));
      await app.pump(tester, path: '/checkout', size: const Size(400, 800));
      expect(find.text('Choose a pickup window and a card to continue.').hitTestable(), findsOneWidget);
    });

    testWidgets('checkout links back to the bags', (tester) async {
      app.draft(Fixtures.completeDraft);
      await app.pump(tester, path: '/checkout');
      await tester.tap(find.text('Back to bags'));
      await app.settle(tester);
      expect(find.byType(CatalogPage).hitTestable(), findsOneWidget);
    });
  });

  testWidgets('the catalog shows a skeleton while loading', (tester) async {
    final gate = Completer<Either<Failure, CheckoutCatalog>>();
    when(app.getCatalog(any)).thenAnswer((_) => gate.future);
    await app.pump(tester);
    expect(find.bySemanticsLabel('Loading today\'s bags'), findsOneWidget);
    gate.complete(right(Fixtures.catalog));
    await app.settle(tester);
    expect(find.bySemanticsLabel('Loading today\'s bags'), findsNothing);
    expect(service('bag_bakery'), findsOneWidget);
  });

  testWidgets('the empty basket never flashes while moving to the new order', (tester) async {
    app.draft(Fixtures.completeDraft);
    when(app.submitCheckout(any)).thenAnswer((_) async {
      when(app.loadDraft(any)).thenAnswer((_) async => right(Fixtures.emptyDraft.copyWith(idempotencyKey: 'key-2')));
      return right(Fixtures.placement());
    });
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
    await app.pump(tester, path: '/checkout');

    await tester.tap(find.byKey(const Key('checkout.confirm')));
    for (var i = 0; i < 40; i++) {
      await tester.pump(const Duration(milliseconds: 16));
      expect(find.text('Your bag is empty'), findsNothing, reason: 'frame $i');
    }
    expect(find.byType(OrderDetailsPage), findsOneWidget);
  });
}
