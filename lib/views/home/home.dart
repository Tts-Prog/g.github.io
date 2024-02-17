import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/size_fitter.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/view_utilities/default_scaffold.dart';
import 'home_view_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          appBarLogoColor: Colors.white,
          showAppBar: false,
          isTopFramePresent: true,
          busy: model.busy,
          body: Column(
            children: [
              SizedBox(
                height: 159.h.addSafeAreaHeight,
              ),
              Row(
                children: [
                  eventTags(category: "Some", tagColor: Colors.blue),
                  Container(
                    height: 40,
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(12)),
                    child: Center(
                      child: Text(
                        "All",
                        style: TextStyle().bodyMedium.makeWhite,
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
            ],
          ).spaceSymmetrically(
            horizontal: 16,
          )),
    );
  }

  Widget eventTags({required String category, required Color tagColor}) {
    return Container(
      height: 40,
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
          color: tagColor.withOpacity(0.8),
          borderRadius: BorderRadius.circular(12)),
      child: Center(
        child: Text(
          category,
          style: TextStyle().bodyMedium.makeWhite,
        ).spaceSymmetrically(horizontal: 16),
      ),
    );
  }
}
