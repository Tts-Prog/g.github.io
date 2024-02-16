import 'package:flutter/material.dart';

import '../../base_view_model/base_view_model.dart';

class SignUpViewModel extends BaseViewModel {
  String title = "Sign Up";
  late BuildContext context;

  init(BuildContext context) {
    this.context = context;
  }
}
