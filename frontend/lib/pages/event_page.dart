import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maating/main.dart';
import 'package:maating/models/event.dart';
import 'package:maating/models/user.dart';
import 'package:maating/pages/event_participants_page.dart';
import 'package:maating/pages/event_participation_page.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/utils/eventUtils.dart';

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

    String userId = sp.getString('User') ?? '';

    int participantsNb = getEventParticipantsNb(event);
    int remainingPlaces = event.maxNb - participantsNb;
    bool isFull = remainingPlaces < 1;
    bool isAlreadyParticipating = event.participants.any(
      (participant) => participant["_id"] == userId,
    );

    return Scaffold(
      body: FutureBuilder<User>(
        future: getUser(userId),
        builder: (
          BuildContext context,
          AsyncSnapshot<User> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 40),
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey[500]!),
                ),
              ),
            );
          }
          if (snapshot.hasData) {
            return Column(
              children: [
                Thumbnail(event.location.thumbnailUrl),
                const SizedBox(height: 30),
                EventTitle(event.name),
                const SizedBox(height: 40),
                Places(event, isFull, remainingPlaces),
                const SizedBox(height: 30),
                Location(event),
                const SizedBox(height: 30),
                EventDetails(event),
                const SizedBox(height: 30),
                Level(levels[event.level - 1]),
                const SizedBox(height: 20),
                ParticipantsList(event),
                const SizedBox(height: 50),
                BottomButtons(event, snapshot.data!, event.organizer["_id"],
                    isFull, isAlreadyParticipating),
              ],
            );
          } else {
            return const Text('Une erreur est survenue');
          }
        },
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Thumbnail(String thumbnail) {
    // The thumbnail of the event
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
    // This widget displays the number of places available and the remaining places for the event
    var paddingPercentage = 0.7;
    var fullBoxWidth = MediaQuery.of(context).size.width * paddingPercentage;
    var boxWidth = MediaQuery.of(context).size.width *
        (event.maxNb - remainingPlaces) /
        event.maxNb *
        paddingPercentage; // calculation of the width of the box that will be filled

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
          "${remainingPlaces > 0 ? '$remainingPlaces' : '0'} place${remainingPlaces > 1 ? 's' : ''} disponible${remainingPlaces > 1 ? 's' : ''}",
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget Location(Event event) {
    // This widget displays the location of the event
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
  Widget EventDetails(Event event) {
    // This widget displays the details of the event
    DateTime dt = DateTime.parse(event.date);
    DateFormat dateFormatter = DateFormat('EE d MMM yyyy', 'fr');
    String eventDate = dateFormatter.format(dt); // format the date
    String eventTime = DateFormat.Hm('fr').format(dt); // format the time

    var price = event.price == 0 ? "gratuite" : "${event.price / 100}€";

    // ignore: non_constant_identifier_names
    Widget Separator() {
      return Row(
        children: const [
          SizedBox(width: 5),
          Icon(Icons.circle, size: 5),
          SizedBox(width: 5),
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
  Widget ParticipantsList(Event event) {
    // This widget displays a link to go to the participants list page
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Align(
        alignment: Alignment.centerLeft,
        child: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => EventParticipantsPage(
                  event: event,
                ),
              ),
            );
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
  Widget BottomButtons(Event event, User user, String organizerId, bool isFull,
      bool isAlreadyParticipating) {
    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25),
      child: ElevatedButton(
        onPressed: isFull || isAlreadyParticipating
            ? null
            : () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventParticipationPage(
                      user: user,
                      event: event,
                    ),
                  ),
                );
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
          // Display the appropriate text depending on the user status
          isFull
              ? 'Complet'
              : isAlreadyParticipating
                  ? 'Inscription enregistrée'
                  : 'Participer',
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
