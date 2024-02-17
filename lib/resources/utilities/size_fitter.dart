import 'package:ame/resources/utilities/view_utilities/constants.dart';
import 'package:flutter/material.dart';

class SizeUtil {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double defaultSize;
  static late double safeAreaHeight;
  static late Orientation orientation;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    orientation = _mediaQueryData.orientation;
    safeAreaHeight = _mediaQueryData.padding.top;
  }
}

extension SizeUtilExtension on num {
  double get w => (this / designWidth) * SizeUtil.screenWidth;

  double get h => (this / designHeight) * SizeUtil.screenHeight;

  double get addSafeAreaHeight => this + SizeUtil.safeAreaHeight;
}
