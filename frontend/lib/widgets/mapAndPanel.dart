import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../pages/map_page.dart';
import 'eventsListPanel.dart';
import 'map.dart';

class MapAndPanel extends StatefulWidget {
  const MapAndPanel({
    super.key,
    required this.events,
  });

  final List<dynamic> events;

  @override
  State<MapAndPanel> createState() => _MapAndPanelState();
}

class _MapAndPanelState extends State<MapAndPanel> {
  final panelController = PanelController();
  LatLng eventsLocation = defaultCityLocation;

  updateEventsLocation(LatLng newEventsLocation) {
    setState(() {
      eventsLocation = newEventsLocation;
    });
  }

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.11;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          body: MapWidget(
            events: widget.events,
            panelController: panelController,
            updateEventsLocation: (LatLng newEventsLocation) =>
                updateEventsLocation(newEventsLocation),
          ),
          panelBuilder: (controller) => EventsListPanel(
            controller: controller,
            panelController: panelController,
            eventsLocation: eventsLocation,
            updateEventsLocation: (LatLng newEventsLocation) =>
                updateEventsLocation(newEventsLocation),
          ),
          controller: panelController,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(13),
          ),
          parallaxEnabled: true,
          parallaxOffset: .5,
        ),
      ],
    );
  }
}
