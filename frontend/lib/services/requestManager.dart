import 'dart:convert';
import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:maating/models/event.dart';
import 'package:maating/models/sport.dart';

Future<List<Event>> getMapEvents(LatLng location, int maxDistance) async {
  final response = await http.get(
    Uri.parse(
        'http://10.0.2.2:4000/events/map?lat=${location.latitude}&lng=${location.longitude}&maxDistance=$maxDistance'),
  );

  if (response.statusCode != 200) {
    return throw Exception('Failed to load events');
  }

  List<dynamic> body = jsonDecode(response.body);
  return body.map((dynamic event) => Event.fromMap(event)).toList();
}

Future<List<Event>> getEventsByLocation(LatLng location) async {
  final response = await http.get(
    Uri.parse(
        'http://10.0.2.2:4000/events?lat=${location.latitude}&lng=${location.longitude}'),
  );

  if (response.statusCode != 200) {
    return throw Exception('Failed to load events');
  }

  List<dynamic> body = jsonDecode(response.body);
  return body.map((dynamic event) => Event.fromMap(event)).toList();
}

Future<List<Sport>> getSports() async {
  final response = await http.get(
    Uri.parse('http://10.0.2.2:4000/sports'),
  );

  if (response.statusCode != 200)
    // ignore: curly_braces_in_flow_control_structures
    return throw Exception('Failed to load events');

  List<dynamic> body = jsonDecode(response.body);
  return body.map((dynamic sport) => Sport.fromMap(sport)).toList();
}
