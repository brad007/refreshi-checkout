import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fpdart/fpdart.dart';
import 'package:mockito/mockito.dart';
import 'package:refreshi_checkout/app.dart';
import 'package:refreshi_checkout/core/di/injection.dart';
import 'package:refreshi_checkout/core/router/app_router.dart';
import 'package:refreshi_checkout/core/router/auth_guard.dart';
import 'package:refreshi_checkout/features/auth/domain/entities/user_session.dart';
import 'package:refreshi_checkout/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:refreshi_checkout/features/catalog/presentation/bloc/catalog_bloc.dart';
import 'package:refreshi_checkout/features/checkout/domain/entities/checkout_draft.dart';
import 'package:refreshi_checkout/features/checkout/presentation/bloc/checkout_bloc.dart';
import 'package:refreshi_checkout/features/orders/presentation/bloc/order_details_bloc.dart';

import 'dummies.dart';
import 'fixtures.dart';
import 'mocks.mocks.dart';

/// Boots the real [RefreshiApp] — real router, guard and blocs — with every
/// use case mocked, so widget tests drive the UI exactly as a user would.
class AppHarness {
  AppHarness() {
    registerDummies();
    signedIn(true);
    when(getCatalog(any)).thenAnswer((_) async => right(Fixtures.catalog));
    when(loadDraft(any)).thenAnswer((_) async => right(Fixtures.emptyDraft));
    when(saveDraft(any)).thenAnswer((_) async => right(unit));
    when(signIn(any)).thenAnswer((_) async => right(Fixtures.session));
    when(signOut(any)).thenAnswer((_) async => right(unit));
  }

  final getCurrentSession = MockGetCurrentSession();
  final signIn = MockSignIn();
  final signOut = MockSignOut();
  final getCatalog = MockGetCheckoutCatalog();
  final loadDraft = MockLoadCheckoutDraft();
  final saveDraft = MockSaveCheckoutDraft();
  final startNewCheckout = MockStartNewCheckout();
  final submitCheckout = MockSubmitCheckout();
  final getOrder = MockGetOrder();
  final watchOrder = MockWatchOrder();

  late final AppRouter router;

  void signedIn(bool value) =>
      when(getCurrentSession(any)).thenAnswer((_) async => right(value ? some(Fixtures.session) : none<UserSession>()));

  void draft(CheckoutDraft draft) => when(loadDraft(any)).thenAnswer((_) async => right(draft));

  Future<void> pump(
    WidgetTester tester, {
    String path = '/',
    Size size = const Size(1200, 900),
    double textScale = 1,
  }) async {
    tester.view.physicalSize = size;
    tester.view.devicePixelRatio = 1;
    tester.platformDispatcher.textScaleFactorTestValue = textScale;
    addTearDown(tester.view.reset);
    addTearDown(tester.platformDispatcher.clearTextScaleFactorTestValue);

    await getIt.reset();
    router = AppRouter(AuthGuard(getCurrentSession));
    getIt
      ..registerSingleton(router)
      ..registerSingleton(AuthBloc(getCurrentSession, signIn, signOut))
      ..registerSingleton(CatalogBloc(getCatalog))
      ..registerSingleton(CheckoutBloc(loadDraft, saveDraft, startNewCheckout, submitCheckout))
      ..registerFactory(() => OrderDetailsBloc(getOrder, watchOrder));
    addTearDown(getIt.reset);

    await tester.pumpWidget(const RefreshiApp());
    await settle(tester);
    if (path != '/') {
      // Not awaited: navigation completes over frames that settle() pumps.
      unawaited(router.navigatePath(path));
      await settle(tester);
    }
  }

  /// Like pumpAndSettle, but tolerant of the spinners' endless animation.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 10; i++) {
      await tester.pump(const Duration(milliseconds: 50));
    }
  }

  String get path => router.urlState.path;
}
