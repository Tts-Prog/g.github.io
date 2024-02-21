import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/textfields/borderless_fields.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../search_page/search_page.dart';
import 'profile_page_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late ProfilePageViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfilePageViewModel>.reactive(
      viewModelBuilder: () => ProfilePageViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
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
                              "Event Name",
                              style: const TextStyle().titleMedium.makeWhite,
                            ),
                            Text(
                              "Event Category",
                              style: const TextStyle(
                                      fontWeight: FontWeight.w500, fontSize: 12)
                                  .makeWhite,
                            )
                          ],
                        ),
                      ],
                    ).spaceTo(top: 20.addSafeAreaHeight),
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
                        ViewUtil.customOutlineContainer(
                                height: 36.h,
                                width: 90.w,
                                child: const Text("data"))
                            .spaceTo(left: 20)
                      ],
                    )
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
                  "Saves",
                  style: const TextStyle().titleSmall,
                ).spaceTo(bottom: 20.h),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ViewUtil.eventContainer(context),
                    ],
                  ),
                ),
              ),
            ],
          ).spaceSymmetrically(
            horizontal: 16,
          )),
    );
  }
}
