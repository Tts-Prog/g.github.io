import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/fetch_characters.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../singleton/locator.dart';
import '../tab_bar_page/home.dart';

class SignInViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final APIClient _apiService = locator<APIClient>();
  String email = "";
  String password = "";
  bool isButtonEnabled = false;

  init(BuildContext context, String emailChecked) {
    this.context = context;
    fillEmail(emailChecked);
  }

  fillEmail(String emailFromCheck) {
    emailController = TextEditingController(text: emailFromCheck);
  }

  logIn() async {
    setBusy(true);
    email = emailController.text.trim();
    password = passwordController.text.trim();

    String query = """
      mutation {
  login(email: "$email", password: "$password") {
   id
  }
}

    """;

    var response = await _apiService.request(
        route: ApiRoute(ApiType.signIn),
        data: {"query": query},
        create: () => APIResponse<CharactersResponse>(
            create: () => CharactersResponse()));

    if (response.response.data == null) {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Connection error");
    } else if (response.response.errorMessage == null) {
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const Home()),
      );
    } else {
      setBusy(false);
      ViewUtil.showSnackBar(context, response.response.errorMessage);
    }

    setBusy(false);
  }
}
