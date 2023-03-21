import 'dart:async';
import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:maating/extension/filetype.dart';
import 'package:maating/models/event.dart';
import 'package:maating/models/sport.dart';
import 'package:maating/pages/map_page.dart';

import '../models/user.dart';

Future<List<dynamic>> getMapEvents(LatLng location, int maxDistance) async {
  final response = await http.get(
    Uri.parse(
        'http://10.0.2.2:4000/events/map?lat=${location.latitude}&lng=${location.longitude}&maxDistance=$maxDistance'),
  );

  if (response.statusCode != 200) {
    return throw Exception('Failed to load events');
  }

  return jsonDecode(response.body);
}

Future<List<Event>> getEventsByLocation(
    LatLng location, bool loadAllEvents) async {
  final response = await http.get(
    Uri.parse(
      'http://10.0.2.2:4000/events?lat=${location.latitude}&lng=${location.longitude}${loadAllEvents ? '&maxDistance=$defaultUserMobilityRange' : ''}}',
    ),
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

Future<User> postUser(User user) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:4000/users'),
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

Future<dynamic> uploadImage(XFile uploadImage) async {
  var uri = Uri.parse("http://10.0.2.2:4000/uploads");
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

Future<User> loginUser(String email, String password) async {
  final response = await http.post(
    Uri.parse('http://10.0.2.2:4000/users/login'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode({'email': email, 'password': password}),
  );
  if (response.statusCode == 201) {
    return User.fromMap(jsonDecode(response.body));
  } else {
    return throw Exception(response.body);
  }
}
