import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/utilities/size_fitter.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
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

  static Widget imageAsset4Scale({required String asset, Color? color}) {
    return Image.asset(
      asset,
      scale: 4.0,
      color: color,
    );
  }

  static Widget onboardingButton(
      {required String buttonText, required VoidCallback onPressed}) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(
            width: 10,
          ),
          Text(buttonText),
          const Icon(Icons.arrow_forward)
        ],
      ).spaceSymmetrically(horizontal: 16),
    );
  }

  static Widget customButton(
      {required VoidCallback onPressed,
      required buttonLogo,
      required String buttonText,
      required Color buttonColor,
      required Color textColor}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        alignment: Alignment.center,
        height: 56.h,
        decoration: BoxDecoration(
            color: buttonColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ViewUtil.imageAsset4Scale(asset: buttonLogo).spaceTo(right: 25),
            Text(
              buttonText,
              style: TextStyle(color: textColor),
            )
          ],
        ),
      ).spaceSymmetrically(vertical: 10, horizontal: 30),
    );
  }

  static Widget bonakoTrademark() {
    return RichText(
      text: const TextSpan(
        children: [
          TextSpan(
            text: 'Powered by ',
            style: TextStyle(
                color: AppColors.typographyTitle,
                fontSize: 15,
                fontWeight: FontWeight.w400),
          ),
          TextSpan(
            text: 'Bonako',
            style: TextStyle(
              //fontFamily: ,
              color: AppColors.typographyTitle,
              fontSize: 15,
              fontWeight: FontWeight.bold,
              //decoration: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
