import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/get_user_info_response.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../resources/api/api_client.dart';
import '../resources/api/api_response.dart';
import '../resources/api/api_route.dart';
import '../resources/models/saved_event_response.dart';
import '../resources/utilities/view_utilities/view_util.dart';
import '../singleton/locator.dart';

class AuthenticationService with ListenableServiceMixin {
  final _apiService = locator<APIClient>();
  AuthenticationService() {
    //3
    listenToReactiveValues([_allEventsResponse, _userProfileInfo]);
  }

  AllEventsResponse? _allEventsResponse;

  AllEventsResponse? get allEventsResponse => _allEventsResponse;

  UserProfileInfo? _userProfileInfo;
  UserProfileInfo? get userProfileInfo => _userProfileInfo;

  String? _userId;
  String? get userId => _userId;

  Future<AllEventsResponse?> getAllEventsInfo() async {
    String queryEvents = """
    query { events {
    category_id  createdAt  description  duration  id  image  location  start_time  subtitle  title updatedAt  latitude longitude
    category {  color  createdAt  id  name updatedAt  }
    isSaved {  createdAt  event_id  id  updatedAt  user_id  }
    users { image id  name createdAt  updatedAt }
    artists {  role  artist {  biography  createdAt  id  image  name  nationality  roles updatedAt  }}
    }
      categories {  color  createdAt  id  name  updatedAt }  }""";

    var eventsResponse = await _apiService.request(
        route: ApiRoute(ApiType.fetchEventsDetails),
        data: {"query": queryEvents},
        create: () =>
            APIResponse<AllEventsResponse>(create: () => AllEventsResponse()));
    if (eventsResponse.response.errorMessage == null) {
      _allEventsResponse = eventsResponse.response.data!;
      //categories = eventsResponse.response.data!.categories!;
    }
    return _allEventsResponse;
  }

  Future<UserProfileInfo?> getUserProfileInfo(
    String email,
  ) async {
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
          "user_id": "${_userProfileInfo!.getUser!.id!}",
          // 'accept': 'application/json',
          'content-type': 'application/json'
        },
        route: ApiRoute(ApiType.fetchEventsDetails),
        data: {"query": queryUserProfileInfo},
        create: () =>
            APIResponse<UserProfileInfo>(create: () => UserProfileInfo()));
    if (profileResponse.response.errorMessage == null) {
      _userProfileInfo = profileResponse.response.data!;
      _userId = profileResponse.response.data!.getUser!.id;
      //categories = eventsResponse.response.data!.categories!;
    }
    return _userProfileInfo;
  }

  Future<UserProfileInfo?> getUserProfileInfoManually(
      String email, String id) async {
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
          "user_id": "$id",
          // 'accept': 'application/json',
          'content-type': 'application/json'
        },
        route: ApiRoute(ApiType.fetchEventsDetails),
        data: {"query": queryUserProfileInfo},
        create: () =>
            APIResponse<UserProfileInfo>(create: () => UserProfileInfo()));
    if (profileResponse.response.errorMessage == null) {
      _userProfileInfo = profileResponse.response.data!;
      _userId = profileResponse.response.data!.getUser!.id;
      //categories = eventsResponse.response.data!.categories!;
    }
    return _userProfileInfo;
  }

  String? setId(String idUser) {
    _userId = idUser;
    return _userId;
  }
}
