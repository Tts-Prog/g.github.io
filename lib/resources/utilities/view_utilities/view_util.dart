import 'package:flutter/material.dart';

import '../app_assets.dart';

class ViewUtil {
  static Widget ameLogo(
      {Color color = Colors.white, double? height, double? width}) {
    return Image.asset(
      AppAssets.ameLogo,
      scale: 4.0,
      color: color,
      height: height,
      width: width,
    );
  }

  static Widget imageAsset4Scale({required String asset}) {
    return Image.asset(asset, scale: 4.0);
  }
}
