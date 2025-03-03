import 'package:flutter/material.dart';

class AppSizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static Orientation? orientation;

  static double shortDimension = 0;
  static double longDimension = 0;

  static const guidelineBaseWidth = 350;
  static const guidelineBaseHeight = 680;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);

    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;

    shortDimension = screenWidth < screenHeight ? screenWidth : screenHeight;
    longDimension = screenWidth < screenHeight ? screenHeight : screenWidth;
  }
}

// Get the proportionate height as per screen size
double getScreenHeight(double inputHeight) {
  double screenHeight = AppSizeConfig.screenHeight;
  // 812 is the layout height that designer use
  return (inputHeight / 812.0) * screenHeight;
}

// Get the proportionate height as per screen size
double getScreenWidth(double inputWidth) {
  double screenWidth = AppSizeConfig.screenWidth;
  // 375 is the layout width that designer use
  return (inputWidth / 375.0) * screenWidth;
}

Size getPreferredSize({double height = 85}) {
  return Size.fromHeight(height);
}

double scale(double size) {
  return AppSizeConfig.shortDimension / AppSizeConfig.guidelineBaseWidth * size;
}

double scaleFontSize(double size, [double factor = 0.5]) {
  return size + (scale(size) - size) * factor;
}
