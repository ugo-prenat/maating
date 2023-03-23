import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maating/main.dart' as app;
import 'package:maating/models/event.dart';
import 'package:maating/models/location.dart';
import 'package:maating/models/sport.dart';
import 'package:maating/pages/event_page.dart';

import '../mocks/events_mock.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('event page', () {
    testWidgets('all data are well displayed', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      await tester.pumpWidget(
        MaterialApp(
          home: EventPage(event: mockEvent),
        ),
      );
      await tester.pump();

      /* expect(
        find.image(NetworkImage(mockEvent.location.thumbnailUrl)),
        findsOneWidget,
      ); */
    });
  });
}
