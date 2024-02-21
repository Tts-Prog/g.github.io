import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/textfields/borderless_fields.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import 'search_page_view_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  late SearchPageViewModel model;

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
              ViewUtil.searchEventContainer()
            ],
          ).spaceSymmetrically(horizontal: 16, vertical: 24)),
    );
  }
}
