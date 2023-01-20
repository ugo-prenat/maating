import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/models/event.dart';
import 'package:maating/pages/map_page.dart';
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
  final bool loadAllEvents = true;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<Event>>(
          future: getEvents(widget.eventsLocation),
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
                        physics: const NeverScrollableScrollPhysics(),
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
    );
  }

  Future<List<Event>> getEvents(LatLng location) async {
    return await getEventsByLocation(location, loadAllEvents);
  }
}
