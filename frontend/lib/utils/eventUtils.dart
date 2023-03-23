import 'package:maating/models/event.dart';

int getEventParticipantsNb(Event event) {
  // get the number of participants of an event
  int participantsNb = event.participants.length;

  // add all the additional places to the number of participants
  for (Map<String, dynamic> item in event.additionalPlaces ?? []) {
    int nbPlaces = item["nbPlaces"];
    participantsNb += nbPlaces;
  }
  return participantsNb;
}

List<Map<String, dynamic>> getEventParticipants(Event event) {
  List<Map<String, dynamic>> participants = [];

  // get all participants
  for (Map<String, dynamic> participant in event.participants) {
    participants.add({
      ...participant,
      "isOrganizer": participant["_id"] ==
          event.organizer[
              "_id"], // check if the participant is the event organizer
      "additionalPlaces":
          0, // add a field to store the number of additional places
    });
  }

  // add the number of additional places linked to each participant
  for (Map<String, dynamic> item in event.additionalPlaces ?? []) {
    int nbPlaces = item["nbPlaces"];

    Map<String, dynamic> participant = participants.firstWhere(
        (participant) => participant["_id"] == item["participantId"]);

    participant["additionalPlaces"] = nbPlaces;
  }
  return participants;
}
