import 'package:ame/resources/models/all_events_response.dart';
import 'package:stacked/stacked.dart';

import '../api/api_client.dart';
import '../api/api_response.dart';
import '../api/api_route.dart';
import '../singleton/locator.dart';

class AuthenticationService with ListenableServiceMixin {
  final _apiService = locator<APIClient>();
  AuthenticationService() {
    //3
    listenToReactiveValues([_allEventsResponse]);
  }

  AllEventsResponse? _allEventsResponse;

  AllEventsResponse? get allEventsResponse => _allEventsResponse;

  Future<AllEventsResponse?> getAllEventsInfo() async {
    String query = """
    query { events {
    category_id  createdAt  description  duration  id  image  location  start_time  subtitle  title updatedAt
    category {  color  createdAt  id  name updatedAt  }
    users { image id  name createdAt  updatedAt }
    artists {  role  artist {  biography  createdAt  id  image  name  nationality  roles updatedAt  }}
    }
      categories {  color  createdAt  id  name  updatedAt }  }""";

    var eventsResponse = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () =>
            APIResponse<AllEventsResponse>(create: () => AllEventsResponse()));
    if (eventsResponse.response.errorMessage == null) {
      _allEventsResponse = eventsResponse.response.data!;
      //categories = eventsResponse.response.data!.categories!;
    }
    return _allEventsResponse;
  }
}
