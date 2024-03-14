import 'package:ame/resources/size_utilities/size_fitter.dart';
import 'package:ame/resources/theme_utilities/app_colors.dart';
import 'package:ame/resources/theme_utilities/theme_extensions.dart';
import 'package:ame/resources/utilities/app_assets.dart';
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
  // final List<LatLng> locations = [
  //   LatLng(51.5, -0.09), // London
  //   LatLng(48.8566, 2.3522), // Paris
  //   LatLng(40.7128, -74.0060), // New York
  //   // Add more locations as needed
  // ];
  EventInstance? eventInstance;

  String selectedId = 'All'; // Track the selected ID
  int selectedValue = 1;
  bool showEventContainer = false;
  List dayLimits = ["All days", "1 day", "2 days", "3 days"];
  MapController mapController = MapController();
  void _focusMapOnLocation(double latitude, double longitude) {
    // Move the map to the specified location and zoom level
    setState(() {
      // Define the location you want to focus on
      final LatLng location =
          LatLng(latitude, longitude); // Example: London, UK
      final double zoom = 13.0;
      mapController.move(location, zoom);
    });
  }

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
                mapController: mapController,
                options: MapOptions(
                  center: LatLng(14.9189, -23.5087), // Default map center
                  zoom: 15.0,
                ),
                children: [
                  TileLayer(
                      urlTemplate:
                          "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                      subdomains: [
                        'a',
                        'b',
                        'c',
                      ]),
                  MarkerLayer(
                    markers: model.events
                        .map((event) => Marker(
                              width: 80.0,
                              height: 80.0,
                              point: LatLng(event.latitude!, event.longitude!),
                              child: buildEventMapTag(event, selectedId),
                            ))
                        .toList(),
                  ),
                  // MarkerLayerOptions(
                  //   markers: model.events
                  //       .map((event) => Marker(
                  //             width: 80.0,
                  //             height: 80.0,
                  //             point: LatLng(event.latitude!, event.longitude!),
                  //             builder: (ctx) =>
                  //                 buildEventMapTag(event, selectedId),
                  //           ))
                  //       .toList(),
                  // ),
                ],
              ),
              Positioned(
                top: 40,
                left: 20,
                right: 20,
                child: Column(
                  children: [
                    ViewUtil.customOutlineContainer(
                      backgroundColor: Colors.white,
                      borderRadius: 12,
                      child: Autocomplete<EventInstance>(
                        optionsBuilder: (textValue) {
                          return model.events.where((element) => element.title!
                              .toLowerCase()
                              .contains(textValue.text.toLowerCase()));
                        },
                        onSelected: (option) {
                          setState(() {
                            selectedId = "All";
                            _focusMapOnLocation(
                                option.latitude!, option.longitude!);
                            print(option.longitude!);
                            eventInstance = option;
                            showEventContainer = true;
                          });
                        },
                        fieldViewBuilder: (BuildContext context,
                            TextEditingController textEditingController,
                            FocusNode focusNode,
                            VoidCallback onFieldSubmitted) {
                          return TextField(
                            controller: textEditingController,
                            focusNode: focusNode,
                            decoration: const InputDecoration(
                                labelText: 'Find An Event',
                                labelStyle: TextStyle(
                                    color: AppColors.typographySubColor)),
                          );
                        },
                        displayStringForOption: (obj) => obj.title!,
                        optionsViewBuilder: (context, onSelected, options) {
                          return ListView.builder(
                              itemCount: options.length,
                              itemBuilder: (context, ind) {
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(options.toList()[ind]);
                                  },
                                  child: ViewUtil.customOutlineContainer(
                                    //width: 200.w,
                                    borderRadius: 12,
                                    backgroundColor: Colors.white,
                                    child: Text(
                                      options.toList()[ind].title ?? "",
                                      style: const TextStyle().bodyMedium,
                                    ).spaceSymmetrically(
                                        horizontal: 12, vertical: 12),
                                  ).spaceTo(bottom: 6, right: 50),
                                );
                              });
                        },
                      ),
                    ).spaceTo(bottom: 12),
                    SizedBox(
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
                  ],
                ),
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

    return SizedBox(
      width: 50,
      height: 50,
      child: Stack(
        children: [
          Image.asset(
            AppAssets.mapMarker,
            height: 100,
            width: 120,
            scale: 4,
          ),
          Positioned(
            left: 016,
            right: 35,
            top: 9,
            child: GestureDetector(
              onTap: () {
                // Perform action when marker is tapped
                setState(() {
                  eventInstance = event;
                  showEventContainer = true;
                });
                print('Marker tapped at ${event.location}');
              },
              child: ViewUtil.customOutlineContainer(
                  borderRadius: 6,
                  height: 30,
                  width: 20,
                  alignment: Alignment.center,
                  backgroundColor: Color(int.parse(
                          event.category!.color!.replaceAll("#", "0x66")))
                      .withOpacity(1),
                  child: Text(
                    model.events.indexOf(event).toString(),
                    style: const TextStyle(color: Colors.white),
                  )),
            ),
          ),
        ],
      ),
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
                    borderRadius: 8,
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
                    borderRadius: 8,
                    child: const SizedBox())
                .spaceTo(top: 5)
          ],
        ));
  }

  Widget buildEventContainer(
    EventInstance? eventInstance,
  ) {
    if (showEventContainer == false || eventInstance == null) {
      // Hide the container if its ID doesn't match the selected ID, unless "All" is selected
      return const SizedBox.shrink();
    }
    return Stack(
      children: [
        ViewUtil.searchEventContainer(eventInstance!, context, () async {
          // model.saveAnEvent(
          //   eventInstance.id!,
          // );
        }),
        Positioned(
            bottom: 12,
            right: 12,
            child: GestureDetector(
              onTap: () {
                setState(() {
                  showEventContainer = false;
                });
              },
              child: const Icon(
                Icons.close,
                size: 20,
              ),
            ))
      ],
    );
  }
}
