import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/size_fitter.dart';
import 'package:ame/resources/utilities/view_utilities/constants.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final bool isScaffoldGreen, isInfoBottomSheetPresent;
  final Widget body;

  final bool busy;

  const DefaultScaffold({
    super.key,
    this.isScaffoldGreen = false,
    this.isInfoBottomSheetPresent = false,
    required this.body,
    this.busy = false,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          height: designHeight.h,
          width: designWidth.w,
          decoration: BoxDecoration(
            color: isScaffoldGreen
                ? AppColors.ameSplashScreenBgColor
                : Colors.white,
          ),
          child: isInfoBottomSheetPresent
              ? Container(
                  height: designHeight.h * 0.35,
                  decoration: const BoxDecoration(
                      color: AppColors.ameSplashScreenBgColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          topRight: Radius.circular(45))),
                )
              : const SizedBox(),
        ),
        Image.asset(
          AppAssets.scaffoldBgWhite,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ), // Image.asset(AppAssets.scaffoldBgWhite)
        Scaffold(
          appBar: AppBar(
            elevation: 0,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
            centerTitle: true,
            title: Image.asset(AppAssets.ameLogo,
                height: 17, width: 66, color: AppColors.ameSplashScreenBgColor),
          ),
          backgroundColor: Colors.transparent,
          body: body,
        )
      ],
    );
  }
}
