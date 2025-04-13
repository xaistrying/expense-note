import 'package:expense_note/presentation/home/cubit/handle_card_cubit.dart';
import 'package:expense_note/presentation/home/home_screen.dart';
import 'package:expense_note/presentation/new_card/new_card_screen.dart';
import 'package:expense_note/presentation/statistic/statistic_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../presentation/nav/nav_screen.dart';
import '../../presentation/setting/setting_screen.dart';
import '../../presentation/splash/splash_screen.dart';

class AppRouter {
  AppRouter._();

  static const String splash = '/';
  static const String home = '/home';
  static const String newCard = '/newCard';
  static const String statistic = '/statistic';
  static const String setting = '/setting';

  static final GoRouter _router = GoRouter(
    initialLocation: splash,
    routes: [
      StatefulShellRoute.indexedStack(
        builder:
            (context, state, navigationShell) =>
                NavScreen(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: statistic,
                builder: (context, state) => const StatisticScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: setting,
                builder: (context, state) => const SettingScreen(),
              ),
            ],
          ),
        ],
      ),

      GoRoute(path: splash, builder: (context, state) => SplashScreen()),
      GoRoute(
        path: newCard,
        builder: (context, state) {
          Map<String, dynamic>? extra = state.extra as Map<String, dynamic>?;
          var bloc = extra?['bloc'] as HandleCardCubit;
          return BlocProvider.value(value: bloc, child: NewCardScreen());
        },
      ),
    ],
  );

  static GoRouter get router => _router;
}
