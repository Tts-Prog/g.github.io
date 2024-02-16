import 'package:flutter/material.dart';

import '../../base_view_model/base_view_model.dart';

class PasswordResetViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;

  init(BuildContext context) {
    this.context = context;
  }
}
