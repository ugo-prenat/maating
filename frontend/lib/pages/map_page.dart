import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maating/widgets/eventsListPanel.dart';
import 'package:maating/widgets/map.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../models/event.dart';
import '../services/requestManager.dart';

const LatLng defaultCityLocation = LatLng(49.035617, 2.060325);
const int defaultUserMobilityRange = 10000;

class MapPage extends StatefulWidget {
  const MapPage({super.key});

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final panelController = PanelController();
  static const double _initialFabHeight = 116.0;
  double fabHeight = _initialFabHeight;
  LocationData? userLocation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: getMapEvents(defaultCityLocation, defaultUserMobilityRange),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<dynamic>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Stack(
              alignment: Alignment.center,
              children: <Widget>[
                const GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: defaultCityLocation,
                    zoom: 13.0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  alignment: Alignment.bottomCenter,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: <Color>[
                        Colors.black.withAlpha(0),
                        Colors.black12,
                        Colors.black45
                      ],
                    ),
                  ),
                  child: const Text(
                    'Chargement des évènements...',
                    style: TextStyle(color: Colors.white, fontSize: 15.0),
                  ),
                ),
              ],
            );
          }
          if (snapshot.hasData) {
            return PageContent(snapshot.data);
          } else {
            return const Text('Une erreur est survenue');
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget PageContent(mapEvents) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.8;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0.11;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          body: MapWidget(
            userLocation: userLocation,
            events: mapEvents,
          ),
          panelBuilder: (controller) => EventsListPanel(
            controller: controller,
            panelController: panelController,
            userLocation: userLocation,
          ),
          controller: panelController,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(13),
          ),
          parallaxEnabled: true,
          parallaxOffset: .5,
          /* onPanelSlide: (position) => {
            setState(() {
              final panelMaxScrollExtent = panelHeightOpen - panelHeightClosed;
              fabHeight = position * panelMaxScrollExtent + _initialFabHeight;
            })
          }, */
        ),
        /* Positioned(
          right: 20,
          bottom: 116,
          child: FloatingActionButton(
            onPressed: () => {},
            backgroundColor: Colors.white,
            //onPressed: onPressed,
            child: const Icon(
              Icons.my_location,
              color: Color(0xFF0085FF),
            ),
          ),
        ), */
      ],
    );
  }

  void getCurrentUserLocation() async {
    Location location = Location();
    location.getLocation().then((location) => {
          setState(() {
            userLocation = location;
          })
        });
  }
}
