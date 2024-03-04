import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/view_utilities/constants.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';

import '../../../views/event_page/events.dart';
import '../../models/all_events_response.dart';
import '../app_assets.dart';

class ViewUtil {
  late BuildContext context;

  static showSnackBar(BuildContext context, String? message,
      {Color? bgColor, Color? textColor}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: bgColor ?? AppColors.typographyTitle,
      content: Text(
        message ?? "",
        style: const TextStyle().bodyMedium.makeWhite,
      ),
    ));
  }

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

  static Widget imageIcon4Scale({required String asset, Color? color}) {
    return Transform.scale(
      scale: 0.8,
      child: ImageIcon(AssetImage(asset), size: 10, color: color),
    );
  }

  static Widget imageBackgroundContainer(
      {required Widget child,
      required double height,
      required String background,
      EdgeInsetsGeometry margin = EdgeInsets.zero,
      EdgeInsetsGeometry padding = EdgeInsets.zero,
      bool isNetWorkImage = false}) {
    return Container(
        margin: margin,
        padding: padding,
        height: height,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: isNetWorkImage
                ? DecorationImage(
                    fit: BoxFit.cover, image: NetworkImage(background))
                : DecorationImage(
                    fit: BoxFit.cover, image: AssetImage(background))),
        child: child);
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

  static Widget customOutlineContainer(
      //shorthand for container with curved vertices
      {required Widget child,
      double borderRadius = 0,
      double? width,
      double? height,
      Gradient? gradient,
      Color borderColor = Colors.transparent,
      Color? backgroundColor,
      double borderWidth = 0.5,
      AlignmentGeometry? alignment,
      BoxShadow shadow = const BoxShadow(
        color: Color(0x1F493E83),
        blurRadius: 32,
        offset: Offset(0, 16),
        spreadRadius: 0,
      ),
      bool isShadowPresent = false}) {
    return Container(
      height: height,
      width: width,
      alignment: alignment,
      decoration: ShapeDecoration(
        gradient: gradient,
        shadows: [if (isShadowPresent) shadow],
        color: backgroundColor,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: borderWidth, color: borderColor),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
      // BoxDecoration(
      //     border: Border.all(
      //       color: color,
      //     ),
      //     borderRadius: BorderRadius.circular(borderRadius)),
      child: child,
    );
  }

  static Widget shareBlock() {
    return ViewUtil.customOutlineContainer(
        height: 36,
        width: 36,
        borderRadius: 7,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: ViewUtil.imageAsset4Scale(asset: AppAssets.shareIcon));
  }

  static Widget bookmarkBlock() {
    return ViewUtil.customOutlineContainer(
        height: 36,
        width: 36,
        borderRadius: 7,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: ViewUtil.imageAsset4Scale(asset: AppAssets.bookmarkIcon));
  }

  static Widget topFrame(
      {Widget backGroundWidget = const SizedBox(
        height: double.infinity,
        width: double.infinity,
      ),
      double rawHeight = 179}) {
    return Container(
      alignment: Alignment.topCenter,
      height: designHeight.h,
      width: designWidth.w,
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Container(
        height: rawHeight.h.addSafeAreaHeight,
        decoration: const BoxDecoration(
            color: AppColors.ameSplashScreenBgColor,
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10))),
        child: backGroundWidget,
      ),
    );
  }

  static Widget searchEventContainer(
      EventInstance eventInstance, BuildContext context, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventsPage(
                    eventInstance: eventInstance,
                  )),
        );
      },
      child: SizedBox(
        child: ViewUtil.customOutlineContainer(
            borderWidth: 0,
            borderColor: Colors.transparent,
            backgroundColor: Colors.white,
            height: 127.h,
            width: 335.w,
            borderRadius: 12,
            isShadowPresent: true,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                image: DecorationImage(
                                    image: NetworkImage(
                                      eventInstance.image!,
                                    ),
                                    fit: BoxFit.fitHeight)),
                            height: 114.h,
                            width: 90.w,
                            child: const SizedBox())
                        .spaceTo(left: 4, right: 8),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          eventInstance.title!
                              .moveIntoNewLinesAfter(20)
                              .truncateWithEllipses(53),
                          style: const TextStyle().bodyMedium,
                        ).spaceTo(top: 4),
                        Row(
                          children: [
                            Text(
                                    " ${eventInstance.startTime?.day.toString()}, ${eventInstance.startTime!.toMonthString()?.substring(0, 3).toUpperCase()} " ??
                                        "",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14))
                                .spaceTo(right: 10),
                            Text(
                              "${eventInstance.startTime?.toFormattedTime()} - ${eventInstance.startTime?.addMinutes(eventInstance.duration!).toFormattedTime()}",
                              style: const TextStyle().displaySmall,
                            )
                          ],
                        ).spaceTo(bottom: 12)
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                        onTap: onTap, child: ViewUtil.bookmarkBlock()),
                    ViewUtil.shareBlock()
                  ],
                ).spaceTo(top: 8, bottom: 12, right: 8)
              ],
            )).spaceAllAroundBy(4),
      ),
    );
  }

  static Widget eventContainer(
      EventInstance eventInstance, BuildContext context, VoidCallback onTap) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => EventsPage(
                    eventInstance: eventInstance,
                  )),
        );
      },
      child: ViewUtil.customOutlineContainer(
          backgroundColor: Colors.white,
          //width: double.infinity,
          borderRadius: 18,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                // width: 311.w,
                height: 131.h,
                decoration: BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                        image: NetworkImage(
                          eventInstance.image!,
                        ),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(18)),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: FittedBox(
                    child: ViewUtil.eventTags(
                        category: eventInstance.category?.name ?? "",
                        tagColor: Color(int.parse(eventInstance.category!.color!
                            .replaceAll("#", "0x66")))),
                  ).spaceTo(left: 8, top: 10),
                ),
              ).spaceTo(bottom: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        eventInstance.title ?? "",
                        style: const TextStyle().titleSmall.makeDefault,
                      ).spaceTo(bottom: 8),
                      Row(
                        children: [
                          Text(
                                  " ${eventInstance.startTime?.day.toString()}, ${eventInstance.startTime!.toMonthString()?.substring(0, 3).toUpperCase()} " ??
                                      "",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14))
                              .spaceTo(right: 10),
                          Text(
                            "${eventInstance.startTime?.toFormattedTime()} - ${eventInstance.startTime?.addMinutes(eventInstance.duration!).toFormattedTime()}",
                            //'16:00-17:00',
                            style: const TextStyle().displaySmall,
                          )
                        ],
                      )
                    ],
                  ),
                  Row(
                    children: [
                      ViewUtil.shareBlock().spaceTo(right: 20),
                      GestureDetector(
                          onTap: onTap, child: ViewUtil.bookmarkBlock())
                    ],
                  )
                ],
              ).spaceTo(bottom: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 70,
                    height: 24,
                    child: Stack(
                      children: [
                        // Positioned(
                        //     left: 36,
                        //     child: eventInstance.users!.length > 2
                        //         ? ViewUtil.networkCircleImage(
                        //             radius: 12,
                        //             networkImageStrng:
                        //                 eventInstance.users![2].image)
                        //         : const SizedBox()),
                        // Positioned(
                        //     left: 18,
                        //     child: eventInstance.users!.length > 1
                        //         ? ViewUtil.networkCircleImage(
                        //             radius: 12,
                        //             networkImageStrng:
                        //                 eventInstance.users![1].image)
                        //         : const SizedBox()),
                        // eventInstance.users!.isNotEmpty
                        //     ? ViewUtil.networkCircleImage(
                        //         radius: 12,
                        //         networkImageStrng:
                        //             eventInstance.users![0].image)
                        //     : const SizedBox()
                      ],
                    ),
                  ).spaceTo(right: 4, bottom: 12),
                  // Text(
                  //   eventInstance.users!.length > 3
                  //       ? "+${eventInstance.users!.length - 3} Going"
                  //       : "",
                  //   style: const TextStyle(
                  //       fontSize: 12, fontWeight: FontWeight.w500),
                  // )
                ],
              ).spaceTo(bottom: 8),
              Row(
                children: [
                  const Icon(
                    Icons.location_on_rounded,
                    color: Colors.grey,
                  ).spaceTo(right: 8),
                  Text(
                    eventInstance.location ?? "",
                    style: const TextStyle().displaySmall,
                  )
                ],
              )
            ],
          ).spaceAllAroundBy(9)),
    );
  }

  static Widget eventTags({required String category, required Color tagColor}) {
    return FittedBox(
      child: ViewUtil.customOutlineContainer(
        backgroundColor: const Color(0xbb000000),
        borderColor: Colors.transparent,
        borderRadius: 12,
        height: 40,
        child: Container(
          height: 40,
          decoration: BoxDecoration(
              color: tagColor.withOpacity(1),
              borderRadius: BorderRadius.circular(12)),
          child: Center(
            child: Text(
              category,
              style: const TextStyle().bodyMedium.makeWhite,
            ).spaceSymmetrically(horizontal: 16, vertical: 4),
          ),
        ),
      ),
    );
  }

  static Widget networkCircleImage(
      {required double radius,
      String? networkImageStrng,
      Color backGroundColor = Colors.white}) {
    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(
          color: backGroundColor,
          border: Border.all(color: Colors.black),
          image: networkImageStrng != null
              ? DecorationImage(
                  image: NetworkImage(
                    networkImageStrng,
                  ),
                  fit: BoxFit.cover)
              : null,
          //color: backGroundColor,
          shape: BoxShape.circle),
      child: const SizedBox(
        height: double.infinity,
        width: double.infinity,
        //child: Icon(Icons.abc),
      ),
    );
  }
}
