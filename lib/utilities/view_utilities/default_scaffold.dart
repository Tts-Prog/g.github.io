import 'package:ame/resources/app_colors.dart';
import 'package:ame/utilities/app_assets.dart';
import 'package:ame/utilities/size_fitter.dart';
import 'package:ame/utilities/view_utilities/constants.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final bool isScaffoldGreen;
  final Widget body;

  final bool busy;

  const DefaultScaffold({
    super.key,
    this.isScaffoldGreen = false,
    required this.body,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Image.asset(
            AppAssets.scaffoldBgWhite,
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
        ),
        if (isScaffoldGreen)
          Opacity(
            opacity: 1,
            child: Container(
              height: designHeight.h,
              width: designWidth.w,
              decoration: BoxDecoration(
                color: AppColors.ameSplashScreenBgColor,
              ),
            ),
          ), // Image.asset(AppAssets.scaffoldBgWhite)
        Scaffold(
          backgroundColor: Colors.transparent,
          body: body,
        )
      ],
    );
  }
}
