import 'package:logger/web.dart';
import 'package:logic_app/core/locale/app_locale.dart';

extension Translation on String {
  String get tr {
    return AppLocale.translate(this);
  }
}

Logger logger = Logger();
