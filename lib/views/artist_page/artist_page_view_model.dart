import 'package:ame/resources/models/all_events_response.dart';
import 'package:flutter/material.dart';

import '../../resources/api/api_client.dart';
import '../../resources/api/api_response.dart';
import '../../resources/api/api_route.dart';
import '../../resources/base_view_model/base_view_model.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class ArtistPageViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final _authService = locator<AuthenticationService>();

  final APIClient _apiService = locator<APIClient>();
  List<EventInstance> artistEventList = [];
  List<EventInstance> events = [];
  List<Category> categories = [];

  AllEventsResponse? allEventsResponse;

  init(BuildContext context, Artist artist) {
    setBusy(true);
    this.context = context;
    getEvents(artist);
    //allEventsResponse = _authService.allEventsResponse;

    //matchArtistId(artist);
    setBusy(false);
    // print(allEveentsResponse!.eventInstances?.first.artists.f);
  }

  // void matchArtistId(Artist artist) {
  //   for (EventInstance eventInstance in allEventsResponse!.eventInstances!) {
  //     for (Artists artists in eventInstance.artists!) {
  //       if (artists.artist?.id == artist.id) {
  //         artistEventList.add(eventInstance);
  //         break;
  //       }
  //     }
  //   }
  // }

  getEvents(Artist artist) async {
    setBusy(true);

    String query = """
    query { events {
    category_id  createdAt  description  duration  id  image  location  latitude longitude  start_time  subtitle  title updatedAt
    category {  color  createdAt  id  name updatedAt  }
    users { image id  name createdAt  updatedAt }
    artists {  role  artist {  biography  createdAt  id  image  name  nationality  roles updatedAt  }}
    }
      categories {  color  createdAt  id  name  updatedAt }  }""";

    var response = await _apiService.request(
        route: ApiRoute(ApiType.checkEmail),
        data: {"query": query},
        create: () =>
            APIResponse<AllEventsResponse>(create: () => AllEventsResponse()));

    if (response.response.data != null) {
      allEventsResponse = response.response.data;
      events = allEventsResponse!.eventInstances!;
      categories = allEventsResponse!.categories!;
      for (EventInstance eventInstance in allEventsResponse!.eventInstances!) {
        for (Artists artists in eventInstance.artists!) {
          if (artists.artist?.id == artist.id) {
            artistEventList.add(eventInstance);
            break;
          }
        }
      }
    }
    // setBusy(true);

    setBusy(false);
  }

  // void returnList(Artist artist){
  // final List artistEventList = allEventsResponse!.eventInstances!.retainWhere((element) => element?.artists?[index].artist?.id == artist.id);

  // }
}
