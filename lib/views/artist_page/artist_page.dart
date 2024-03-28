import 'dart:io';

import 'package:ame/resources/models/all_events_response.dart';
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
  ArtistPage(
      {Key? key,
      required this.artist,
      required this.eventInstance,
      required this.id})
      : super(key: key);
  static String routeName = "/insurance";
  Artist artist;
  EventInstance eventInstance;
  String id;

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  late ArtistPageViewModel model;
  List<String>? texts = ['Text 1', 'Text 2', 'Text 3', 'Text 4'];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ArtistPageViewModel>.reactive(
      viewModelBuilder: () => ArtistPageViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context, widget.artist);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          isTopFramePresent: true,
          showAppBar: false,
          topHeadFrame: ViewUtil.topFrame(
              rawHeight: 299,
              backGroundWidget: Container(
                height: Platform.isIOS ? 218.h + 30 : 218.h.addSafeAreaHeight,
                color: Colors.white,
                child: ViewUtil.imageBackgroundContainer(
                    child: const SizedBox(
                      width: double.infinity,
                    ),
                    isNetWorkImage: true,
                    height:
                        Platform.isIOS ? 218.h + 30 : 218.h.addSafeAreaHeight,
                    background: widget.artist.image!),
              )),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: Platform.isIOS ? 269.h + 15 : 269.h,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white.withOpacity(0.3),
                              child: const Icon(
                                Icons.arrow_back_sharp,
                                color: Colors.white,
                              ),
                            ).spaceTo(right: 16),
                          ),
                        ],
                      ),
                      Spacer()
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.artist.name!,
                                style: const TextStyle().headlineMedium,
                              ).spaceTo(top: 32),
                              Text(
                                widget.artist.nationality!,
                                style: const TextStyle().bodyMedium,
                              ).spaceTo(bottom: 32),
                            ],
                          ),
                          widget.artist.roles.toTextListWidget()
                        ],
                      ),

                      Text(
                        "Biography",
                        style: const TextStyle().titleSmall,
                      ).spaceTo(bottom: 16),
                      Text(
                        widget.artist.biography!,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w400),
                      ).spaceTo(bottom: 32),
                      ...List.generate(
                          model.artistEventList.length,
                          (index) => ViewUtil.searchEventContainer(
                                  model.artistEventList[index],
                                  widget.id,
                                  context,
                                  () {})
                              .spaceTo(bottom: 8)),

                      //   ViewUtil.searchEventContainer()
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
          // widget.eventInstance.category!.color!.replaceAll("#", "0x66"),
          backgroundColor: const Color(0xCC828282),
          child: SizedBox(
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: ViewUtil.customOutlineContainer(
                      backgroundColor: Color(
                        int.parse(
                          widget.eventInstance.category!.color!.startsWith("#")
                              ? widget.eventInstance.category!.color!
                                  .replaceAll("#", "0x66")
                              : widget.eventInstance.category!.color!
                                      .startsWith(" ")
                                  ? widget.eventInstance.category!.color!
                                      .replaceAll(" ", "0x66")
                                  : "0x66${widget.eventInstance.category!.color!}",
                        ),
                      ).withOpacity(0.8),
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
                      ViewUtil.bookmarkBlock(isSaved: true)
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
