import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/utilities/view_utilities/constants.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';

class DefaultScaffold extends StatelessWidget {
  final bool isScaffoldGreen,
      isInfoBottomSheetPresent,
      showAppBarBackButton,
      isTopFramePresent,
      showAppBar;
  final Widget body;
  final Widget topHeadFrame;

  final bool busy;
  final Color appBarLogoColor;

  const DefaultScaffold(
      {super.key,
      this.isScaffoldGreen = false,
      this.isInfoBottomSheetPresent = false,
      this.isTopFramePresent = false,
      required this.body,
      this.busy = false,
      this.topHeadFrame = const SizedBox(),
      this.showAppBar = true,
      this.showAppBarBackButton = true,
      this.appBarLogoColor = AppColors.ameSplashScreenBgColor});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        pseudoBottomSheet(),
        isTopFramePresent ? topHeadFrame : const SizedBox(),

        Image.asset(
          AppAssets.scaffoldBgWhite,
          height: designHeight.h,
          width: designWidth.w,
          fit: BoxFit.cover,
        ), // Image.asset(AppAssets.scaffoldBgWhite)
        Scaffold(
          appBar: showAppBar
              ? AppBar(
                  elevation: 0,
                  surfaceTintColor: Colors.transparent,
                  backgroundColor: Colors.transparent,
                  leading: showAppBarBackButton
                      ? GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                          ),
                        )
                      : SizedBox(),
                  centerTitle: true,
                  title: Image.asset(AppAssets.ameLogo,
                      height: 17, width: 66, color: appBarLogoColor),
                )
              : null,
          backgroundColor: Colors.transparent,
          body: body,
        ),
        Center(child: const CircularProgressIndicator().hideIf(!busy))
      ],
    );
  }

  Widget pseudoBottomSheet() {
    return Container(
      alignment: Alignment.bottomCenter,
      height: designHeight.h,
      width: designWidth.w,
      decoration: BoxDecoration(
        color:
            isScaffoldGreen ? AppColors.ameSplashScreenBgColor : Colors.white,
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
    );
  }
}
