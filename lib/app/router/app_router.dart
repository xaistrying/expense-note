import 'package:expense_note/presentation/home/home_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static final String splash = '/';

  static final GoRouter _router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: splash,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  ); 

  static GoRouter get router => _router;
}