import 'package:flutter/material.dart';
import 'package:maating/main.dart';
import '../models/event.dart';
import '../services/requestManager.dart';
import 'eventCard.dart';
import 'package:http/http.dart' as http;

class JoinedEvents extends StatefulWidget {
  const JoinedEvents({super.key});

  @override
  State<JoinedEvents> createState() => _JoinedEventsState();
}

class _JoinedEventsState extends State<JoinedEvents> {
  late Future<List<dynamic>> eventsFuture;
  final http.Client _client = http.Client();

  String userId = sp.getString('User') ?? '';

  @override
  void initState() {
    super.initState();
    eventsFuture = RequestManager(_client).getEventsByOrganizerId(userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Évènements rejoints',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24.0,
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Center(
                child: FutureBuilder<List<Event>>(
                  future: RequestManager(_client).getEventWithParticipantId(userId),
                  builder: (
                      BuildContext context,
                      AsyncSnapshot<List<Event>> snapshot,
                      ) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: CircularProgressIndicator(
                            valueColor:
                            AlwaysStoppedAnimation<Color>(Colors.grey[500]!),
                          ),
                        ),
                      );
                    }
                    if (snapshot.hasData) {
                      return Center(
                        child: snapshot.data!.isEmpty
                            ? Padding(
                          padding: const EdgeInsets.only(top: 40),
                          child: Text(
                            'Aucun évènement trouvé',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        )
                            : ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => EventCard(
                            event: snapshot.data![index],
                          ),
                          itemCount: snapshot.data!.length,
                        ),
                      );
                    } else {
                      return const Text('Une erreur est survenue');
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget ListViewBuilder(List<Event> events) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => EventCard(
          event: events[index],
        ),
        itemCount: events.length,
      ),
    );
  }
}
