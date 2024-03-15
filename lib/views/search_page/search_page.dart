import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/textfields/borderless_fields.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/models/all_events_response.dart';
import '../../resources/utilities/view_utilities/custom_drop_down.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../event_page/events.dart';
import '../explore/explore_view_model.dart';
import 'search_page_view_model.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.eventsList, required this.id})
      : super(key: key);
  final String id;
  static String routeName = "/insurance";
  List<EventInstance> eventsList;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late ExploreViewModel model;
  String searchText = '';

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
        model.init2(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          showAppBar: false,
          body: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      size: 22,
                    ).spaceTo(right: 16),
                  ),
                  Text(
                    "Search",
                    style: const TextStyle().titleMedium,
                  )
                ],
              ).spaceTo(top: 8, bottom: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                      flex: 2,
                      child: BorderlessSearchFields(
                        node: model.searchNode,
                        showSuffixBusy: model.searchPrefixShow(),
                        onchange: (value) {
                          setState(() {
                            searchText = value; // Update the search text
                          });
                        },
                        iconPresent: true,
                        keyboardType: TextInputType.emailAddress,
                        prefix: ViewUtil.imageAsset4Scale(
                            asset: AppAssets.searchIcon),
                      )),
                  CustomDropdown<int>(
                    widget: ViewUtil.customOutlineContainer(
                      // margin: EdgeInsets.only(bottom: 12.0),
                      width: 100,
                      height: 40,
                      borderRadius: 20,
                      backgroundColor: const Color(0xFF607D82),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            dayLimits[selectedValue],
                            style: const TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.w900)
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
              ).spaceTo(bottom: 20.h).spaceTo(bottom: 50),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  children: [
                    ...List.generate(
                        widget.eventsList.length,
                        (index) => buildEventContainer(
                              widget.eventsList[index],
                            ).spaceTo(bottom: 8)),
                  ],
                ),
              )),
            ],
          ).spaceSymmetrically(horizontal: 16, vertical: 24)),
    );
  }

  Widget buildEventContainer(
    EventInstance eventInstance,
  ) {
    if (searchText.isNotEmpty &&
        eventInstance.title!.toLowerCase().contains(searchText.toLowerCase()) ==
            false) {
      // Hide the container if its ID doesn't match the selected ID, unless "All" is selected
      print(eventInstance.description);

      return const SizedBox.shrink();
    }
    return ViewUtil.searchEventContainer(eventInstance, widget.id, context,
        () async {
      if (eventInstance.isSaved != null) {
        model.removeSavedEvent(eventInstance, widget.id);
        // widget.eventsList.remove(eventInstance);
      } else {
        model.saveAnEvent(eventInstance, widget.id);
      }
    });
  }
}
