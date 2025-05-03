import 'package:flutter/material.dart';

class UIHelpers {
  UIHelpers._();

  /// Dismiss key board
  static void dismissKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }
}
