import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/models/all_events_response.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import 'profile_page_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.email, required this.id})
      : super(key: key);
  final String email, id;
  static String routeName = "/insurance";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfilePageViewModel model;
  String selectedId = 'All';
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
      viewModelBuilder: () => ProfilePageViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context, widget.email, widget.id);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          showAppBar: false,
          isTopFramePresent: true,
          topHeadFrame: ViewUtil.topFrame(rawHeight: 207),
          body: Column(
            children: [
              SizedBox(
                height: 187.h.addSafeAreaHeight,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          width: 69,
                          height: 69,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(AppAssets.artistHold),
                                  fit: BoxFit.cover),
                              color: Colors.white,
                              shape: BoxShape.circle),
                          child: const SizedBox(),
                        ).spaceTo(right: 20),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              model.userDetails?.getUser?.name ?? "",
                              style: const TextStyle().titleMedium.makeWhite,
                            ),
                            // Text(
                            //   "Event Category",
                            //   style: const TextStyle(
                            //           fontWeight: FontWeight.w500, fontSize: 12)
                            //       .makeWhite,
                            // )
                          ],
                        ),
                      ],
                    ).spaceTo(top: 20.addSafeAreaHeight),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: BorderlessSearchFields(
                    //         onTap: () {
                    //           // Navigator.push(
                    //           //   context,
                    //           //   MaterialPageRoute(
                    //           //       builder: context) => const SearchPage()),
                    //           // );
                    //         },
                    //         iconPresent: true,
                    //         hintColor: Colors.white,
                    //         keyboardType: TextInputType.emailAddress,
                    //         prefix: ViewUtil.imageAsset4Scale(
                    //             asset: AppAssets.searchIcon,
                    //             color: Colors.white),
                    //       ),
                    //     ),
                    //     ViewUtil.customOutlineContainer(
                    //             height: 36.h,
                    //             width: 90.w,
                    //             child: const Text("data"))
                    //         .spaceTo(left: 20)
                    //   ],
                    // )
                  ],
                ),
              ),
              SizedBox(
                height: 52,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    allCategContainer().spaceTo(right: 4),
                    ...List.generate(
                        model.categories.length,
                        (index) => categoryContainer(
                                id: model.categories[index].id!,
                                category: model.categories[index])
                            .spaceTo(right: 4)).toSet().toList()
                  ],
                ),
              ).spaceTo(bottom: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Saved events",
                  style: const TextStyle().titleSmall,
                ).spaceTo(bottom: 20.h),
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                        model.events.length,
                        (index) => buildEventContainer(
                              model.events[index],
                              selectedId,
                            ).spaceTo(bottom: 8)).toSet().toList(),
                  ],
                ),
              )),
            ],
          ).spaceSymmetrically(
            horizontal: 16,
          )),
    );
  }

  Widget networkCircleImage(
      {required double radius,
      String? networkImageStrng,
      Color? backGroundColor}) {
    return Container(
      width: radius,
      height: radius,
      decoration: BoxDecoration(
          image: networkImageStrng != null
              ? DecorationImage(
                  image: NetworkImage(networkImageStrng), fit: BoxFit.cover)
              : null,
          color: backGroundColor,
          shape: BoxShape.circle),
      child: const SizedBox(),
    );
  }

  Widget categoryContainer({required String id, required Category category}) {
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedId = id; // Update the selected ID
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ViewUtil.eventTags(
                category: category.name! ?? "All",
                tagColor:
                    Color(int.parse(category!.color!.replaceAll("#", "0x66")))),
            ViewUtil.customOutlineContainer(
                    backgroundColor: selectedId == id
                        ? Color(
                            int.parse(category.color!.replaceAll("#", "0x66")))
                        : Colors.transparent,
                    width: 24,
                    borderRadius: 8,
                    height: 5,
                    child: const SizedBox())
                .spaceTo(top: 5)
          ],
        ));
  }

  Widget allCategContainer() {
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedId = "All"; // Update the selected ID
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ViewUtil.eventTags(
                category: "All", tagColor: const Color(0x66E56861)),
            ViewUtil.customOutlineContainer(
                    backgroundColor: selectedId == "All"
                        ? const Color(0x66E56861)
                        : Colors.transparent,
                    width: 24,
                    height: 5,
                    borderRadius: 8,
                    child: const SizedBox())
                .spaceTo(top: 5)
          ],
        ));
  }

  Widget buildEventContainer(
    EventInstance eventInstance,
    String selectedId,
  ) {
    if (selectedId != 'All' && eventInstance.categoryId != selectedId) {
      // Hide the container if its ID doesn't match the selected ID, unless "All" is selected
      return const SizedBox.shrink();
    }
    return ViewUtil.eventContainer(widget.id, eventInstance, context, () {
      model.removeSavedEvent(eventInstance, widget.id);
    });
  }
}
