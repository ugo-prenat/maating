import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/widgets/mapAndPanel.dart';
import 'package:http/http.dart' as http;
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../services/requestManager.dart';
import 'dart:async';

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
  final _client = http.Client();
  LatLng eventsLocation = defaultCityLocation;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => {
        if (widget.successMsg != null) displaySnackBar(widget.successMsg!),
      },
    );
  }

  var searchController = TextEditingController();

  Icon searchIcon = const Icon(Icons.search_sharp);

  clickTextField() {
    print(searchController.text.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: <Widget>[
          Positioned(
            child: FutureBuilder<List<dynamic>>(
              future: RequestManager(_client).getMapEvents(eventsLocation,
                  defaultUserMobilityRange, searchController.text),
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
                    search: searchController.text,
                    openPanel: searchController.text.isNotEmpty,
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
                      controller: searchController,
                      onChanged: (value) {
                        if (_debounce?.isActive ?? false) _debounce?.cancel();
                        _debounce =
                            Timer(const Duration(milliseconds: 500), () {
                          setState(() {
                            if (searchController.text.isNotEmpty) {
                              searchIcon = const Icon(Icons.cancel);
                            } else {
                              searchIcon = const Icon(Icons.search_sharp);
                            }
                          });
                        });
                      },
                      cursorColor: const Color(0xFF2196F3),
                      decoration: InputDecoration(
                          prefixIcon: IconButton(
                            icon: searchIcon,
                            onPressed: () {
                              setState(() {
                                if (searchController.text.isNotEmpty) {
                                  searchController.clear();
                                  searchIcon = const Icon(Icons.search_sharp);
                                }
                              });
                            },
                          ),
                          contentPadding:
                              const EdgeInsets.symmetric(horizontal: 15.0),
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Rechercher...',
                          border: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF2196F3)),
                            borderRadius: BorderRadius.circular(10),
                          )),
                      onTap: () {},
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
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
