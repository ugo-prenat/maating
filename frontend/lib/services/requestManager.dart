import 'dart:convert';
import 'dart:ffi';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:maating/models/event.dart';
import 'package:maating/models/sport.dart';
import 'package:maating/pages/map_page.dart';

import '../models/user.dart';

/// Get all the events in a given area
/// @param {LatLng} location - The location of the center of the area
/// @param {int} maxDistance - The maximum distance from the center of the area
/// @returns {List<Event>} The list of events
Future<List<dynamic>> getMapEvents(LatLng location, int maxDistance) async {
  final response = await http.get(
    Uri.parse(
        'http://localhost:4000/events/map?lat=${location.latitude}&lng=${location.longitude}&maxDistance=$maxDistance'),
  );

  if (response.statusCode != 200) {
    return throw Exception('Failed to load events');
  }

  return jsonDecode(response.body);
}

/// Get all the events where the user is an organizer
/// @param {String} id - The id of the user
/// @returns {List<Event>} The list of events
Future<List<Event>> getEventsByOrganizerId(String id) async {
  final response =
      await http.get(Uri.parse('http://localhost:4000/events/organizer/${id}'));
  if (response.statusCode != 200) {
    return throw Exception('Failed to load events');
  }
  List<dynamic> body = jsonDecode(response.body);
  return body.map((dynamic event) => Event.fromMap(event)).toList();
}

/// Get all the events where the user is a participant
/// @param {String} id - The id of the user
/// @returns {List<Event>} The list of events
Future<List<Event>> getEventWithParticipantId(String id) async {
  final response = await http
      .get(Uri.parse('http://localhost:4000/events/participant/${id}'));
  if (response.statusCode != 200) {
    return throw Exception('Failed to load events');
  }
  List<dynamic> body = jsonDecode(response.body);
  return body.map((dynamic event) => Event.fromMap(event)).toList();
}

/// Get all the events
/// @returns {List<Event>} The list of events
Future<List<Event>> getEventsByLocation(
    LatLng location, bool loadAllEvents) async {
  final response = await http.get(
    Uri.parse(
      'http://localhost:4000/events?lat=${location.latitude}&lng=${location.longitude}${loadAllEvents ? '&maxDistance=$defaultUserMobilityRange' : ''}}',
    ),
  );

  if (response.statusCode != 200) {
    return throw Exception('Failed to load events');
  }

  List<dynamic> body = jsonDecode(response.body);
  return body.map((dynamic event) => Event.fromMap(event)).toList();
}

/// Get all the sports
/// @returns {List<Sport>} The list of sports
Future<List<Sport>> getSports() async {
  final response = await http.get(
    Uri.parse('http://localhost:4000/sports'),
  );

  if (response.statusCode != 200)
    // ignore: curly_braces_in_flow_control_structures
    return throw Exception('Failed to load events');

  List<dynamic> body = jsonDecode(response.body);
  return body.map((dynamic sport) => Sport.fromMap(sport)).toList();
}

/// Create a new user
/// @param {User} user - The user to create
/// @returns {User} The created user
Future<User> postUser(User user) async {
  final response = await http.post(
    Uri.parse('http://localhost:4000/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toMap()),
  );
  if (response.statusCode == 201) {
    return User.fromMap(jsonDecode(response.body));
  } else {
    return throw Exception('Failed to create user ${response.body}');
  }
}

/// Get a user by id
/// @param {String} userId - The id of the user to get
/// @returns {User} The user
Future<User> getUser(String userId) async {
  final response = await http.get(
    Uri.parse('http://localhost:4000/users/$userId'),
  );

  if (response.statusCode != 200) {
    return throw Exception('Failed to load user');
  }
  dynamic json = jsonDecode(response.body);
  List<SportSchema> sports = json["sports"]
      .map((sportSchema) => SportSchema.fromMap(sportSchema))
      .toList()
      .cast<SportSchema>();
  return User.fromMap(jsonDecode(response.body));
}
