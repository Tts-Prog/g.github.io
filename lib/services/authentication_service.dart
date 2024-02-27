import 'package:ame/resources/models/all_events_response.dart';
import 'package:ame/resources/models/get_user_info_response.dart';
import 'package:stacked/stacked.dart';

import '../resources/api/api_client.dart';
import '../resources/api/api_response.dart';
import '../resources/api/api_route.dart';
import '../singleton/locator.dart';

class AuthenticationService with ListenableServiceMixin {
  final _apiService = locator<APIClient>();
  AuthenticationService() {
    //3
    listenToReactiveValues([
      _allEventsResponse,
    ]);
  }

  AllEventsResponse? _allEventsResponse;

  AllEventsResponse? get allEventsResponse => _allEventsResponse;

  UserProfileInfo? _userProfileInfo;
  UserProfileInfo? get userProfileInfo => _userProfileInfo;

  Future<AllEventsResponse?> getAllEventsInfo() async {
    String queryEvents = """
    query { events {
    category_id  createdAt  description  duration  id  image  location  start_time  subtitle  title updatedAt
    category {  color  createdAt  id  name updatedAt  }
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

  Future<UserProfileInfo?> getUserProfileInfo(String email) async {
    String queryUserProfileInfo = """mutation {
  getUser(email: "$email") {
    updatedAt  password  name  image  id email  createdAt events {
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
    }
  }
}""";
    var profileResponse = await _apiService.request(
        route: ApiRoute(ApiType.fetchEventsDetails),
        data: {"query": queryUserProfileInfo},
        create: () =>
            APIResponse<UserProfileInfo>(create: () => UserProfileInfo()));
    if (profileResponse.response.errorMessage == null) {
      _userProfileInfo = profileResponse.response.data!;
      //categories = eventsResponse.response.data!.categories!;
    }
    return _userProfileInfo;
  }
}
