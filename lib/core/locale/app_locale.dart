import 'package:flutter/material.dart';
import 'package:logic_app/core/locale/locale_manager.dart';

class AppLocale {
  AppLocale(this.locale);
  final Locale locale;

  static AppLocale? of(BuildContext context) {
    return Localizations.of<AppLocale>(context, AppLocale);
  }

  static const Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'hello': 'Hello',
      'welcome': 'Welcome',
    },
    'km': {
      'hello': 'សួស្តី',
      'welcome': 'ស្វាគមន៍',
    },
  };

  static List<String> languages() => _localizedValues.keys.toList();

  static String translate(String key) {
    final currentLocale = LocaleManager().currentLocale.languageCode;
    return _localizedValues[currentLocale]?[key] ?? key;
  }
}
