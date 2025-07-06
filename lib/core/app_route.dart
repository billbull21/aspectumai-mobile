import 'package:go_router/go_router.dart';

import '../features/auth/pages/login/login_screen.dart';
import '../features/home/presentation/page/home_screen.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: rLogin,
    routes: [
      // GoRoute(
      //   path: '/',
      //   builder: (context, state) => const SplashScreen(),
      // ),
      GoRoute(
        path: rLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: rHome,
        builder: (context, state) => const HomeScreen(),
      ),
    ],
  );
}

const String rSplash = '/';
const String rLogin = '/login';
const String rHome = '/home';
