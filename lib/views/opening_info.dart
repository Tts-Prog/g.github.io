import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/view_utilities/default_scaffold.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:ame/views/email_check/email_check.dart';
import 'package:ame/views/signup/signup.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

import '../resources/theme_utilities/app_colors.dart';
import '../resources/utilities/view_utilities/constants.dart';

class OpeningInfo extends StatefulWidget {
  const OpeningInfo({super.key});

  @override
  State<OpeningInfo> createState() => _OpeningInfoState();
}

class _OpeningInfoState extends State<OpeningInfo> {
  final PageController _pageController = PageController();
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  int selectedPage = 0;
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: DefaultScaffold(
        showAppBar: true,
        // isInfoBottomSheetPresent: true,
        showAppBarBackButton: false,
        body: Stack(
          children: [
            Positioned(
                top: -10,
                left: 20,
                right: 20,
                child: ViewUtil.customOutlineContainer(
                    //   isShadowPresent: true,
                    child: ViewUtil.imageAsset4Scale(
                        asset: AppAssets.bgHomeHolder))),
            SizedBox(
              height: designHeight.h,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // ViewUtil.customOutlineContainer(
                    //   isShadowPresent: true,
                    //   child: Image.asset(
                    //     AppAssets.homeHolder,
                    //     scale: 4,
                    //     //width: 295.w,
                    //   ),
                    // ),
                    Container(
                      height: designHeight.h * 0.35,
                      decoration: const BoxDecoration(
                          color: AppColors.ameSplashScreenBgColor,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(45),
                              topRight: Radius.circular(45))),
                      child: Container(
                        alignment: Alignment.center,
                        height: designHeight.h * 0.35,
                        width: designWidth.w,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 160.h,
                              child: PageView.builder(
                                controller: _pageController,
                                itemCount: 3,
                                itemBuilder: (context, index) {
                                  return infoCarouselList[index];
                                },
                                onPageChanged: (page) {
                                  setState(() {
                                    selectedPage = page;
                                  });
                                },
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const EmailCheck()),
                                    );
                                  },
                                  child: Text("Skip",
                                      style: const TextStyle()
                                          .bodyLarge
                                          .makeWhite),
                                ),
                                Expanded(
                                  child: PageViewDotIndicator(
                                    currentItem: selectedPage,
                                    count: 3,
                                    unselectedColor: Colors.grey,
                                    selectedColor: Colors.white,
                                    size: const Size(8, 8),
                                    unselectedSize: const Size(8, 8),
                                    duration: const Duration(milliseconds: 200),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 4),
                                    padding: EdgeInsets.zero,
                                    alignment: Alignment.center,
                                    fadeEdges: false,
                                  ),
                                ),
                                GestureDetector(
                                    onTap: () {
                                      if (selectedPage != 2) {
                                        _goToNextPage();
                                      } else {
                                        Navigator.pushReplacement(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const EmailCheck()),
                                        );
                                      }
                                    },
                                    child: Text(
                                      "Next",
                                      style:
                                          const TextStyle().bodyLarge.makeWhite,
                                    )),
                              ],
                            ).spaceTo(
                                left: 30, right: 30, top: 35.h, bottom: 20.h)
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ).spaceTo(top: 20),
      ),
    );
  }

  List<Widget> infoCarouselList = [
    infoCarousel(
        header: " Explore Upcoming and \nNearby Events ",
        description:
            " From concerts to workshops, festivals to parties, your next great experience is just a tap away!  "),
    infoCarousel(
        header: "Events Calendar Feature",
        description:
            " Experience the future of event planning with our Modern Events Calendar feature. "),
    infoCarousel(
        header: " Save and Organize Events",
        description:
            " Effortlessly Explore Tomorrow's Thrills: Navigate through Future Exciting Events "),
  ];
}

Widget infoCarousel({required String header, required String description}) {
  return SizedBox(
    width: double.infinity,
    child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            header,
            textAlign: TextAlign.center,
            style: const TextStyle().titleMedium.makeWhite,
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle().makeWhite,
          )
        ]),
  ).spaceSymmetrically(horizontal: 20);
}
