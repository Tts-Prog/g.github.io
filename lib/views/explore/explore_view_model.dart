import 'package:ame/resources/api/api_response.dart';
import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/fetch_characters.dart';
import 'package:ame/resources/models/saved_event_response.dart';
import 'package:ame/services/authentication_service.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/get_user_info_response.dart';
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
  String userIdent = "";
  UserProfileInfo? userProfileInfo;
  String email = "";

  init(BuildContext context) {
    setBusy(true);
    userIdent = _authService.userProfileInfo!.getUser!.id!;
    email = _authService.userProfileInfo!.getUser!.email!;
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
      category_id  createdAt  description  duration  id  image  location  start_time  subtitle  title updatedAt   latitude  longitude     
      isSaved {  createdAt  event_id  id  updatedAt  user_id  }
      category {  color  createdAt  id  name updatedAt  }users { image id  name createdAt  updatedAt }    artists {  role  artist {  biography  createdAt  id  image  name  nationality  roles updatedAt  }}   }     categories {  color  createdAt  id  name  updatedAt }
  
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

  saveAnEvent(String eventId) async {
    String query = """mutation  {
   createSavedEvent(savedEvent: {event_id: $eventId, user_id: $userIdent}){
    event_id
    id
    user_id
    createdAt
    updatedAt
  }
}""";
    userProfileInfo = _authService.userProfileInfo!;
    List<EventInstance> eventInstanceList = userProfileInfo!.getUser!.events!;

    if (eventInstanceList.isEmpty) {
      setBusy(true);

      var response = await _apiService.request(
          route: ApiRoute(ApiType.searchEventsByDate),
          data: {"query": query},
          create: () => APIResponse<SavedEventResponse>(
              create: () => SavedEventResponse()));
      setBusy(false);

      // if (response.response.errorMessage == null) {

      if (response.response.errorMessage != null) {
        setBusy(false);
        ViewUtil.showSnackBar(context, response.response.errorMessage);
      } else if (response.response.data != null) {
        setBusy(false);
        setBusy(true);
        userProfileInfo = await _authService.getUserProfileInfo(email);
        ViewUtil.showSnackBar(context, "Event Saved");
        notifyListeners();
        setBusy(false);

        //
      } else {
        setBusy(false);
        ViewUtil.showSnackBar(context, "Connection error");
      }
    } else {
      for (EventInstance eventInstance in eventInstanceList) {
        if (eventId == eventInstance.id) {
          setBusy(false);
          ViewUtil.showSnackBar(context, "Already Saved Previously");
        } else {
          setBusy(true);
          var response = await _apiService.request(
              route: ApiRoute(ApiType.searchEventsByDate),
              data: {"query": query},
              create: () => APIResponse<SavedEventResponse>(
                  create: () => SavedEventResponse()));
          setBusy(false);

          // if (response.response.errorMessage == null) {

          if (response.response.errorMessage != null) {
            setBusy(false);
            ViewUtil.showSnackBar(context, response.response.errorMessage);
          } else if (response.response.data != null) {
            setBusy(true);
            userProfileInfo = await _authService.getUserProfileInfo(email);
            ViewUtil.showSnackBar(context, "Event Saved");
            notifyListeners();
            setBusy(false);

            //
          } else {
            setBusy(false);
            ViewUtil.showSnackBar(context, "Connection error");
          }
        }
      }
    }
  }

//   saveEvent(String eventId, String userId) async {
//     String query = """mutation  {
//    createSavedEvent(savedEvent: {event_id: $eventId, user_id: $userId}){
//     event_id
//     id
//     user_id
//     createdAt
//     updatedAt
//   }
// }""";
//     userProfileInfo = _authService.userProfileInfo!;
//     List<EventInstance> eventInstanceList = userProfileInfo!.getUser!.events!;
//     if (eventInstanceList.isNotEmpty) {
//       for (EventInstance element in eventInstanceList) {
//         if (eventId != element.id) {
//           setBusy(true);
//           var response = await _apiService.request(
//               route: ApiRoute(ApiType.searchEventsByDate),
//               data: {"query": query},
//               create: () => APIResponse<SavedEventResponse>(
//                   create: () => SavedEventResponse()));
//           setBusy(false);

//           // if (response.response.errorMessage == null) {

//           if (response.response.errorMessage != null) {
//             ViewUtil.showSnackBar(context, response.response.errorMessage);
//           } else if (response.response.data != null) {
//             setBusy(false);
//             setBusy(true);
//             userProfileInfo = await _authService.getUserProfileInfo(email);
//             setBusy(false);
//             ViewUtil.showSnackBar(context, "Event Saved");
//             // notifyListeners();
//             print(eventInstanceList.length);
//             setBusy(false);

//             //
//           } else {
//             setBusy(false);
//             ViewUtil.showSnackBar(context, "Connection error");
//           }
//         } else {
//           ViewUtil.showSnackBar(context, "Event Already Saved");
//         }
//       }
//     } else {
//       setBusy(true);
//       var response = await _apiService.request(
//           route: ApiRoute(ApiType.searchEventsByDate),
//           data: {"query": query},
//           create: () => APIResponse<SavedEventResponse>(
//               create: () => SavedEventResponse()));
//       setBusy(false);

//       // if (response.response.errorMessage == null) {

//       if (response.response.errorMessage != null) {
//         setBusy(false);
//         ViewUtil.showSnackBar(context, response.response.errorMessage);
//       } else if (response.response.data != null) {
//         setBusy(false);
//         setBusy(true);
//         userProfileInfo = await _authService.getUserProfileInfo(email);
//         ViewUtil.showSnackBar(context, "Event Saved");
//         notifyListeners();
//         setBusy(false);

//         //
//       } else {
//         setBusy(false);
//         ViewUtil.showSnackBar(context, "Connection error");
//       }
//     }
//   }
}



//   saveEvent() async {
//     String query = """mutation  {
//    createSavedEvent(savedEvent: {event_id: 2, user_id: 80}){
//     event_id
//     id
//     user_id
//     createdAt
//     updatedAt
//   }
// }""";

//     var response = await _apiService.request(
//         route: ApiRoute(ApiType.searchEventsByDate),
//         data: {"query": query},
//         create: () => APIResponse<SavedEventResponse>(
//             create: () => SavedEventResponse()));

//     // if (response.response.errorMessage == null) {

//     if (response.response.errorMessage != null) {
//       setBusy(false);
//       ViewUtil.showSnackBar(context, response.response.errorMessage);
//     }
//     if (response.response.data != null) {
//       setBusy(true);
//       //
//       setBusy(false);
//     } else {
//       setBusy(false);
//       ViewUtil.showSnackBar(context, "Connection error");
//     }
//   }