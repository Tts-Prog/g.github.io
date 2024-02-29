import 'package:ame/resources/models/all_events_response.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import '../../resources/base_view_model/base_view_model.dart';
import '../../services/authentication_service.dart';
import '../../singleton/locator.dart';

class EventsMapViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;
  List<LatLng> locations = [];
  final _authService = locator<AuthenticationService>();
  List<EventInstance> events = [];
  AllEventsResponse? allEventsResponse;
  init(BuildContext context) {
    this.context = context;
    allEventsResponse = _authService.allEventsResponse;
    events = allEventsResponse!.eventInstances!;
    locations = List<LatLng>.generate(events.length,
        (index) => LatLng(events[index].latitude!, events[index].longitude!));
  }
}
