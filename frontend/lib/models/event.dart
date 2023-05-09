import 'dart:convert';

import 'package:maating/models/location.dart';
import 'package:maating/models/sport.dart';

class Event {
  String? id;
  String name;
  String date;
  int duration;
  double price;
  String description;
  Sport sport;
  int level;
  int maxNb;
  Map<String, dynamic> organizer;
  List<dynamic> participants;
  List<dynamic>? additionalPlaces;
  bool isPrivate;
  int? privateCode;
  Location location;

  Event(
    this.name,
    this.date,
    this.duration,
    this.price,
    this.description,
    this.sport,
    this.level,
    this.maxNb,
    this.organizer,
    this.participants,
    this.additionalPlaces,
    this.isPrivate,
    this.location, [
    this.id,
    this.privateCode,
  ]);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "date": date,
      "duration": duration,
      "price": price,
      "description": description,
      "sport": sport.toMap(),
      "level": level,
      "max_nb": maxNb,
      "organizer": organizer,
      "participants": participants,
      "additional_places": additionalPlaces,
      "is_private": isPrivate,
      "private_code": privateCode,
      "location": location.toMap()
    };
  }

  String toJson() => json.encode(toMap());

  Event.fromMap(Map<String, dynamic> map)
      : id = map["_id"],
        name = map["name"],
        date = map["date"],
        duration = map["duration"],
        price = (map["price"] as num).toDouble(),
        description = map["description"],
        sport = Sport.fromMap(map["sport"]),
        level = map["level"],
        maxNb = map["max_nb"],
        organizer = map["organizer"] as Map<String, dynamic>,
        participants = map["participants"] as List<dynamic>,
        additionalPlaces = map["additional_places"] as List<dynamic>,
        isPrivate = map["is_private"],
        privateCode = map["private_code"],
        location = Location.fromMap(map["location"]);
}

final rawEvent = Event(
  'name',
  'date',
  000,
  000,
  '000',
  Sport(
    'id',
    'name',
  ),
  000,
  000,
  {},
  [],
  [
    {
      "participantId": "000",
      "nbPlaces": 1,
    },
  ],
  false,
  Location(
    'id',
    'name',
    '000',
    LoctSchema(
      '000',
      [],
    ),
  ),
);
