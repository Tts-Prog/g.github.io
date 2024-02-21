import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/utilities/view_utilities/date_expansion_tile.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/app_assets.dart';
import '../../resources/utilities/textfields/borderless_fields.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../search_page/search_page.dart';
import 'explore_view_model.dart';

class Explore extends StatefulWidget {
  const Explore({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  late ExploreViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ExploreViewModel>.reactive(
      viewModelBuilder: () => ExploreViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
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
                    ViewUtil.ameLogo(color: Colors.white, height: 15, width: 57)
                        .spaceTo(top: 20.addSafeAreaHeight, bottom: 20),
                    Row(
                      children: [
                        Expanded(
                          child: BorderlessSearchFields(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SearchPage()),
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

                        // ViewUtil.customOutlineContainer(
                        //         height: 36.h,
                        //         width: 90.w,
                        //         child: const Text("data"))
                        // SizedBox(
                        //   width: 60,
                        //   child: DropdownExpansionTile(
                        //     labelText: "All Days",
                        //     onDocSelected: (p0) {},
                        //     decoration: InputDecoration(),
                        //     value: IdentityDocument.driversLicence,
                        //   )
                        //   .spaceTo(left: 20),
                        // )
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
              Row(
                children: [
                  ViewUtil.eventTags(category: "Some", tagColor: Colors.blue),
                  Container(
                    height: 40,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "All",
                        style: const TextStyle().bodyMedium.makeWhite,
                      ).spaceSymmetrically(horizontal: 16),
                    ),
                  ),
                ],
              ).spaceTo(bottom: 20),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Next events",
                  style: const TextStyle().titleSmall,
                ).spaceTo(bottom: 20.h),
              ),
              ViewUtil.eventContainer(context),
            ],
          ).spaceSymmetrically(
            horizontal: 16,
          )),
    );
  }
}
