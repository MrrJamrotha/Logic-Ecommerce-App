import 'dart:ui';

class LocaleManager {
  LocaleManager._privateConstructor();

  static final LocaleManager _instance = LocaleManager._privateConstructor();

  factory LocaleManager() => _instance;

  Locale _currentLocale = const Locale('en');

  void setLocale(Locale locale) {
    _currentLocale = locale;
  }

  Locale get currentLocale => _currentLocale;
}
