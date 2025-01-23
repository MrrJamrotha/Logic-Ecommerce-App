import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logic_app/core/locale/app_locale.dart';

class LocaleDelegate extends LocalizationsDelegate<AppLocale> {
  @override
  bool isSupported(Locale locale) =>
      AppLocale.languages().contains(locale.languageCode);

  @override
  Future<AppLocale> load(Locale locale) {
    return SynchronousFuture<AppLocale>(AppLocale(locale));
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocale> old) => true;
}
