import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/get_user_info_response.dart';
import 'package:flutter/material.dart';

import '../../resources/base_view_model/base_view_model.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class ProfilePageViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final _authService = locator<AuthenticationService>();
  List<EventInstance> events = [];
  List<Category> categories = [];
  UserProfileInfo? userDetails;
  init(BuildContext context) {
    this.context = context;
    userDetails = _authService.userProfileInfo;
    addCategoriesToList();
  }

  void addCategoriesToList() {
    events = userDetails!.getUser!.events!;
    for (EventInstance eventItem in events) {
      categories.add(eventItem.category!);
    }
  }
}
