import 'package:expense_note/presentation/home/home_screen.dart';
import 'package:expense_note/presentation/statistic/statistic_screen.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String home = '/home';
  static const String statistic = '/statistic';

  static final GoRouter _router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(path: home, builder: (context, state) => HomeScreen()),
      GoRoute(path: statistic, builder: (context, state) => StatisticScreen()),
    ],
  );

  static GoRouter get router => _router;
}
