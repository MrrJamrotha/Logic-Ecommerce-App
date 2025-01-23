import 'package:flutter/material.dart';
import 'package:logic_app/core/locale/app_en.dart';
import 'package:logic_app/core/locale/app_km.dart';
import 'package:logic_app/core/locale/locale_manager.dart';

class AppLocale {
  AppLocale(this.locale);
  final Locale locale;

  static AppLocale? of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale);
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': en,
    'km': km,
  };

  static List<String> languages() => _localizedValues.keys.toList();

  static String translate(String key) {
    final currentLocale = LocaleManager().currentLocale.languageCode;
    return _localizedValues[currentLocale]?[key] ?? key;
  }
}
