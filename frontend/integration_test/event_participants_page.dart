import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maating/main.dart' as app;
import 'package:maating/pages/event_participants_page.dart';
import 'package:maating/utils/backendUtils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/events_mock.dart';

// ignore: non_constant_identifier_names
String BACK_URL = getBackendUrl();

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('event participants page', () {
    testWidgets('all data are well displayed', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();

      SharedPreferences.setMockInitialValues({});

      await tester.pumpWidget(
        MaterialApp(
          home: EventParticipantsPage(event: mockEvent),
        ),
      );
      await tester.pump();

      expect(find.text('4 personnes inscrites'), findsOneWidget);
      expect(find.text('Organisateur'), findsOneWidget);
      expect(find.text('+1'), findsOneWidget);
      expect(find.byIcon(Icons.people_alt_outlined), findsOneWidget);

      expect(find.text('participant 0'), findsOneWidget);
      expect(find.text('participant 1'), findsOneWidget);
      expect(find.text('participant 2'), findsOneWidget);
    });
  });
}
