import 'package:ame/resources/api/api_response.dart';
import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/fetch_characters.dart';
import 'package:ame/resources/models/saved_event_response.dart';
import 'package:ame/services/authentication_service.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/event_removal_response.dart';
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
  FocusNode searchNode = FocusNode();
  bool searchPrefixShow() {
    return !searchNode.hasFocus;
  }

  init2(BuildContext context) {
    this.context = context;
  }

  init(BuildContext context, String id) {
    // setBusy(true);

    this.context = context;

    getEvents(id);
    //  setBusy(false);
  }

  getEvents(String id) async {
    setBusy(true);

    String query = """
    query { events {
    category_id  createdAt  description  duration  id  image  location  latitude longitude  start_time  subtitle  title updatedAt
    category {  color  createdAt  id  name updatedAt  }
    users { image id  name createdAt  updatedAt }
    isSaved {  
        createdAt  event_id  id  updatedAt  user_id  
    }
    artists {  role  artist {  biography  createdAt  id  image  name  nationality  roles updatedAt  }}
    }
      categories {  color  createdAt  id  name  updatedAt }  }""";

    var response = await _apiService.request(
        header: {
          "user_id": "$id",
          // 'accept': 'application/json',
          'content-type': 'application/json'
        },
        route: ApiRoute(ApiType.fetchEventsDetails),
        data: {"query": query},
        create: () =>
            APIResponse<AllEventsResponse>(create: () => AllEventsResponse()));

    if (response.response.data != null) {
      allEventsResponse = response.response.data;
      events = allEventsResponse!.eventInstances!;
      categories = allEventsResponse!.categories!;
    }
    // setBusy(true);

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

  saveAnEvent(EventInstance eventInstance, String id) async {
    String query = """mutation  {
   createSavedEvent(savedEvent: {event_id: ${eventInstance.id}, user_id: $id}){
    event_id
    id
    user_id
    createdAt
    updatedAt
  }
}""";

    if (eventInstance.isSaved == null) {
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

        // userProfileInfo = await _authService.getUserProfileInfo(email);
        ViewUtil.showSnackBar(context, "Event Saved");
        events.remove(eventInstance);
        notifyListeners();
        setBusy(false);

        //
      } else {
        setBusy(false);
        ViewUtil.showSnackBar(context, "Connection error");
      }
    } else {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Saved Already");
    }
  }

  removeSavedEvent(EventInstance eventInstance, String id) async {
    String removeSavedEventId = eventInstance.isSaved!.id!;
    String query = """
mutation RemoveSavedEvent {
  removeSavedEvent(id: "$removeSavedEventId")
}
""";

    var response = await _apiService.request(
        header: {
          "user_id": "$id",
          // 'accept': 'application/json',
          'content-type': 'application/json'
        },
        route: ApiRoute(
          ApiType.removeSavedEvent,
        ),
        data: {"query": query},
        create: () => APIResponse<EventRemovalResponse>(
            create: () => EventRemovalResponse()));

    if (response.response.data!.removeSavedEvent == false) {
      setBusy(false);
      ViewUtil.showSnackBar(context, "Event Not Found");
    } else if (response.response.data!.removeSavedEvent == true) {
      setBusy(false);
      events.remove(eventInstance);
      ViewUtil.showSnackBar(context, "Event removed");
    } else {
      ViewUtil.showSnackBar(context, response.response.errorMessage);
      setBusy(false);
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