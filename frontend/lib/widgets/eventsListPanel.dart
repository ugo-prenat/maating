import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:maating/widgets/eventsList.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventsListPanel extends StatelessWidget {
  final PanelController panelController;
  final LatLng eventsLocation;
  final Function updateEventsLocation;
  final String search;

  const EventsListPanel(
      {Key? key,
      required this.panelController,
      required this.eventsLocation,
      required this.updateEventsLocation,
      required this.search})
      : super(key: key);

  @override
  Widget build(BuildContext context) => Stack(
        children: <Widget>[
          ListView(
            padding: const EdgeInsets.only(top: 20),
            children: <Widget>[
              EventsList(
                search: search,
                eventsLocation: eventsLocation,
                updateEventsLocation: (LatLng newEventsLocation) =>
                    updateEventsLocation(newEventsLocation),
              ),
            ],
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 80.0,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: GestureDetector(
                onTap: togglePanel,
                child: Column(
                  children: [
                    const SizedBox(height: 20),
                    dragHandle(),
                    const SizedBox(height: 15),
                    Center(
                      child: Text(
                        'Liste des évènements',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.grey[500],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );

  Widget dragHandle() => Center(
        child: Container(
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
