import 'package:auto_route/auto_route.dart';
import 'package:injectable/injectable.dart';

import '../../features/auth/domain/usecases/get_current_session.dart';
import '../usecase/usecase.dart';
import 'app_router.gr.dart';

/// Sends signed-out users to sign-in, carrying the requested path in the URL
/// (`/sign-in?redirect=/orders/abc`). Because the destination lives in the URL
/// rather than in memory, it survives a browser refresh on the sign-in page.
@lazySingleton
class AuthGuard extends AutoRouteGuard {
  AuthGuard(this._getCurrentSession);

  final GetCurrentSession _getCurrentSession;

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final session = await _getCurrentSession(const NoParams());
    final signedIn = session.match((_) => false, (s) => s.isSome());
    if (signedIn) {
      resolver.next();
      return;
    }
    resolver.next(false);
    await router.push(SignInRoute(redirect: resolver.route.fullPath));
  }
}
