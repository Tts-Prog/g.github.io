// ignore_for_file: use_build_context_synchronously

import 'package:ame/resources/models/validate_user_response.dart';
import 'package:ame/views/signin/signin.dart';
import 'package:ame/views/signup/signup.dart';
import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import '../../api/api_response.dart';
import '../../api/api_route.dart';
import '../../base_view_model/base_view_model.dart';
import '../../resources/models/fetch_characters.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../singleton/locator.dart';

class EmailCheckViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  TextEditingController emailController = TextEditingController();
  String email = "";
  final APIClient _apiService = locator<APIClient>();

  init(BuildContext context) {
    this.context = context;
  }

  checkEmail() async {
    setBusy(true);
    email = emailController.text.trim();

    String query = """
mutation {
  validate(email: "$email")
}


""";
    var response = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () => APIResponse<ValidateUserResponse>(
            create: () => ValidateUserResponse()));

    if (response.response.data!.validate == false) {
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp(
                  email: email,
                )),
      );
    } else if (response.response.data!.validate == true) {
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignIn(
                  email: email,
                )),
      );
    } else {
      ViewUtil.showSnackBar(context, response.response.errorMessage);
      setBusy(false);
    }
  }
}
