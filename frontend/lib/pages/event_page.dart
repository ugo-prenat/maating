import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maating/models/event.dart';

class EventPage extends StatefulWidget {
  const EventPage({
    required this.event,
    super.key,
  });

  final Event event;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    const levels = <String>[
      'Débutant',
      'Intermédiaire',
      'Avancé',
      'Expert',
    ];
    final event = ModalRoute.of(context)!.settings.arguments as Event;
    var remainingPlaces = event.maxNb - event.participants.length;
    var isFull = remainingPlaces == 0;

    return Scaffold(
      body: Column(
        children: [
          Thumbnail(event.location.thumbnailUrl),
          const SizedBox(height: 30),
          EventTitle(event.name),
          const SizedBox(height: 40),
          Places(event, isFull, remainingPlaces),
          const SizedBox(height: 30),
          Location(event),
          const SizedBox(height: 30),
          EventDtails(event),
          const SizedBox(height: 30),
          Level(levels[event.level - 1]),
          const SizedBox(height: 20),
          ParticipantsList(event.participants),
          const SizedBox(height: 50),
          BottomButtons(event.id, event.organizer["_id"], isFull),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Thumbnail(String thumbnail) {
    return Stack(
      children: [
        FittedBox(
          fit: BoxFit.cover,
          child: Image.network(
            thumbnail,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 5),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget EventTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          title,
          textAlign: TextAlign.left,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Places(Event event, bool isFull, int remainingPlaces) {
    var paddingPercentage = 0.7;
    var fullBoxWidth = MediaQuery.of(context).size.width * paddingPercentage;
    var boxWidth = MediaQuery.of(context).size.width *
        (event.maxNb - remainingPlaces) /
        event.maxNb *
        paddingPercentage;

    return Column(
      children: [
        Stack(
          alignment: isFull ? Alignment.center : Alignment.centerLeft,
          children: [
            SizedBox(
              width: boxWidth,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isFull ? Colors.red : const Color(0xFF0085FF),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
              ),
            ),
            SizedBox(
              width: fullBoxWidth,
              height: 20.0,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: isFull
                      ? Colors.red
                      : const Color.fromARGB(80, 0, 132, 255),
                  borderRadius: const BorderRadius.all(Radius.circular(6)),
                ),
              ),
            ),
            Text(
              isFull ? 'Complet' : '',
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.people_alt_outlined,
              color: Colors.black,
            ),
            const SizedBox(width: 5),
            Text("${event.maxNb} max.", style: const TextStyle(fontSize: 15)),
          ],
        ),
        Text(
          "$remainingPlaces place${remainingPlaces > 1 ? 's' : ''} disponible${remainingPlaces > 1 ? 's' : ''}",
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget Location(Event event) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              event.location.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(event.location.address),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget EventDtails(Event event) {
    DateTime dt = DateTime.parse(event.date);
    DateFormat dateFormatter = DateFormat('EE d MMM yyyy', 'fr');
    String eventDate = dateFormatter.format(dt);
    String eventTime = DateFormat.Hm('fr').format(dt);

    var price = event.price == 0 ? "gratuite" : "${event.price / 100}€";

    // ignore: non_constant_identifier_names
    Widget Separator() {
      return Row(
        // ignore: prefer_const_literals_to_create_immutables
        children: [
          const SizedBox(width: 5),
          const Icon(Icons.circle, size: 5),
          const SizedBox(width: 5),
        ],
      );
    }

    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              eventDate,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: Row(children: [
              Text(eventTime),
              Separator(),
              Text("Durée ${(event.duration / 60).round()}h"),
              Separator(),
              Text("Entrée $price"),
            ]),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Level(String level) {
    return Padding(
      padding: const EdgeInsets.only(left: 25),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          "Niveau $level",
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ParticipantsList(List<dynamic> participants) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            print('go to participants list page');
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Text(
                'Voir la liste des participants',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.black, size: 20),
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget BottomButtons(String? eventId, String organizerId, bool isFull) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ElevatedButton(
        onPressed: isFull
            ? null
            : () {
                print('pariticpate to event $eventId');
              },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          backgroundColor: const Color(0xFF0085FF),
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 7.0,
          ),
        ),
        child: Text(
          isFull ? 'Complet' : 'Participer',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}