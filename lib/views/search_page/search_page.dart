import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/textfields/borderless_fields.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/models/all_events_response.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../event_page/events.dart';
import 'search_page_view_model.dart';

class SearchPage extends StatefulWidget {
  SearchPage({Key? key, required this.eventsList}) : super(key: key);
  static String routeName = "/insurance";
  List<EventInstance> eventsList;

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageViewModel model;
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SearchPageViewModel>.reactive(
      viewModelBuilder: () => SearchPageViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
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
                children: [
                  Expanded(
                    child: BorderlessSearchFields(
                      onchange: (value) {
                        setState(() {
                          searchText = value; // Update the search text
                        });
                      },
                      iconPresent: true,
                      keyboardType: TextInputType.emailAddress,
                      prefix: ViewUtil.imageAsset4Scale(
                          asset: AppAssets.searchIcon),
                    ).spaceTo(bottom: 20.h),
                  ),
                  ViewUtil.customOutlineContainer(
                          height: 36.h, width: 90.w, child: const Text("data"))
                      .spaceTo(left: 20)
                ],
              ).spaceTo(bottom: 50),
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
    return ViewUtil.searchEventContainer(eventInstance, context, () {});
  }
}
