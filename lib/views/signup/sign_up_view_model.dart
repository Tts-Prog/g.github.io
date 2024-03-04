import 'package:ame/resources/api/api_client.dart';
import 'package:ame/resources/api/api_route.dart';
import 'package:ame/resources/models/create_user_response.dart';
import 'package:ame/resources/models/login_response.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/services/authentication_service.dart';
import 'package:ame/singleton/locator.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_response.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/fetch_characters.dart';
import '../../resources/models/get_user_info_response.dart';
import '../tab_bar_page/home.dart';

class SignUpViewModel extends BaseViewModel {
  String title = "Sign Up";
  late BuildContext context;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPwordController = TextEditingController();
  final APIClient _apiService = locator<APIClient>();
  String email = "";
  String name = "";
  String password = "";
  bool isButtonEnabled = false;
  final _authService = locator<AuthenticationService>();

  final contactFormKey = GlobalKey<FormState>();

  init(BuildContext context) {
    this.context = context;
  }

  fillEmail(String emailFromCheck) {
    emailController = TextEditingController(text: emailFromCheck);
  }

  createUser() async {
    setBusy(true);
    email = emailController.text.trim();
    name = nameController.text.trim();
    password = passwordController.text.trim();

    String query = """
mutation  {
  createUser(user: {
    email: "$email",
    name: "$name",
    password: "$password"
  }) {
    id
  }
}

""";

    var response = await _apiService.request(
        route: ApiRoute(ApiType.fetchEventsDetails),
        data: {"query": query},
        create: () => APIResponse<CreateUserResponse>(
            create: () => CreateUserResponse()));
    // print("The status we got is" + response.response.errorMessage!);

    if (response.response.errorMessage == null) {
      setBusy(false);

      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  email: email,
                  id: response.response.data!.createUser!.id!,
                )),
      );
    } else {
      setBusy(false);
      ViewUtil.showSnackBar(context, response.response.errorMessage);
    }
  }
}
