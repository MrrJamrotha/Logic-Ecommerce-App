import 'package:logger/web.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/locale/app_locale.dart';

extension Translation on String {
  String get tr {
    return AppLocale.translate(this);
  }
}

extension ScaleInt on int {
  double get scale {
    return scaleFontSize(toDouble());
  }
}

extension ScaleDouble on double {
  double get scale {
    return scaleFontSize(this);
  }
}

Logger logger = Logger();
