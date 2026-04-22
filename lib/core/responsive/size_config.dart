import 'package:flutter/widgets.dart';

class SizeConfig {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockWidth;
  static late double blockHeight;
  static late double pixelRatio;
  static late EdgeInsets safeArea;

  // Figma base size
  static const double figmaWidth = 393;
  static const double figmaHeight = 852;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    pixelRatio = _mediaQueryData.devicePixelRatio;
    safeArea = _mediaQueryData.padding;

    blockWidth = screenWidth / figmaWidth;
    blockHeight = screenHeight / figmaHeight;
  }
}