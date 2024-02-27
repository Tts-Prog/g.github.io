import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/theme_utilities/lightTheme.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:ame/views/artist_page/artist_page.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/models/all_events_response.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import 'events_view_model.dart';

class EventsPage extends StatefulWidget {
  EventsPage({Key? key, required this.eventInstance}) : super(key: key);
  EventInstance eventInstance;

  static String routeName = "/insurance";

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late EventsPageViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsPageViewModel>.reactive(
      viewModelBuilder: () => EventsPageViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          isTopFramePresent: true,
          showAppBar: false,
          topHeadFrame: ViewUtil.topFrame(
              rawHeight: 218,
              backGroundWidget: ViewUtil.imageBackgroundContainer(
                  child: const SizedBox(
                    width: double.infinity,
                  ),
                  height: 218.h.addSafeAreaHeight,
                  isNetWorkImage: true,
                  background: widget.eventInstance.image!)),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 188.h,
                width: double.infinity,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.white.withOpacity(0.3),
                            child: const Icon(
                              Icons.arrow_back_sharp,
                              color: Colors.white,
                            ),
                          ).spaceTo(right: 16),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.eventInstance.title!,
                                style: const TextStyle().titleMedium.makeWhite,
                              ),
                              Text(
                                widget.eventInstance.category!.name!,
                                style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12)
                                    .makeWhite,
                              )
                            ],
                          ),
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
                        widget.eventInstance.title!,
                        style: const TextStyle().headlineMedium,
                      ).spaceTo(bottom: 30, top: 20),
                      eventInfoTile(
                          "${widget.eventInstance.startTime?.day.toString()} ${widget.eventInstance.startTime!.toMonthString()}, ${widget.eventInstance.startTime?.year.toString()}" ??
                              "",
                          "${widget.eventInstance.startTime?.getDayOfWeek()}, ${widget.eventInstance.startTime?.toFormattedTime()}" ??
                              "",
                          AppAssets.calendarIcon),
                      eventInfoTile(widget.eventInstance.location ?? "",
                          "36, Guild street London UK", AppAssets.locationIcon),
                      Text(
                        "Artistes",
                        style: const TextStyle().titleSmall,
                      ).spaceTo(bottom: 10),
                      // Row(
                      //   children: [
                      //     artistTags().spaceTo(right: 20),
                      //     artistTags().spaceTo(right: 20),
                      //     artistTags().spaceTo(right: 20),
                      //     artistTags(),
                      //   ],
                      // ).spaceTo(bottom: 30),
                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: [
                            ...List.generate(
                                widget.eventInstance.artists!.length,
                                (index) => artistTags(widget
                                        .eventInstance.artists![index].artist)
                                    .spaceTo(right: 12))
                          ],
                        ),
                      ),
                      Text(
                        "About Events",
                        style: const TextStyle().titleSmall,
                      ).spaceTo(bottom: 30),
                      Text(widget.eventInstance.description ?? "")
                    ],
                  ),
                ),
              ),
            ],
          ).spaceSymmetrically(horizontal: 16, vertical: 24)),
    );
  }

  Widget artistTags(Artist? artist) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ArtistPage(
                    artist: artist!,
                  )),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ViewUtil.networkCircleImage(
              radius: 30, networkImageStrng: artist?.image),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              children: [
                TextSpan(
                  text: artist?.name ?? "",
                  style: const TextStyle(
                          fontSize: 9,
                          fontWeight: FontWeight.bold,
                          fontFamily: AppFonts.lato)
                      .makeDefault,
                ),
                TextSpan(
                  text: '\nArtist',
                  style: const TextStyle(
                    fontFamily: AppFonts.lato,
                    fontSize: 9,
                    fontWeight: FontWeight.w400,
                    //decoration: TextDecoration.underline,
                  ).makeDefault,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bannerHeader() {
    return Stack(
      children: [
        ViewUtil.customOutlineContainer(
          child: const SizedBox(
            width: double.infinity,
          ),
          borderRadius: 10,
          borderColor: Colors.transparent,
          height: 60,
          // width: 295.w,
          // gradient: const LinearGradient(
          //     colors: [Color(0x33000000), Color(0xCC29E6DC)])
          backgroundColor: const Color(0xCC000000),
        ),
        ViewUtil.customOutlineContainer(
          isShadowPresent: true,
          shadow: const BoxShadow(
            color: Color(0x6650ADE8),
            blurRadius: 10,
            offset: Offset(0, 4),
            spreadRadius: 0,
          ),
          child: SizedBox(
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  child: Stack(
                    children: [
                      Positioned(
                          left: 44,
                          child: CircleAvatar(
                            radius: 17.9,
                            backgroundColor: Colors.red,
                            child: widget.eventInstance.users?[0].image != null
                                ? Image.network(
                                    widget.eventInstance.users![0].image!)
                                : const SizedBox(),
                          )),
                      Positioned(
                          left: 22,
                          child: widget.eventInstance.users!.length > 1
                              ? CircleAvatar(
                                  radius: 17.9,
                                  backgroundColor: Colors.black,
                                  child: widget.eventInstance.users?[1].image !=
                                          null
                                      ? Image.network(
                                          widget.eventInstance.users![1].image!)
                                      : const SizedBox(),
                                )
                              : SizedBox()),
                      widget.eventInstance.users!.length > 2
                          ? CircleAvatar(
                              radius: 17.9,
                              backgroundColor: Colors.amber,
                              child:
                                  widget.eventInstance.users?[2].image != null
                                      ? Image.network(
                                          widget.eventInstance.users![2].image!)
                                      : const SizedBox(),
                            )
                          : SizedBox()
                    ],
                  ),
                ).spaceTo(left: 30),
                Text(
                  widget.eventInstance.users!.length > 3
                      ? "+${widget.eventInstance.users!.length - 3} Going"
                      : "",
                  style: const TextStyle().bodyMedium.makeWhite,
                ).spaceTo(right: 30.w),
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
          borderRadius: 10,
          borderColor: Colors.transparent,
          height: 60,

          // gradient: const LinearGradient(
          //     colors: [Color(0x33000000), Color(0xCC29E6DC)])
          backgroundColor: Color(int.parse(
              widget.eventInstance.category!.color!.replaceAll("#", "0x66"))),
        ),
      ],
    );
  }

  static Widget eventInfoTile(String title, String subtitle, String image) {
    return ListTile(
      tileColor: Colors.transparent,
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 16,
            color: AppColors.typographyTitle),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 12,
            color: AppColors.typographySubColor),
      ),
      leading: ViewUtil.customOutlineContainer(
          height: 48,
          width: 48,
          borderRadius: 7,
          backgroundColor: AppColors.typographySubColor,
          child: ViewUtil.imageAsset4Scale(asset: image)),
      //minVerticalPadding: 20,
      //   onTap: onTap,
    );
  }
}
