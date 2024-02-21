import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/view_utilities/default_scaffold.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:ame/views/email_check/email_check.dart';
import 'package:flutter/material.dart';
import 'package:page_view_dot_indicator/page_view_dot_indicator.dart';

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
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: DefaultScaffold(
        isInfoBottomSheetPresent: true,
        body: SafeArea(
          child: Stack(
            children: [
              // Positioned(
              //     top: 20,
              //     left: 50,
              //     right: 50,
              //     child: ViewUtil.ameLogo(
              //         color: AppColors.ameSplashScreenBgColor, height: 15)),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
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
                                      builder: (context) => const EmailCheck()),
                                );
                              },
                              child: Text("Skip",
                                  style: const TextStyle().bodyLarge.makeWhite),
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
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                padding: EdgeInsets.zero,
                                alignment: Alignment.center,
                                fadeEdges: false,
                              ),
                            ),
                            GestureDetector(
                                onTap: _goToNextPage,
                                child: Text(
                                  "Next",
                                  style: const TextStyle().bodyLarge.makeWhite,
                                )),
                          ],
                        ).spaceSymmetrically(horizontal: 30)
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> infoCarouselList = [
    infoCarousel(
        header: " Explore Upcoming and \nNearby Events ",
        description:
            " In publishing and graphic design, Lorem is a placeholder text commonly "),
    infoCarousel(
        header: " Web Have Modern Events Calendar Feature",
        description:
            " In publishing and graphic design, Lorem is a placeholder text commonly "),
    infoCarousel(
        header: " Web Have Modern Events Calendar Feature",
        description:
            " In publishing and graphic design, Lorem is a placeholder text commonly "),
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
