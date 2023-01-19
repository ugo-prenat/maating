import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:maating/models/event.dart';
import 'package:maating/widgets/eventsList.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../pages/map_page.dart';

class EventsListPanel extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;
  final LocationData? userLocation;

  const EventsListPanel({
    Key? key,
    required this.panelController,
    required this.controller,
    required this.userLocation,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        padding: const EdgeInsets.only(top: 20),
        controller: controller,
        children: <Widget>[
          GestureDetector(
            onTap: togglePanel,
            child: Column(
              children: [
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
          const EventsList(
            eventsLocation: defaultCityLocation,
          )
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
