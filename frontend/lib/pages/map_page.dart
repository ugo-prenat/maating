import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/widgets/mapAndPanel.dart';

import '../services/requestManager.dart';

const LatLng defaultCityLocation = LatLng(49.035617, 2.060325);
const int defaultUserMobilityRange = 10000;

class MapPage extends StatefulWidget {
  const MapPage({
    super.key,
    this.successMsg,
  });

  final String? successMsg;

  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  LatLng eventsLocation = defaultCityLocation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) =>
        {if (widget.successMsg != null) displaySnackBar(widget.successMsg!)});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<dynamic>>(
        future: getMapEvents(eventsLocation, defaultUserMobilityRange),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<dynamic>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingContent();
          }
          if (snapshot.hasData) {
            return MapAndPanel(
              events: snapshot.data!,
            );
          } else {
            return const Text('Une erreur est survenue');
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget LoadingContent() {
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

  displaySnackBar(String msg) {
    var snackBar = SnackBar(backgroundColor: Colors.green, content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
