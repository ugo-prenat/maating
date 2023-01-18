import 'package:maating/models/sport.dart';

class Event {
  String? id;
  String name;
  String date;
  int duration;
  double price;
  String description;
  String sportId;
  int level;
  int maxNb;
  String organizerId;
  List<String> participantsIds;
  bool isPrivate;
  String? privateCode;
  String location;

  Event(
      this.name,
      this.date,
      this.duration,
      this.price,
      this.description,
      this.sportId,
      this.level,
      this.maxNb,
      this.organizerId,
      this.participantsIds,
      this.isPrivate,
      this.location,
      [this.id,
      this.privateCode]);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "date": date,
      "duration": duration,
      "price": price,
      "description": description,
      "sport": sportId,
      "level": level,
      "max_nb": maxNb,
      "organizer": organizerId,
      "participants": participantsIds,
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
        price = map["price"],
        description = map["description"],
        sportId = map["sport"],
        level = map["level"],
        maxNb = map["max_nb"],
        organizerId = map["organizer"],
        participantsIds = map["participants"],
        isPrivate = map["is_private"],
        privateCode = map["private_code"],
        location = map["location"];
}
