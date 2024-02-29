import 'package:flutter/material.dart';

import '../../resources/base_view_model/base_view_model.dart';

class EventsMapViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;

  init(BuildContext context) {
    this.context = context;
  }
}
