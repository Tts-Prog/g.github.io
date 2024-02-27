import 'package:ame/resources/api/api_response.dart';
import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/fetch_characters.dart';
import 'package:ame/services/authentication_service.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/utilities/view_utilities/view_util.dart';
import '../../singleton/locator.dart';

class ExploreViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final APIClient _apiService = locator<APIClient>();
  final _authService = locator<AuthenticationService>();
  AllEventsResponse? allEventsResponse;
  List<EventInstance> events = [];
  List<Category> categories = [];

  init(BuildContext context) {
    setBusy(true);
    this.context = context;

    getEvents();
    setBusy(false);
  }

  getEvents() async {
    setBusy(true);
    await _authService.getAllEventsInfo();
    // String query = """
    // query { events {
    // category_id  createdAt  description  duration  id  image  location  start_time  subtitle  title updatedAt
    // category {  color  createdAt  id  name updatedAt  }
    // users { image id  name createdAt  updatedAt }
    // artists {  role  artist {  biography  createdAt  id  image  name  nationality  roles updatedAt  }}
    // }
    //   categories {  color  createdAt  id  name  updatedAt }  }""";

    // var response = await _apiService.request(
    //     route: ApiRoute(ApiType.checkEmail),
    //     data: {"query": query},
    //     create: () =>
    //         APIResponse<AllEventsResponse>(create: () => AllEventsResponse()));

    // if (response.response.errorMessage == null) {
    setBusy(true);
    allEventsResponse = _authService.allEventsResponse;
    events = allEventsResponse!.eventInstances!;
    categories = allEventsResponse!.categories!;
    setBusy(false);
  }

  getEventsByDate(String dateOfEvent) async {
    setBusy(true);

    String query = """
    query  {
  eventsByDay(date: "$dateOfEvent") {
      category_id  createdAt  description  duration  id  image  location  start_time  subtitle  title updatedAt    category {  color  createdAt  id  name updatedAt  }users { image id  name createdAt  updatedAt }    artists {  role  artist {  biography  createdAt  id  image  name  nationality  roles updatedAt  }}   }     categories {  color  createdAt  id  name  updatedAt }
  
}""";

    var response = await _apiService.request(
        route: ApiRoute(ApiType.searchEventsByDate),
        data: {"query": query},
        create: () =>
            APIResponse<AllEventsResponse>(create: () => AllEventsResponse()));

    // if (response.response.errorMessage == null) {

    if (response.response.errorMessage != null) {
      setBusy(false);
      ViewUtil.showSnackBar(context, response.response.errorMessage);
    }
    if (response.response.data != null) {
      setBusy(true);
      allEventsResponse = response.response.data;
      events = allEventsResponse!.eventInstances!;
      categories = allEventsResponse!.categories!;
      setBusy(false);
    } else {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Connection error");
    }
  }

  saveEvent() async {
    String query = """mutation  {
  createSavedEvent(savedEvent: \$savedEvent) {
    event_id
    id
    user_id
    createdAt
    updatedAt
  }
}""";

    var response = await _apiService.request(
        route: ApiRoute(ApiType.searchEventsByDate),
        data: {"query": query},
        create: () => APIResponse<CharactersResponse>(
            create: () => CharactersResponse()));

    // if (response.response.errorMessage == null) {

    if (response.response.errorMessage != null) {
      setBusy(false);
      ViewUtil.showSnackBar(context, response.response.errorMessage);
    }
    if (response.response.data != null) {
      setBusy(true);
      //
      setBusy(false);
    } else {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Connection error");
    }
  }
}
