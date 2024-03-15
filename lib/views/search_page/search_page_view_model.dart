import 'package:flutter/material.dart';

import '../../resources/base_view_model/base_view_model.dart';

class SearchPageViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;

  FocusNode searchNode = FocusNode();

  bool searchPrefixShow() {
    return !searchNode.hasFocus;
  }

  init(BuildContext context) {
    this.context = context;
  }
}
