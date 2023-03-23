import 'package:maating/models/event.dart';

int getEventParticipantsNb(Event event) {
  int participantsNb = event.participants.length;

  for (Map<String, dynamic> item in event.additionalPlaces ?? []) {
    int nbPlaces = item["nbPlaces"];
    participantsNb += nbPlaces;
  }
  return participantsNb;
}

List<Map<String, dynamic>> getEventParticipants(Event event) {
  List<Map<String, dynamic>> participants = [];

  for (Map<String, dynamic> participant in event.participants) {
    participants.add({
      ...participant,
      "isOrganizer": participant["_id"] == event.organizer["_id"],
      "additionalPlaces": 0,
    });
  }

  for (Map<String, dynamic> item in event.additionalPlaces ?? []) {
    int nbPlaces = item["nbPlaces"];

    Map<String, dynamic> participant = participants.firstWhere(
        (participant) => participant["_id"] == item["participantId"]);

    participant["additionalPlaces"] = nbPlaces;
  }
  return participants;
}
