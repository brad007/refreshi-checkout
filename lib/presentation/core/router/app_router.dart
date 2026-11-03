import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import 'app_router.gr.dart';
import 'auth_guard.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
@lazySingleton
class AppRouter extends RootStackRouter {
  AppRouter(this._authGuard);

  final AuthGuard _authGuard;

  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: CatalogRoute.page, path: '/', initial: true),
    AutoRoute(page: SignInRoute.page, path: '/sign-in'),
    AutoRoute(page: CheckoutRoute.page, path: '/checkout', guards: [_authGuard]),
    AutoRoute(page: OrderDetailsRoute.page, path: '/orders/:orderId', guards: [_authGuard]),
    RedirectRoute(path: '*', redirectTo: '/'),
  ];
}
