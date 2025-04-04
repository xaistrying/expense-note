import 'package:expense_note/app/l10n/generated/app_localizations.dart';
import 'package:flutter/material.dart';

extension ContextExtension on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
}