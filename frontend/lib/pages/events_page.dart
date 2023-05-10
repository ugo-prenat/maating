import 'package:flutter/material.dart';

import 'package:maating/widgets/created_events.dart';
import 'package:maating/widgets/joined_events.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TabBar(
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 64.0, vertical: 8.0),
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.0),
                  color: Colors.blue,
                ),
                labelColor: Colors.white,
                unselectedLabelColor: Colors.grey,
                tabs: const [
                  Tab(
                    text: 'Créés',
                  ),
                  Tab(
                    text: 'Rejoints',
                  ),
                ],
              ),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CreatedEvents(),
            JoinedEvents(),
          ],
        ),
      ),
    );

  }
}
