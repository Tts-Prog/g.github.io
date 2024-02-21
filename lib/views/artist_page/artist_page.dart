import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/app_assets.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import 'artist_page_view_model.dart';

class ArtistPage extends StatefulWidget {
  const ArtistPage({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late ArtistPageViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArtistPageViewModel>.reactive(
      viewModelBuilder: () => ArtistPageViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          isTopFramePresent: true,
          showAppBar: false,
          topHeadFrame: ViewUtil.topFrame(
              rawHeight: 299,
              backGroundWidget: ViewUtil.imageBackgroundContainer(
                  child: const SizedBox(
                    width: double.infinity,
                  ),
                  height: 218.h.addSafeAreaHeight,
                  background: AppAssets.artistHold)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 269.h,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.white,
                            ),
                          ).spaceTo(right: 16),
                        ],
                      ),
                      ViewUtil.imageAsset4Scale(asset: AppAssets.notifIcon)
                          .spaceTo(right: 16),
                    ],
                  ).spaceTo(top: 12),
                ),
              ),
              Align(alignment: Alignment.center, child: bannerHeader())
                  .spaceTo(bottom: 10),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Event Name",
                        style: const TextStyle().headlineMedium,
                      ).spaceTo(top: 20),
                      Text(
                        "Artistes",
                        style: const TextStyle().bodyMedium,
                      ).spaceTo(bottom: 30),
                      Text(
                        "Biography",
                        style: const TextStyle().titleSmall,
                      ).spaceTo(bottom: 30),
                      const Text(
                          """Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. 
                                  
                                  Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase.
                                  
                                  Enjoy your favorite dishe and a lovely your friends and family and have a great time. Food from local food trucks will be available for purchase. Read More..."""),
                      ViewUtil.searchEventContainer()
                    ],
                  ),
                ),
              ),
            ],
          ).spaceSymmetrically(horizontal: 16, vertical: 24)),
    );
  }

  Widget bannerHeader() {
    return Stack(
      children: [
        ViewUtil.customOutlineContainer(
          isShadowPresent: true,
          shadow: const BoxShadow(
            color: Color(0x6650ADE8),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          borderRadius: 10,
          borderColor: Colors.transparent,
          height: 60,
          width: 295.w,
          // gradient: const LinearGradient(
          //     colors: [Color(0x33000000), Color(0xCC29E6DC)])
          backgroundColor: const Color(0xCC828282),
          child: SizedBox(
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: ViewUtil.customOutlineContainer(
                      backgroundColor: const Color(0xCC29E6DC),
                      height: 39.h,
                      width: 96.w,
                      borderRadius: 10,
                      child: Center(
                        child: Text(
                          "Network",
                          style: const TextStyle().bodyMedium.makeWhite,
                        ),
                      )),
                ).spaceTo(left: 20),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ViewUtil.shareBlock().spaceTo(right: 8.w),
                      ViewUtil.bookmarkBlock()
                    ],
                  ).spaceTo(right: 12),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
