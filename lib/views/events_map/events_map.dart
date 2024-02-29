import 'package:ame/resources/utilities/view_utilities/view_util.dart';
import 'package:ame/resources/utilities/widget_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:stacked/stacked.dart';

import '../../resources/models/all_events_response.dart';
import '../../resources/utilities/view_utilities/default_scaffold.dart';
import 'events_map_view_model.dart';

class EventsMap extends StatefulWidget {
  const EventsMap({Key? key, required this.email, required this.id})
      : super(key: key);
  final String email, id;
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
  EventInstance? eventInstance;

  String selectedId = 'All'; // Track the selected ID
  int selectedValue = 1;
  bool showEventContainer = false;
  List dayLimits = ["All days", "1 day", "2 days", "3 days"];

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EventsMapViewModel>.reactive(
      viewModelBuilder: () => EventsMapViewModel(),
      onViewModelReady: (model) {
        this.model = model;
        model.init(context, widget.id);
      },
      builder: (context, _, __) => DefaultScaffold(
          busy: model.busy,
          showAppBar: false,
          body: Stack(
            children: [
              FlutterMap(
                options: MapOptions(
                  center: LatLng(14.9189, -23.5087), // Default map center
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
                    markers:
                        //  List.generate(
                        //     model.events.length,
                        //     (index) => Marker(
                        //         point: LatLng(model.events[index].latitude!,
                        //             model.events[index].latitude!),
                        //         builder: (ctx) => GestureDetector(
                        //             onTap: () {},
                        //             child: Icon(
                        //               Icons.baby_changing_station,
                        //               size: 50,
                        //             ))
                        //   ViewUtil.customOutlineContainer(
                        //       height: 30,
                        //       width: 30,
                        //       backgroundColor: Color(int.parse(model
                        //           .events[index].category!.color!
                        //           .replaceAll("#", "0x66"))),
                        //       child: Text(model.events
                        //           .indexOf(model.events[index])
                        //           .toString())),
                        // )
                        // ))

                        model.events
                            .map((event) => Marker(
                                  width: 80.0,
                                  height: 80.0,
                                  point:
                                      LatLng(event.latitude!, event.longitude!),
                                  builder: (ctx) =>
                                      buildEventMapTag(event, selectedId),
                                ))
                            .toList(),
                  ),
                ],
              ),
              Positioned(
                top: 80,
                left: 20,
                right: 20,
                child: SizedBox(
                  height: 52,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      allCategContainer().spaceTo(right: 4),
                      ...List.generate(
                          model.categories.length,
                          (index) => categoryContainer(
                                  id: model.categories[index].id!,
                                  category: model.categories[index])
                              .spaceTo(right: 4))
                    ],
                  ),
                ).spaceTo(bottom: 20),
              ),
              Positioned(
                  bottom: 20,
                  right: 16,
                  left: 16,
                  child: buildEventContainer(eventInstance))
            ],
          )),
    );
  }

  Widget buildEventMapTag(
    EventInstance event,
    String selectedId,
  ) {
    if (selectedId != 'All' && event.categoryId != selectedId) {
      return const SizedBox.shrink();
    }

    return GestureDetector(
      onTap: () {
        // Perform action when marker is tapped
        setState(() {
          eventInstance = event;
        });
        print('Marker tapped at ${event.location}');
      },
      child: ViewUtil.customOutlineContainer(
          borderRadius: 6,
          height: 5,
          width: 5,
          alignment: Alignment.center,
          backgroundColor:
              Color(int.parse(event.category!.color!.replaceAll("#", "0x66"))),
          child: Text(model.events.indexOf(event).toString())),
    );
  }

  Widget allCategContainer() {
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedId = "All"; // Update the selected ID
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ViewUtil.eventTags(
                category: "All", tagColor: const Color(0x66E56861)),
            ViewUtil.customOutlineContainer(
                    backgroundColor: selectedId == "All"
                        ? const Color(0x66E56861)
                        : Colors.transparent,
                    width: 24,
                    height: 5,
                    child: const SizedBox())
                .spaceTo(top: 5)
          ],
        ));
  }

  Widget categoryContainer({required String id, required Category category}) {
    return GestureDetector(
        onTap: () {
          setState(() {
            selectedId = id; // Update the selected ID
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ViewUtil.eventTags(
                category: category.name! ?? "All",
                tagColor:
                    Color(int.parse(category!.color!.replaceAll("#", "0x66")))),
            ViewUtil.customOutlineContainer(
                    backgroundColor: selectedId == id
                        ? Color(
                            int.parse(category.color!.replaceAll("#", "0x66")))
                        : Colors.transparent,
                    width: 24,
                    height: 5,
                    child: const SizedBox())
                .spaceTo(top: 5)
          ],
        ));
  }

  Widget buildEventContainer(
    EventInstance? eventInstance,
  ) {
    if (showEventContainer == false && eventInstance == null) {
      // Hide the container if its ID doesn't match the selected ID, unless "All" is selected
      return const SizedBox.shrink();
    }
    return ViewUtil.eventContainer(eventInstance!, context, () async {
      // model.saveAnEvent(
      //   eventInstance.id!,
      // );
    });
  }
}
