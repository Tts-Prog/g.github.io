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
  FocusNode emailNode = FocusNode();
  String email = "";
  final emailFormKey = GlobalKey<FormState>();
  final APIClient _apiService = locator<APIClient>();
  UserProfileInfo? userProfileInfo;
  bool isButtonEnabled = false;

  final _authService = locator<AuthenticationService>();

  init(BuildContext context) {
    this.context = context;
  }

  checkEmail() async {
    setBusy(true);
    email = emailController.text.trim();

    String query = """
    mutation {
      getUser(email: $email) {
        id
      }
    }""";

    var response = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () =>
            APIResponse<UserProfileInfo>(create: () => UserProfileInfo()));

    print("response ${response.response.data!.getUser}");

    if (response.response.data!.getUser == null) {
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignUp(
            email: email,
          ),
        ),
      );
    } else if (response.response.data!.getUser != null) {
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
