import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/get_user_info_response.dart';
import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../resources/models/event_removal_response.dart';
import '../../singleton/locator.dart';

class ProfilePageViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  // final _authService = locator<AuthenticationService>();

  final APIClient _apiService = locator<APIClient>();

  List<EventInstance> events = [];

  List<Category> categories = [];
  // List<Category> eventCategories = [];

  UserProfileInfo? userDetails;
  AllEventsResponse? allEventsResponse;
  init(BuildContext context, String email, String id) {
    // setBusy(true);
    this.context = context;
    // _authService
    //     .getUserProfileInfo(_authService.userProfileInfo!.getUser!.email!);
    // userDetails = _authService.userProfileInfo;
    // addCategoriesToList();
    getUserProfileInfo(email, id);
    getEvents(id);
    // setBusy(false);
    // eventCategories = _authService.allEventsResponse!.categories!;
  }

  // void addCategoriesToList() {
  //   List<Category> allCategories = [];
  //   // List<EventInstance> excessEvents = userDetails!.getUser!.events!;
  //   // for (EventInstance element in excessEvents) {
  //   //   if (!events.contains(element)) {
  //   //     events.add(element);
  //   //     events.toSet().toList();
  //   //   }
  //   // }
  //   for (EventInstance eventItem in events) {
  //     allCategories.add(eventItem.category!);
  //   }

  //   List<String> idList = [];
  //   for (Category element in allCategories) {
  //     // if (!categories.contains(element)) {
  //     //   categories.add(element);

  //     //   idList.add(element.id!);
  //     // }
  //   }
  //   print(idList.toSet().toList());
  //   // events = excessEvents.toSet().toList();
  //   //  categories = allCategories.toSet().toList();
  //   print(events.toString());
  // }

  getEvents(String id) async {
    setBusy(true);

    String query = """
    query { events {
    category_id  createdAt  description  duration  id  image  location latitude longitude start_time  subtitle  title updatedAt
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
          "user_id": "${id}",
          // 'accept': 'application/json',
          'content-type': 'application/json'
        },
        route: ApiRoute(ApiType.fetchEventsDetails),
        data: {"query": query},
        create: () =>
            APIResponse<AllEventsResponse>(create: () => AllEventsResponse()));

    if (response.response.data != null) {
      allEventsResponse = response.response.data;
      //events = get!.eventInstances!;
      categories = allEventsResponse!.categories!;
    }
    // setBusy(true);

    setBusy(false);
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

//   getUserProfileInfo()async{
//     setBusy(true);
//      String queryUserProfileInfo = """mutation {
//   getUser(email: "$email") {
//     updatedAt  password  name  image  id email  createdAt
//     events {
//     latitude  longitude
//       artists {
//         artist {
//           biography  createdAt  id  image  name  nationality  roles  updatedAt
//         }
//         role
//       }
//       category {
//         color  createdAt  id name  updatedAt
//       }
//       createdAt  description  duration  id  image  location  start_time  subtitle  title  updatedAt  category_id
//       users {
//         createdAt  email  id  image  name  password  updatedAt
//       }
//       isSaved {
//         createdAt  event_id  id  updatedAt  user_id
//       }
//     }
//   }
// }""";

//   }
}
