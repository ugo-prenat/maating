import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/models/event.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/widgets/eventCard.dart';

class EventsList extends StatefulWidget {
  const EventsList({
    super.key,
    required this.eventsLocation,
  });

  final LatLng eventsLocation;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    debugPrint('azertyhtgfdsqxcdvfbgnhgfgfddfertjhrgfsqcsvdbfng,hjhgfddfgh');

    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: FutureBuilder<List<dynamic>>(
            future: getEventsByLocation(widget.eventsLocation),
            builder: (
              BuildContext context,
              AsyncSnapshot<List<dynamic>> snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                if (snapshot.hasData) {
                  print(snapshot.data);
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        EventCard(event: snapshot.data?[index]),
                    itemCount: snapshot.data!.length,
                  );
                } else {
                  return const Text('Aucun évènement trouvé');
                }
              } else {
                return Text('Etat: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<Event>> getEventsByLocation(LatLng location) async {
    return await getEvents(location, 10000);
  }
}
