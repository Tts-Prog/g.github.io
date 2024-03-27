import 'package:ame/resources/models/login_response.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/fetch_characters.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';
import '../tab_bar_page/home.dart';

class SignInViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final _authService = locator<AuthenticationService>();
  FocusNode emailNode = FocusNode();
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
        create: () =>
            APIResponse<LoginResponse>(create: () => LoginResponse()));

    if (response.response.errorMessage == null) {
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => Home(
                  email: email,
                  id: response.response.data!.login!.id!,
                )),
      ).then((value) => false);
    } else if (response.response.errorMessage != null) {
      setBusy(false);
      ViewUtil.showSnackBar(context, response.response.errorMessage);

      // _authService.setId(dynamicInfo!.getUser!.id!);
    } else {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Connection error");
    }

    // setBusy(false);
  }

  navigateToOpener(LoginResponse? response) async {
    setBusy(true);
    String? userId = _authService.setId(response!.login!.id!);

    var dynamicInfo =
        await _authService.getUserProfileInfoManually(email, userId!);

    // Future.delayed(Duration(seconds: 3), () {
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => const Home()),
    //   );
    // });
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => const Home()),
    // );
    // if (dynamicInfo == null) {
    //   setBusy(false);
    //   ViewUtil.showSnackBar(context, "Can't get profile ");
    // } else {

    //   setBusy(false);
    // }
  }
}
