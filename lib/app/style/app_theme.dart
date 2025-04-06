import 'package:flutter/material.dart';

import 'app_color.dart';
import 'app_dimens.dart';

class AppTheme {
  AppTheme._();

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: AppColor.customBrown2,

    appBarTheme: AppBarTheme(
      toolbarHeight: 60,
      backgroundColor: AppColor.customBrown1,
      actionsPadding: EdgeInsets.only(right: AppDimens.padding16),
      foregroundColor: AppColor.customBrown3,
      titleTextStyle: TextStyle(
        fontSize: AppDimens.fontSizeTitle,
        color: AppColor.customBrown3,
      ),
    ),
  );
}
