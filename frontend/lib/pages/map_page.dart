import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/widgets/eventsListPanel.dart';
import 'package:maating/widgets/map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

const LatLng currentLocation = LatLng(49.035617, 2.060325);

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final panelController = PanelController();
  static const double _initialFabHeight = 116.0;
  double fabHeight = _initialFabHeight;

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.13;

    return Scaffold(
        body: Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          body: const MapWidget(),
          panelBuilder: (controller) => EventsListPanel(
              controller: controller, panelController: panelController),
          controller: panelController,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
          parallaxEnabled: true,
          parallaxOffset: .5,
          onPanelSlide: (position) => {
            setState(() {
              final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;
              fabHeight = position * panelMaxScrollExtent + _initialFabHeight;
            })
          },
        ),
        /* Positioned(
            right: 20,
            bottom: fabHeight,
            child: FloatingActionButton(
              onPressed: () => {},
              backgroundColor: Colors.white,
              //onPressed: onPressed,
              child: const Icon(
                Icons.my_location,
                color: Color(0xFF0085FF),
              ),
            )) */
      ],
    ));
  }
}
