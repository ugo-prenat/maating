import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    required this.userLocation,
    required this.defaultCityLocation,
  });

  final LocationData? userLocation;
  final LatLng defaultCityLocation;

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  late GoogleMapController _mapController;
  final Map<String, Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: widget.defaultCityLocation,
          zoom: 13.0,
        ),
        onMapCreated: (controller) async {
          _mapController = controller;
          await setEventMarkers();
        },
        markers: _markers.values.toSet(),
      ),
    );
  }

  setEventMarkers() async {
    List<Map<String, dynamic>> fakeEvents = [
      {"id": '1', "latLng": const LatLng(49.035617, 2.060325), "eventNb": 1},
      {
        "id": '2',
        "latLng": const LatLng(49.046050188140526, 2.044003490086851),
        "eventNb": 2
      },
      {
        "id": '3',
        "latLng": const LatLng(49.04495283646002, 2.032249409489712),
        "eventNb": 9
      },
      {
        "id": '4',
        "latLng": const LatLng(49.06116510689557, 2.054753637854887),
        "eventNb": 12
      },
      {
        "id": '5',
        "latLng": const LatLng(49.02371749973055, 2.0767029443089813),
        "eventNb": 3
      },
    ];
    for (var event in fakeEvents) {
      await addMarker(event['id'], event['latLng'], event['eventNb'], 'event');
    }
  }

  addMarker(String id, LatLng position, int eventNb, String type) async {
    var marker = Marker(
        markerId: MarkerId(id),
        position: position,
        icon: await createMarkerIcon(eventNb));
    setState(() {
      _markers[id] = marker;
    });
  }

  Future<BitmapDescriptor> createMarkerIcon(int clusterSize) async {
    final PictureRecorder pictureRecorder = PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final Paint paint = Paint()..color = const Color(0xFF0085FF);
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );
    const double radius = 100 / 2;
    canvas.drawCircle(
      const Offset(radius, radius),
      radius,
      paint,
    );
    textPainter.text = TextSpan(
      text: clusterSize.toString(),
      style: const TextStyle(
        fontSize: radius - 5,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        radius - textPainter.width / 2,
        radius - textPainter.height / 2,
      ),
    );
    final image = await pictureRecorder
        .endRecording()
        .toImage(radius.toInt() * 2, radius.toInt() * 2);
    final data = await image.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(data!.buffer.asUint8List());
  }
}
