import 'package:ame/resources/models/all_events_response.dart';
import 'package:flutter/material.dart';

import '../../resources/base_view_model/base_view_model.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class ArtistPageViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  final _authService = locator<AuthenticationService>();
  List<EventInstance> artistEventList = [];

  AllEventsResponse? allEventsResponse;

  init(BuildContext context, Artist artist) {
    this.context = context;
    allEventsResponse = _authService.allEventsResponse;

    matchArtistId(artist);
    // print(allEveentsResponse!.eventInstances?.first.artists.f);
  }

  void matchArtistId(Artist artist) {
    for (EventInstance eventInstance in allEventsResponse!.eventInstances!) {
      for (Artists artists in eventInstance.artists!) {
        if (artists.artist?.id == artist.id) {
          artistEventList.add(eventInstance);
          break;
        }
      }
    }
  }

  // void returnList(Artist artist){
  // final List artistEventList = allEventsResponse!.eventInstances!.retainWhere((element) => element?.artists?[index].artist?.id == artist.id);

  // }
}
