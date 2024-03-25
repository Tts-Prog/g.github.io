import 'package:ame/resources/models/fetch_characters.dart';
import 'package:ame/views/reset_password/reset_password.dart';
import 'package:ame/views/tab_bar_page/home.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/all_events_response.dart';
import '../../resources/models/get_user_info_response.dart';
import '../../resources/models/validate_user_response.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class PasswordResetViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final APIClient _apiService = locator<APIClient>();
  //UserProfileInfo? userProfileInfo;
  TextEditingController emailController = TextEditingController();
  FocusNode emailNode = FocusNode();
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode passwordNode = FocusNode();
  TextEditingController confirmPwordController = TextEditingController();
  FocusNode confirmPwordNode = FocusNode();
  final emailFormKey = GlobalKey<FormState>();

  final passwordResetFormKey = GlobalKey<FormState>();
  bool isEmailButtonEnabled = false;
  bool isPwordResetButtonEnabled = false;

  String email = "";
  String name = "";
  String password = "";
  List<EventInstance> events = [];

  List<Category> categories = [];
  // List<Category> eventCategories = [];

  UserProfileInfo? userDetails;
  AllEventsResponse? allEventsResponse;

  //final _authService = locator<AuthenticationService>();

  // final _authService = locator<AuthenticationService>();

  String id = "";

  init(BuildContext context, String emailIn, String idIn) {
    this.context = context;
    getUserProfileInfo(emailIn, id);
    email = emailIn;
    id = idIn;
  }

  init2(BuildContext context, String emailin) {
    this.context = context;
    getUserProfileInfo(emailin, id);
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
      // setBusy(true);
      //  setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PasswordReset(
                  email: email,
                  id: userDetails!.getUser!.id!,
                )),
      );
    } else {
      ViewUtil.showSnackBar(context, response.response.errorMessage);
      setBusy(false);
    }
  }

  getUserProfileInfo(String email, String id) async {
    setBusy(true);
    String queryUserProfileInfo = """mutation {
  getUser(email: "$email") {
    updatedAt  password  name  image  id email  createdAt
    events {
    latitude  longitude
      artists {
        artist {
          biography  createdAt  id  image  name  nationality  roles  updatedAt
        }
        role
      }
      category {
        color  createdAt  id name  updatedAt
      }
      createdAt  description  duration  id  image  location  start_time  subtitle  title  updatedAt  category_id
      users {
        createdAt  email  id  image  name  password  updatedAt
      }
      isSaved {
        createdAt  event_id  id  updatedAt  user_id
      }
    }
  }
}""";
    var profileResponse = await _apiService.request(
        header: {
          "user_id": "${id}",
          // 'accept': 'application/json',
          'content-type': 'application/json'
        },
        route: ApiRoute(ApiType.fetchUserInfo),
        data: {"query": queryUserProfileInfo},
        create: () =>
            APIResponse<UserProfileInfo>(create: () => UserProfileInfo()));

    if (profileResponse.response.errorMessage != null &&
        profileResponse.response.data == null) {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Event Not Found");
    } else if (profileResponse.response.data != null) {
      setBusy(false);
      userDetails = profileResponse.response.data;
      events = profileResponse.response.data!.getUser!.events!;
    } else {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Error");
    }
  }

  changePassword() async {
    setBusy(true);
    password = passwordController.text.trim();
    String changePasswordId = id;

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
      setBusy(false);
      ViewUtil.showSnackBar(context, response.response.errorMessage);
    } else if (response.response.data != null) {
      setBusy(false);
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Home(
                  email: email,
                  id: id,
                  // email: email,
                )),
      );
    } else {
      ViewUtil.showSnackBar(context, "Connection Error");
    }
  }
}
