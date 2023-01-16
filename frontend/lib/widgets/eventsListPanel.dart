import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class EventsListPanel extends StatelessWidget {
  final ScrollController controller;
  final PanelController panelController;

  const EventsListPanel({
    Key? key,
    required this.panelController,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        controller: controller,
        children: <Widget>[
          dragHandle(),
          const SizedBox(height: 18),
          Center(
              child: Text('Liste des évènements',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[500],
                      fontWeight: FontWeight.w500)))
        ],
      );

  Widget dragHandle() => GestureDetector(
        onTap: togglePanel,
        child: Center(
          child: Container(
            height: 5,
            width: 40,
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(12)),
          ),
        ),
      );

  void togglePanel() => panelController.isPanelOpen
      ? panelController.close()
      : panelController.open();
}
