import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/get_user_info_response.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/event_removal_response.dart';
import '../../resources/models/validate_user_response.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class ProfilePageViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final _authService = locator<AuthenticationService>();

  final APIClient _apiService = locator<APIClient>();

  List<EventInstance> events = [];

  // List<Category> categories = [];
  List<Category> eventCategories = [];

  UserProfileInfo? userDetails;
  init(BuildContext context) {
    this.context = context;
    _authService
        .getUserProfileInfo(_authService.userProfileInfo!.getUser!.email!);
    userDetails = _authService.userProfileInfo;
    addCategoriesToList();
    eventCategories = _authService.allEventsResponse!.categories!;
  }

  void addCategoriesToList() {
    List<Category> allCategories = [];
    List<EventInstance> excessEvents = userDetails!.getUser!.events!;
    for (EventInstance element in excessEvents) {
      if (!events.contains(element)) {
        events.add(element);
        events.toSet().toList();
      }
    }
    for (EventInstance eventItem in events) {
      allCategories.add(eventItem.category!);
    }

    List<String> idList = [];
    for (Category element in allCategories) {
      // if (!categories.contains(element)) {
      //   categories.add(element);

      //   idList.add(element.id!);
      // }
    }
    print(idList.toSet().toList());
    events = excessEvents.toSet().toList();
    //  categories = allCategories.toSet().toList();
    print(events.toString());
  }

  removeSavedEvent(EventInstance eventInstance) async {
    String removeSavedEventId = eventInstance.id!;
    String query = """
mutation RemoveSavedEvent {
  removeSavedEvent(id: "$removeSavedEventId")
}
""";

    var response = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () => APIResponse<EventRemovalResponse>(
            create: () => EventRemovalResponse()));

    if (response.response.data!.removeSavedEvent == false) {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Event Not Found");
    } else if (response.response.data!.removeSavedEvent == true) {
      setBusy(false);
      events.removeWhere((element) => element.id == eventInstance.id);
      ViewUtil.showSnackBar(context, "Event removed");
    } else {
      ViewUtil.showSnackBar(context, response.response.errorMessage);
      setBusy(false);
    }
  }
}
