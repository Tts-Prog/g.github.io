import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import '../../api/api_response.dart';
import '../../api/api_route.dart';
import '../../base_view_model/base_view_model.dart';
import '../../resources/models/validate_user_response.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../singleton/locator.dart';

class PasswordResetViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final APIClient _apiService = locator<APIClient>();
  String email = "";
  String id = "";

  TextEditingController emailController = TextEditingController();

  init(BuildContext context) {
    this.context = context;
  }

  checkEmail() async {
    setBusy(true);
    email = emailController.text.trim();

    String query = """
mutation {
  validate(email: $email)
}


""";
    var response = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () => APIResponse<ValidateUserResponse>(
            create: () => ValidateUserResponse()));

    if (response.response.data!.validate == false) {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Email does not exist");
    } else if (response.response.data!.validate == true) {
      setBusy(false);
    } else {
      ViewUtil.showSnackBar(context, response.response.errorMessage);
      setBusy(false);
    }
  }
}
