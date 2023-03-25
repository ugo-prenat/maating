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
      body: Stack(
        children: <Widget>[
          Positioned(
            child: FutureBuilder<List<dynamic>>(
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
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'lib/assets/logo_maating_map.png',
                  fit: BoxFit.contain,
                  width: 40,
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    width: 280,
                    height: 40,
                    child: TextField(
                      readOnly: true,
                      onTap: () {},
                      cursorColor: const Color(0xFF2196F3),
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: const Icon(Icons.search_sharp),
                            onPressed: (){},
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Rechercher...',
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Color(0xFF2196F3)),
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: Image.asset(
                    'lib/assets/bell_icon.png',
                    fit: BoxFit.contain,
                    width: 40,
                    height: 40,
                  ),
                ),
              ],
            ),
          ),
        ],
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
