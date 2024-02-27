import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../resources/size_utilities/size_fitter.dart';
import '../../resources/theme_utilities/theme_extensions.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
//import 'template_view_model.dart';
import 'test_view_vm.dart';

class TestView extends StatefulWidget {
  const TestView({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<TestView> createState() => _TestViewState();
}

class _TestViewState extends State<TestView> {
  late TestViewViewModel model;

  @override
  void didChangeDependencies() {
    SizeUtil().init(context);
    ThemeUtil().init(context);
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TestViewViewModel>.reactive(
      viewModelBuilder: () => TestViewViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          body: Center(
                  // Center is a layout widget. It takes a single child and positions it
                  // in the middle of the parent.
                  child: model.characterList.isEmpty
                      ? Column(
                          children: [
                            ElevatedButton(
                              onPressed: model.listFetching,
                              child: Text("Fetch"),
                            ),
                            ElevatedButton(
                                onPressed: () {
                                  print(model.characterList.last.name);
                                },
                                child: Text("list no"))
                          ],
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: List.generate(
                                model.characterList.length,
                                (index) => ListTile(
                                      leading: Image.network(model
                                          .characterList[index].image
                                          .toString()),
                                      title: Text(model
                                          .characterList[index].name
                                          .toString()),
                                    )),
                          ),
                        )

                  // List
                  )
              .spaceSymmetrically(horizontal: 16, vertical: 24)),
    );
  }
}
