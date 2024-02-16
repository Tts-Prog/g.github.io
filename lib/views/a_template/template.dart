import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/view_utilities/default_scaffold.dart';
import 'template_view_model.dart';

class Template extends StatefulWidget {
  const Template({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<Template> createState() => _TemplateState();
}

class _TemplateState extends State<Template> {
  late TemplateViewModel model;

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TemplateViewModel>.reactive(
      viewModelBuilder: () => TemplateViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          body: Column(
            children: [],
          ).spaceSymmetrically(horizontal: 16, vertical: 24)),
    );
  }
}
