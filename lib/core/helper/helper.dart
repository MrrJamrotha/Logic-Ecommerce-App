import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_global_key.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/locale/app_locale.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

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

showMessage({
  required String message,
  MessageStatus status = MessageStatus.success,
}) {
  late Color color;
  switch (status) {
    case MessageStatus.success:
      color = appGreen;
      break;
    case MessageStatus.error:
      color = appRedAccent;
      break;
    case MessageStatus.warning:
      color = appYellow;
      break;
  }
  scaffoldMessengerKey.currentState?.showSnackBar(
    SnackBar(
      content: TextWidget(text: message),
      backgroundColor: color,
    ),
  );
}

Color getOrderColorStatus(OrderStatus status) {
  switch (status) {
    case OrderStatus.pending:
      return appYellow;
    case OrderStatus.processing:
      return primary;
    case OrderStatus.delivery:
      return secondaryColor;
    case OrderStatus.completed:
      return appGreen;
  }
}
