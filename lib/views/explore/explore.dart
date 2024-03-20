import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/utilities/view_utilities/custom_drop_down.dart';
import 'package:ame/resources/utilities/view_utilities/date_expansion_tile.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/app_assets.dart';
import '../../resources/utilities/textfields/borderless_fields.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../event_page/events.dart';
import '../search_page/search_page.dart';
import 'explore_view_model.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key, required this.email, required this.id})
      : super(key: key);
  final String email, id;
  static String routeName = "/insurance";

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late ExploreViewModel model;
  String selectedId = 'All'; // Track the selected ID
  int selectedValue = 0;
  bool hideDropDownMotif = false;
  List dayLimits = ["All days", "1 day", "2 days", "3 days"];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context, widget.id);
      },
      builder: (context, _, __) => PopScope(
        canPop: false,
        // onPopInvoked: (bool value) {
        //   value = false;
        //   // return value;
        // },
        child: DefaultScaffold(
            appBarLogoColor: Colors.white,
            showAppBar: false,
            isTopFramePresent: true,
            topHeadFrame: ViewUtil.topFrame(),
            busy: model.busy,
            body: Column(
              children: [
                SizedBox(
                  height: 159.h.addSafeAreaHeight,
                  child: Column(
                    children: [
                      ViewUtil.ameLogo(
                              color: Colors.white, height: 15, width: 57)
                          .spaceTo(top: 20.addSafeAreaHeight, bottom: 20),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 2,
                            child: BorderlessSearchFields(
                              node: model.searchNode,
                              readOnly: true,
                              showSuffixBusy: !model.searchNode.hasFocus,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SearchPage(
                                            eventsList: model.events,
                                            id: widget.id,
                                          )),
                                );
                              },
                              iconPresent: true,
                              hintColor: Colors.white,
                              keyboardType: TextInputType.emailAddress,
                              prefix: ViewUtil.imageAsset4Scale(
                                  asset: AppAssets.searchIcon,
                                  color: Colors.white),
                            ),
                          ),
                          CustomDropdown<int>(
                            widget: ViewUtil.customOutlineContainer(
                              // margin: EdgeInsets.only(bottom: 12.0),
                              width: 100,
                              height: 40,
                              borderRadius: 20,
                              backgroundColor: const Color(0xFF607D82),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    dayLimits[selectedValue],
                                    style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w900)
                                        .makeWhite,
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_down_outlined,
                                    size: 20,
                                    color: Colors.white,
                                  ).spaceTo(right: 8)
                                ],
                              ),
                            ).spaceTo(bottom: 5),

                            items: const [0, 1, 2, 3],
                            //  fieldColor: Colors.transparent,
                            // onTap: () {
                            //   setState(() {
                            //     selectedValue = 1;
                            //     hideDropDownMotif = true;
                            //   });
                            // },
                            value: selectedValue,
                            onChanged: (value) async {
                              setState(() {
                                selectedValue = value!;
                                hideDropDownMotif = false;
                                if (value == 0) {
                                  model.getEvents(widget.id);
                                } else {
                                  model.getEventsByDate(DateTime.now()
                                      .subtract(Duration(days: value))
                                      .toString());
                                }
                              });
                            },
                            itemBuilder: (item) => SizedBox(
                              //   width: 100,
                              child: ViewUtil.customOutlineContainer(
                                width: 100,
                                height: 40,
                                borderRadius: 20,
                                backgroundColor: const Color(0xFF607D82),
                                child: Center(
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // const SizedBox(
                                      //   width: 5,
                                      // ),
                                      Text(
                                        dayLimits[item].toString(),
                                        style: const TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w900)
                                            .makeWhite,
                                      ),
                                      // const Icon(
                                      //   Icons.keyboard_arrow_down_outlined,
                                      //   size: 30,
                                      //   color: Colors.white,
                                      // )
                                    ],
                                  ),
                                ),
                              ).spaceTo(
                                bottom: 5,
                              ),
                            ),
                          )
                        ],
                      ),

                      // DropdownExpansionTile(
                      //     value: IdentityDocument.driversLicence,
                      //     labelText: "labelText",
                      //     decoration: InputDecoration(),
                      //     onDocSelected: (onDocSelected) {})
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     categoryContainer(
                //         id: model.categories.first.id!,
                //         category: model.categories.first)
                //   ],
                // )
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
                              .spaceTo(right: 4))
                    ],
                  ),
                ).spaceTo(bottom: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Next events",
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
                              ).spaceTo(bottom: 8)),
                    ],
                  ),
                )),
              ],
            ).spaceSymmetrically(
              horizontal: 16,
            )),
      ),
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
                    borderRadius: 8,
                    backgroundColor: selectedId == id
                        ? Color(
                            int.parse(category.color!.replaceAll("#", "0x66")))
                        : Colors.transparent,
                    width: 24,
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
    return ViewUtil.eventContainer(widget.id, eventInstance, context, () async {
      if (eventInstance.isSaved != null) {
        model.removeSavedEvent(eventInstance, widget.id);
      } else {
        model.saveAnEvent(eventInstance, widget.id);
      }
    });
  }
}
