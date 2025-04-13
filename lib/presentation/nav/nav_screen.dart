import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../home/cubit/handle_card_cubit.dart';
import '../home/widget/custom_bottom_navbar_widget.dart';

class NavScreen extends StatelessWidget {
  const NavScreen({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HandleCardCubit(),
      child: NavBody(navigationShell: navigationShell),
    );
  }
}

class NavBody extends StatelessWidget {
  const NavBody({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: CustomBottomNavbarWidget(
        navigationShell: navigationShell,
      ),
    );
  }
}
