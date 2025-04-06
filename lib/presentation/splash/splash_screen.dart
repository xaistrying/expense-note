import 'package:expense_note/app/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 2)).then((_) {
      if (mounted) {
        context.go(AppRouter.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}