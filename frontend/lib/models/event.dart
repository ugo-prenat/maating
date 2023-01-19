import 'package:maating/models/location.dart';
import 'package:maating/models/sport.dart';
import 'package:maating/models/user.dart';

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
  bool isPrivate;
  String? privateCode;
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
      "sport": sport,
      "level": level,
      "max_nb": maxNb,
      "organizer": organizer,
      "participants": participants,
      "is_private": isPrivate,
      "private_code": privateCode,
      "location": location
    };
  }

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
        isPrivate = map["is_private"],
        privateCode = map["private_code"],
        location = Location.fromMap(map["location"]);
}