import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/core/error/failures.dart';
import 'package:refreshi_checkout/core/widgets/brand.dart';
import 'package:refreshi_checkout/features/auth/presentation/pages/sign_in_page.dart';
import 'package:refreshi_checkout/features/catalog/presentation/pages/catalog_page.dart';
import 'package:refreshi_checkout/features/checkout/presentation/pages/checkout_page.dart';
import 'package:refreshi_checkout/features/orders/domain/entities/order.dart';
import 'package:refreshi_checkout/features/orders/presentation/pages/order_details_page.dart';

import '../helpers/app_harness.dart';
import '../helpers/fixtures.dart';

void main() {
  late AppHarness app;

  setUp(() {
    app = AppHarness();
    when(app.getOrder(any)).thenAnswer((_) async => right(Fixtures.order(hold: HoldStatus.placed)));
  });

  testWidgets('opens on the catalog', (tester) async {
    await app.pump(tester);
    expect(find.byType(CatalogPage), findsOneWidget);
    expect(app.path, '/');
  });

  testWidgets('unknown paths redirect to the catalog', (tester) async {
    await app.pump(tester, path: '/does/not/exist');
    expect(find.byType(CatalogPage), findsOneWidget);
  });

  testWidgets('a signed-in deep link opens the order directly', (tester) async {
    await app.pump(tester, path: '/orders/ord_1');
    expect(find.byType(OrderDetailsPage), findsOneWidget);
    expect(app.path, '/orders/ord_1');
    verify(app.getOrder('ord_1'));
  });

  testWidgets('a signed-out deep link goes to sign-in, then back to the order', (tester) async {
    app.signedIn(false);
    await app.pump(tester, path: '/orders/ord_1');

    expect(find.byType(SignInPage), findsOneWidget);
    expect(app.path, '/sign-in');
    expect(app.router.urlState.uri.queryParameters['redirect'], '/orders/ord_1');
    verifyNever(app.getOrder(any));

    app.signedIn(true);
    await tester.enterText(find.byKey(const Key('signIn.email')), 'test@example.com');
    await tester.tap(find.byKey(const Key('signIn.submit')));
    await app.settle(tester);

    expect(find.byType(OrderDetailsPage), findsOneWidget);
    expect(app.path, '/orders/ord_1');
  });

  testWidgets('a refreshed sign-in page still returns to the original link', (tester) async {
    app.signedIn(false);
    await app.pump(tester, path: '/sign-in?redirect=/orders/ord_9');

    app.signedIn(true);
    await tester.enterText(find.byKey(const Key('signIn.email')), 'test@example.com');
    await tester.testTextInput.receiveAction(TextInputAction.go);
    await app.settle(tester);

    expect(app.path, '/orders/ord_9');
  });

  testWidgets('an off-site redirect is ignored after sign-in', (tester) async {
    app.signedIn(false);
    await app.pump(tester, path: '/sign-in?redirect=https://evil.example');

    await tester.enterText(find.byKey(const Key('signIn.email')), 'test@example.com');
    await tester.tap(find.byKey(const Key('signIn.submit')));
    await app.settle(tester);

    expect(app.path, '/');
  });

  testWidgets('sign-in errors are shown inline', (tester) async {
    app.signedIn(false);
    await app.pump(tester, path: '/sign-in');
    when(app.signIn(any))
        .thenAnswer((_) async => left(const Failure.invalidInput(message: 'Enter a valid email address.')));

    await tester.tap(find.byKey(const Key('signIn.submit')));
    await app.settle(tester);

    expect(find.text('Enter a valid email address.'), findsOneWidget);
    expect(find.byType(SignInPage), findsOneWidget);
  });

  testWidgets('checkout is guarded too', (tester) async {
    app.signedIn(false);
    await app.pump(tester, path: '/checkout');
    expect(find.byType(SignInPage), findsOneWidget);
    expect(find.byType(CheckoutPage), findsNothing);
  });

  testWidgets('signing out returns to the catalog and hides the session', (tester) async {
    await app.pump(tester, path: '/orders/ord_1');
    expect(find.text('test@example.com').hitTestable(), findsOneWidget);

    await tester.tap(find.text('Sign out').hitTestable());
    await app.settle(tester);

    expect(find.byType(CatalogPage), findsOneWidget);
    expect(find.text('test@example.com').hitTestable(), findsNothing);
    verify(app.signOut(any));
  });

  testWidgets('the logo returns to the catalog', (tester) async {
    await app.pump(tester, path: '/orders/ord_1');
    await tester.tap(find.text('refreshi').hitTestable());
    await app.settle(tester);
    expect(find.byType(CatalogPage), findsOneWidget);
  });

  testWidgets('the email is hidden on narrow screens', (tester) async {
    await app.pump(tester, path: '/orders/ord_1', size: const Size(400, 800));
    expect(find.text('test@example.com').hitTestable(), findsNothing);
    expect(find.byTooltip('Sign out').hitTestable(), findsOneWidget);
  });

  testWidgets('signing out on a phone uses the icon button', (tester) async {
    await app.pump(tester, path: '/orders/ord_1', size: const Size(400, 800));
    await tester.tap(find.byTooltip('Sign out').hitTestable());
    await app.settle(tester);
    expect(find.byType(CatalogPage).hitTestable(), findsOneWidget);
    verify(app.signOut(any));
  });

  testWidgets('sign-in stacks the brand panel above the form on phones', (tester) async {
    app.signedIn(false);
    await app.pump(tester, path: '/sign-in?redirect=/checkout', size: const Size(400, 900));
    expect(find.byKey(const Key('signIn.email')), findsOneWidget);
    expect(
      tester.getTopLeft(find.textContaining('Save food.', findRichText: true)).dy,
      lessThan(tester.getTopLeft(find.byKey(const Key('signIn.email'))).dy),
    );
    // The brand panel spans the full width, like the form below it.
    final panel = tester.getSize(
      find.ancestor(of: find.textContaining('Save food.', findRichText: true), matching: find.byType(ForestPanel)),
    );
    expect(panel.width, greaterThan(400 - 2 * 12 - 1));
  });

  testWidgets('signed-out visitors can sign in from the nav and come back', (tester) async {
    app.signedIn(false);
    await app.pump(tester);
    await tester.tap(find.text('Sign in').hitTestable());
    await app.settle(tester);
    expect(app.path, '/sign-in');
    expect(app.router.urlState.uri.queryParameters['redirect'], '/');
    expect(find.text('Sign in').hitTestable(), findsNothing, reason: 'no sign-in button on the sign-in page');
  });

  testWidgets('sign-in links back to the bags', (tester) async {
    app.signedIn(false);
    await app.pump(tester, path: '/sign-in');
    await tester.tap(find.text('Back to bags'));
    await app.settle(tester);
    expect(find.byType(CatalogPage).hitTestable(), findsOneWidget);
  });

  testWidgets('a sign-in error clears as soon as the email is edited', (tester) async {
    app.signedIn(false);
    when(app.signIn(any))
        .thenAnswer((_) async => left(const Failure.invalidInput(message: 'Enter a valid email address.')));
    await app.pump(tester, path: '/sign-in');
    await tester.tap(find.byKey(const Key('signIn.submit')));
    await app.settle(tester);
    expect(find.text('Enter a valid email address.'), findsOneWidget);

    await tester.enterText(find.byKey(const Key('signIn.email')), 'test@');
    await app.settle(tester);
    expect(find.text('Enter a valid email address.'), findsNothing);
  });
}
