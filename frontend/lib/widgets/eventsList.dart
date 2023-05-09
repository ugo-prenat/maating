import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/models/event.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/widgets/eventCard.dart';
import 'package:http/http.dart' as http;
import '../pages/map_page.dart';

class EventsList extends StatefulWidget {
  const EventsList({
    super.key,
    required this.eventsLocation,
    required this.updateEventsLocation,
    required this.search,
  });

  final String search;
  final LatLng eventsLocation;
  final Function updateEventsLocation;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  final _client = http.Client();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder<List<Event>>(
          future: getEvents(widget.eventsLocation, widget.search),
          builder: (
            BuildContext context,
            AsyncSnapshot<List<Event>> snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 100),
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
                          padding: const EdgeInsets.only(top: 100),
                          child: Text(
                            'Aucun évènement trouvé',
                            style: TextStyle(
                              color: Colors.grey[500],
                            ),
                          ),
                        )
                      : ListViewBuilder(snapshot.data!));
            } else {
              return const Text('Une erreur est survenue');
            }
          },
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget ListViewBuilder(List<Event> events) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      color: Colors.grey[500]!,
                      size: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Text(
                        widget.eventsLocation == defaultCityLocation
                            ? 'Toutes les localisations'
                            : events[0].location.name,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500]!,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              TextButton(
                onPressed: () =>
                    widget.updateEventsLocation(defaultCityLocation),
                child: Text(
                  'Réinitialiser',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                    fontSize: 12,
                    color: Colors.grey[500]!,
                  ),
                ),
              )
            ],
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) => EventCard(
            event: events[index],
          ),
          itemCount: events.length,
        ),
      ],
    );
  }

  Future<List<Event>> getEvents(LatLng location, String search) async {
    return await RequestManager(_client)
        .getEventsByLocation(location, location == defaultCityLocation, search);
  }
}
