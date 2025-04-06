import 'package:expense_note/app/router/app_router.dart';
import 'package:expense_note/app/style/app_theme.dart';
import 'package:flutter/material.dart';

import 'app/l10n/generated/app_localizations.dart';

void main()  {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: AppRouter.router,
      theme: AppTheme.lightTheme,
    );
  }
}
