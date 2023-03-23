import 'dart:async';
import 'dart:convert';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maating/extension/filetype.dart';
import 'package:maating/models/event.dart';
import 'package:maating/models/sport.dart';
import 'package:maating/pages/map_page.dart';
import 'package:maating/utils/backendUtils.dart';

import '../models/user.dart';

// ignore: non_constant_identifier_names
String BACK_URL = getBackendUrl();

/// Get all the events in a given area
/// @param {LatLng} location - The location of the center of the area
/// @param {int} maxDistance - The maximum distance from the center of the area
/// @returns {List<Event>} The list of events
Future<List<dynamic>> getMapEvents(LatLng location, int maxDistance) async {
  final response = await http.get(
    Uri.parse(
        '$BACK_URL/events/map?lat=${location.latitude}&lng=${location.longitude}&maxDistance=$maxDistance'),
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
  final response =
      await http.get(Uri.parse('$BACK_URL/events/participant/${id}'));
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
      '$BACK_URL/events?lat=${location.latitude}&lng=${location.longitude}${loadAllEvents ? '&maxDistance=$defaultUserMobilityRange' : ''}}',
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
    Uri.parse('$BACK_URL/sports'),
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
Future<http.Response> postUser(User user) async {
  final response = await http.post(
    Uri.parse('$BACK_URL/users'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(user.toMap()),
  );
  return response;
}

/// Get a user by id
/// @param {String} userId - The id of the user to get
/// @returns {User} The user
Future<User> getUser(String userId) async {
  final response = await http.get(
    Uri.parse('$BACK_URL/users/$userId'),
  );

  if (response.statusCode != 200) {
    return throw Exception('Failed to load user');
  }
  dynamic json = jsonDecode(response.body);
  return User.fromMap(json);
}

/// Add a user to an event
/// @param {String} eventId - The id of the event
/// @param {String} userId - The id of the user
/// @param {int} additionalPlaces - The number of additional places
/// @returns {int} The status code of the response
Future<int> addUserToEvent(
    String? eventId, String? userId, int additionalPlaces) async {
  Map<String, dynamic> body = {'participantId': userId};

  if (additionalPlaces > 0) {
    body['additionalPlaces'] = {
      'participantId': userId,
      'nbPlaces': additionalPlaces,
    };
  }

  final response = await http.post(
    Uri.parse('$BACK_URL/events/$eventId/participants'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(body),
  );
  return response.statusCode;
}

/// Login a user
/// @param {String} email - The email of the user
/// @param {String} password - The password of the user
/// @returns {Response} The response
Future<http.Response> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('$BACK_URL/users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'email': email, 'password': password}),
  );
  print('user: ${response.body}');
  return response;
}

/// Upload an image
/// @param {XFile} uploadImage - The image to upload
/// @returns {String} The url of the uploaded image
Future<dynamic> uploadImage(XFile uploadImage) async {
  var uri = Uri.parse("$BACK_URL/uploads");
  var request = http.MultipartRequest("POST", uri);

  request.headers.addAll({
    'Accept': '*/*',
    'Accept-Encoding': 'gzip, deflate, br',
    'Content-Type': 'multipart/form-data',
  });
  request.files.add(await http.MultipartFile.fromPath('file', uploadImage.path,
      filename: uploadImage.name,
      contentType: MediaType('image', getFileExtension(uploadImage.path))));
  var res = await request.send();
  if (res.statusCode == 201) {
    return jsonDecode(await res.stream.bytesToString())["url"];
  } else {
    return throw Exception('Failed to upload image');
  }
}
