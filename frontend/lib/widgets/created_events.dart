import 'package:flutter/material.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/widgets/eventCard.dart';
import 'package:http/http.dart' as http;

import '../models/event.dart';

class CreatedEvents extends StatefulWidget {
  const CreatedEvents({super.key});

  @override
  State<CreatedEvents> createState() => _CreatedEventsState();
}

class _CreatedEventsState extends State<CreatedEvents> {
  late Future<List<dynamic>> eventsFuture;
  final http.Client _client = http.Client();

  @override
  void initState() {
    super.initState();
    eventsFuture = RequestManager(_client).getEventsByOrganizerId("641852e4f92f960c8b1217a8");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'Évènements crées',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                      child: FutureBuilder<List<Event>>(
                        future: RequestManager(_client).getEventsByOrganizerId("641852e4f92f960c8b1217a8"),
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
          ),
          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    '/create_event',
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Créer un événement'),
              ),
            ),
          ),
        ],
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
