import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../models/event.dart';
import '../pages/map_page.dart';

class MapWidget extends StatefulWidget {
  const MapWidget({
    super.key,
    required this.userLocation,
    required this.events,
  });

  final LocationData? userLocation;
  final List<dynamic> events;

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
        initialCameraPosition: const CameraPosition(
          target: defaultCityLocation,
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
    for (var event in widget.events) {
      await addMarker(
        event['id'],
        LatLng(
          event['coordinates'][1],
          event['coordinates'][0],
        ),
        event['eventsNb'],
        'event',
      );
    }
  }

  addMarker(String id, LatLng position, int eventNb, String type) async {
    var marker = Marker(
      markerId: MarkerId(id),
      position: position,
      icon: await createMarkerIcon(eventNb),
    );
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
