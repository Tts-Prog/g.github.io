import 'package:ame/resources/models/fetch_characters.dart';
import 'package:ame/views/reset_password/reset_password.dart';
import 'package:ame/views/tab_bar_page/home.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/get_user_info_response.dart';
import '../../resources/models/validate_user_response.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class PasswordResetViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final APIClient _apiService = locator<APIClient>();
  UserProfileInfo? userProfileInfo;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwordController = TextEditingController();

  String email = "";
  String name = "";
  String password = "";

  //final _authService = locator<AuthenticationService>();

  final _authService = locator<AuthenticationService>();

  String id = "";

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
      ViewUtil.showSnackBar(context, "Email is not registered");
    } else if (response.response.data!.forgotPassword == true) {
      setBusy(true);
      getUserInfo();
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordReset(
                // email: email,
                )),
      );
    } else {
      ViewUtil.showSnackBar(context, response.response.errorMessage);
      setBusy(false);
    }
  }

  getUserInfo() async {
    setBusy(true);
    await _authService.getUserProfileInfo(email);
    setBusy(true);
    userProfileInfo = _authService.userProfileInfo;
    setBusy(false);
  }

  changePassword() async {
    password = passwordController.text.trim();
    String changePasswordId = _authService.userProfileInfo!.getUser!.id!;

    String query = """
mutation {
  changePassword(id: "$changePasswordId", password: "$password") {
     id
    image
    email
    name
    password
    createdAt
  }
}
""";

    var response = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () => APIResponse<CharactersResponse>(
            create: () => CharactersResponse()));

    if (response.response.errorMessage != null) {
      ViewUtil.showSnackBar(context, response.response.errorMessage);
    } else if (response.response.data != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                // email: email,
                )),
      );
    } else {
      ViewUtil.showSnackBar(context, "Connection Error");
    }
  }
}
