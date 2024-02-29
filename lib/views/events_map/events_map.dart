import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../resources/utilities/view_utilities/default_scaffold.dart';
import 'events_map_view_model.dart';

class EventsMap extends StatefulWidget {
  const EventsMap({Key? key}) : super(key: key);
  static String routeName = "/insurance";

  @override
  State<EventsMap> createState() => _EventsMapState();
}

class _EventsMapState extends State<EventsMap> {
  late EventsMapViewModel model;
  final List<LatLng> locations = [
    LatLng(51.5, -0.09), // London
    LatLng(48.8566, 2.3522), // Paris
    LatLng(40.7128, -74.0060), // New York
    // Add more locations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsMapViewModel>.reactive(
      viewModelBuilder: () => EventsMapViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  center: LatLng(51.5, -0.09), // Default map center
                  zoom: 15.0,
                ),
                layers: [
                  TileLayerOptions(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: [
                        'a',
                        'b',
                        'c',
                      ]),
                  MarkerLayerOptions(
                    markers: model.locations
                        .map((location) => Marker(
                              width: 80.0,
                              height: 80.0,
                              point: location,
                              builder: (ctx) => GestureDetector(
                                onTap: () {
                                  // Perform action when marker is tapped
                                  print('Marker tapped at $location');
                                },
                                child: Container(
                                  child: Icon(Icons.location_pin),
                                ),
                              ),
                            ))
                        .toList(),
                  ),
                ],
              ),
              Positioned(
                  bottom: 20,
                  child: Container(
                    width: 100,
                    height: 40,
                    color: Colors.red,
                  ))
            ],
          ).spaceSymmetrically(horizontal: 16, vertical: 24)),
    );
  }
}
