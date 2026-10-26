import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/features/catalog/presentation/pages/catalog_page.dart';
import 'package:refreshi_checkout/features/checkout/domain/entities/checkout_draft.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order.dart';

import '../helpers/app_harness.dart';
import '../helpers/fixtures.dart';

void main() {
  late AppHarness app;

  setUp(() => app = AppHarness());

  testWidgets('shows a pending hold, then updates live when it is placed', (tester) async {
    final updates = StreamController<Either<Failure, CustomerOrder>>();
    addTearDown(updates.close);
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order()));
    when(app.watchOrder(any)).thenAnswer((_) => updates.stream);

    await app.pump(tester, path: '/orders/ord_1');
    expect(find.text('Pending'), findsOneWidget);
    expect(find.textContaining('Waiting for your bank'), findsOneWidget);
    expect(find.text('Hold amount'), findsOneWidget);

    updates.add(right(Fixtures.order(hold: HoldStatus.placed)));
    await app.settle(tester);

    expect(find.text('Confirmed'), findsOneWidget);
    expect(find.text('Hold placed. Booking confirmed'), findsOneWidget);
    expect(find.text('Amount on hold'), findsOneWidget);
  });

  testWidgets('shows a declined hold', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.failed)));
    await app.pump(tester, path: '/orders/ord_1');
    expect(find.text('Payment failed'), findsOneWidget);
    expect(find.text('Hold declined by your bank'), findsOneWidget);
    expect(find.textContaining('800.100.203 · Insufficient Funds'), findsOneWidget);
    expect(find.textContaining('Payment declined.', findRichText: true), findsOneWidget);
    expect(find.byIcon(Icons.close_rounded), findsWidgets);
  });

  testWidgets('lists the order details', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
    await app.pump(tester, path: '/orders/ord_1');
    expect(find.text('Bakery rescue bag').hitTestable(), findsOneWidget);
    expect(find.text('Fresh produce box').hitTestable(), findsOneWidget);
    expect(find.text('Visa •••• 0000'), findsOneWidget);
    expect(find.text('10:00 – 12:00'), findsOneWidget);
    expect(find.text('Wed 2 Jan'), findsOneWidget);
    expect(find.text('Pre-authorisation (PA)'), findsOneWidget);
    expect(find.textContaining('000.100.110'), findsOneWidget);
    expect(find.text('8ac7a4a289d210fc0189d5b4e9572cc8'), findsOneWidget);
    expect(find.text('Order ord_1'), findsOneWidget);
  });

  testWidgets('offers a refresh when live updates stop', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order()));
    when(app.watchOrder(any)).thenAnswer((_) => Stream.value(left(const Failure.network())));
    await app.pump(tester, path: '/orders/ord_1');
    expect(find.text('Live updates stopped.'), findsOneWidget);

    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
    await tester.tap(find.text('Refresh'));
    await app.settle(tester);
    expect(find.text('Confirmed'), findsOneWidget);
  });

  testWidgets('an unknown order shows not-found with a way back', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => left(const Failure.notFound()));
    await app.pump(tester, path: '/orders/nope');
    expect(find.text(const Failure.notFound().userMessage), findsOneWidget);
    expect(find.text('Try again'), findsNothing, reason: 'retrying cannot find a missing order');

    await tester.tap(find.text('See today\'s bags'));
    await app.settle(tester);
    expect(find.byType(CatalogPage).hitTestable(), findsOneWidget);
  });

  testWidgets('retry refetches after a failure', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => left(const Failure.network()));
    await app.pump(tester, path: '/orders/ord_1');
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
    await tester.tap(find.text('Try again'));
    await app.settle(tester);
    expect(find.text('Confirmed'), findsOneWidget);
  });

  testWidgets('"Rescue more food" returns to the catalog', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
    await app.pump(tester, path: '/orders/ord_1');
    await tester.dragUntilVisible(
      find.text('Rescue more food'),
      find.byType(ListView).hitTestable().first,
      const Offset(0, -300),
    );
    await app.settle(tester);
    await tester.tap(find.text('Rescue more food'));
    await app.settle(tester);
    expect(find.byType(CatalogPage).hitTestable(), findsOneWidget);
  });

  testWidgets('a declined order offers to try another card with the same bags', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.failed)));
    when(app.startNewCheckout(any)).thenAnswer((_) async => right(const CheckoutDraft(idempotencyKey: 'key-2')));
    await app.pump(tester, path: '/orders/ord_1');

    expect(find.text('PICKUP · NOT RESERVED'), findsOneWidget);
    await tester.tap(find.byKey(const Key('order.retry')));
    await app.settle(tester);

    expect(app.path, '/checkout');
    verify(
      app.saveDraft(
        CheckoutDraft(
          idempotencyKey: 'key-2',
          serviceIds: const ['bag_bakery', 'bag_grocer'],
          slotId: Fixtures.slot.id,
        ),
      ),
    );
    // Same bags and window; only the card is left to choose.
    expect(find.text('Choose a card to continue.'), findsOneWidget);
  });

  testWidgets('a placed order has no retry button', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
    await app.pump(tester, path: '/orders/ord_1');
    expect(find.byKey(const Key('order.retry')), findsNothing);
  });

  testWidgets('the status headline is a live region for screen readers', (tester) async {
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order()));
    when(app.watchOrder(any)).thenAnswer((_) => const Stream.empty());
    final semantics = tester.ensureSemantics();
    await app.pump(tester, path: '/orders/ord_1');
    final node = tester.getSemantics(find.bySemanticsLabel(RegExp('Hold on.')));
    expect(node.getSemanticsData().flagsCollection.isLiveRegion, isTrue);
    semantics.dispose();
  });
}
