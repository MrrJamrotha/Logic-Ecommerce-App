import 'package:flutter/material.dart';
import 'package:logger/web.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_global_key.dart';
import 'package:foxShop/core/constants/app_size_config.dart';
import 'package:foxShop/core/locale/app_locale.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';
import 'package:pinput/pinput.dart';

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

getEnumOrderStatus(String status){
  switch (status) {
    case "Pending":
      return OrderStatus.pending;
    case "Processing":
      return OrderStatus.processing;
    case "Delivery":
      return OrderStatus.delivery;
    case "Completed":
      return OrderStatus.completed;
  }
}

final defaultPinTheme = PinTheme(
  width: 56.scale,
  height: 56.scale,
  textStyle: TextStyle(
    fontSize: 20.scale,
    color: appBlack,
    fontWeight: FontWeight.w600,
  ),
  decoration: BoxDecoration(
    border: Border.all(color: Color.fromRGBO(234, 239, 243, 1)),
    borderRadius: BorderRadius.circular(20),
  ),
);

final focusedPinTheme = defaultPinTheme.copyDecorationWith(
  border: Border.all(color: primary),
  borderRadius: BorderRadius.circular(8),
);

final submittedPinTheme = defaultPinTheme.copyWith(
  decoration: defaultPinTheme.decoration?.copyWith(
    color: Color.fromRGBO(234, 239, 243, 1),
  ),
);

String maskText(String text) {
  if (text.length <= 2) return text; // No masking if the text is too short
  return text[0] + '*' * (text.length - 2) + text[text.length - 1];
}

Widget centerLoading() {
  return Center(child: CircularProgressIndicator.adaptive());
}

Widget centerText({String message = "not_found_product"}) {
  return Center(child: TextWidget(text: message.tr));
}

Locale getLocale(String code) {
  switch (code) {
    case 'en':
      return Locale('en', 'US');
    case 'km':
      return Locale('km', 'KH');
    case 'zh':
      return Locale('zh');
    default:
      return Locale('en', 'US');
  }
}
