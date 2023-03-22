import 'package:flutter/material.dart';
import 'package:maating/models/event.dart';
import 'package:maating/utils/eventUtils.dart';
import 'package:maating/utils/backendUtils.dart';

class EventParticipantsPage extends StatefulWidget {
  const EventParticipantsPage({
    required this.event,
    super.key,
  });

  final Event event;

  @override
  State<EventParticipantsPage> createState() => _EventParticpantsPageState();
}

class _EventParticpantsPageState extends State<EventParticipantsPage> {
  // ignore: non_constant_identifier_names
  String BACK_URL = getBackendUrl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Title(), ParticipantsList()],
      ),
    );
  }

// ignore: non_constant_identifier_names
  Widget Title() {
    var participantsNb = getEventParticipantsNb(widget.event);
    var isPlural = participantsNb > 1;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 15),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black26,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Liste des participants",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '$participantsNb personne${isPlural ? 's' : ''} inscrite${isPlural ? 's' : ''}',
              )
            ],
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget ParticipantsList() {
    List<Map<String, dynamic>> participants =
        getEventParticipants(widget.event);

    return Expanded(
      child: ListView.builder(
        itemCount: participants.length,
        itemBuilder: (context, index) {
          return ParticipantRow(participants[index]);
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ParticipantRow(dynamic participant) {
    return GestureDetector(
      onTap: () => {
        print('go to profile ${participant["_id"]}'),
      },
      child: Row(children: [
        Padding(
          padding: const EdgeInsets.only(left: 30, top: 10, bottom: 10),
          child: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
              '$BACK_URL${participant["avatar_url"]}',
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 10, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                participant["name"],
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: Text(
            participant["isOrganizer"] ? 'Organisateur' : '',
            style: const TextStyle(
              color: Color(0xFF0085FF),
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 30, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  participant["additionalPlaces"] > 0
                      ? '+${participant["additionalPlaces"]}'
                      : '',
                  style: const TextStyle(
                    color: Color(0xFF0085FF),
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                participant["additionalPlaces"] > 0
                    ? const Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: Icon(
                          Icons.people_alt_outlined,
                          color: Color(0xFF0085FF),
                          size: 22,
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            )),
      ]),
    );
  }
}
