import 'package:ame/resources/models/all_events_response.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class EventsMapViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  List<LatLng> locations = [];

  final APIClient _apiService = locator<APIClient>();
  final _authService = locator<AuthenticationService>();
  List<EventInstance> events = [];
  List<Category> categories = [];
  AllEventsResponse? allEventsResponse;
  EventInstance? eventInstance;
  init(BuildContext context, String id) {
    setBusy(true);
    this.context = context;
    getEvents(id);
    // setDefaultEvent(events[0]);

    setBusy(false);
  }

  // void setDefaultEvent(EventInstance event) {
  //   eventInstance = event;
  // }

  getEvents(String id) async {
    setBusy(true);

    String query = """
    query { events {
      
    category_id  createdAt  description  duration  id  image  location  latitude longitude  start_time  subtitle  title updatedAt
    
    isSaved {  
        createdAt  event_id  id  updatedAt  user_id  
    }
    category {  color  createdAt  id  name updatedAt  }
    users { image id  name createdAt  updatedAt }
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
      events = allEventsResponse!.eventInstances!;
      locations = List<LatLng>.generate(events.length,
          (index) => LatLng(events[index].latitude!, events[index].longitude!));
      categories = allEventsResponse!.categories!;
      // categories = allEventsResponse!.categories!;
    }
    // setBusy(true);

    setBusy(false);
  }
}
