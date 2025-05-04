import 'package:aspectumai/core/utils/shared_pref_utils.dart';
import 'package:aspectumai/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:auto_route/auto_route.dart';

import '../dependency_injection.dart';
import 'app_route.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  final AuthCubit authCubit;

  AppRouter(this.authCubit);

  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: IndexRoute.page),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: RegisterRoute.page),
        AutoRoute(page: BottomNav.page, guards: [AuthGuard(authCubit)]),
        AutoRoute(page: HomeRoute.page, guards: [AuthGuard(authCubit)]),
        AutoRoute(page: ChatRoute.page, guards: [AuthGuard(authCubit)]),
      ];
}

class AuthGuard extends AutoRouteGuard {
  final AuthCubit authCubit;
  AuthGuard(this.authCubit);
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    // Check if the user is authenticated
    final sharedPreferences = sl<SharePrefUtils>();
    final token = await sharedPreferences.getString('token');

    if (token != null) {
      resolver.next();
    } else {
      router.replace(const LoginRoute());
    }
  }
}
