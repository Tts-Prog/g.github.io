// ignore_for_file: use_build_context_synchronously

import 'package:ame/resources/models/get_user_info_response.dart';
import 'package:ame/resources/models/validate_user_response.dart';
import 'package:ame/views/signin/signin.dart';
import 'package:ame/views/signup/signup.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/fetch_characters.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class EmailCheckViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  TextEditingController emailController = TextEditingController();
  String email = "";
  final APIClient _apiService = locator<APIClient>();
  UserProfileInfo? userProfileInfo;

  final _authService = locator<AuthenticationService>();

  init(BuildContext context) {
    this.context = context;
  }

  checkEmail() async {
    setBusy(true);
    email = emailController.text.trim();

    String query = """
mutation {
  forgotPassword(email: "$email")
}


""";
    var response = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () => APIResponse<ValidateUserResponse>(
            create: () => ValidateUserResponse()));

    if (response.response.data!.forgotPassword == false) {
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SignUp(
                  email: email,
                )),
      );
    } else if (response.response.data!.forgotPassword == true) {
      setBusy(true);
      getUserInfo();
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

  getUserInfo() async {
    setBusy(true);
    userProfileInfo = await _authService.getUserProfileInfo(email);
    // setBusy(true);
    // userProfileInfo = _authService.userProfileInfo;
    setBusy(false);
  }
}
