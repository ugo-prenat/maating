import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maating/main.dart' as app;
import 'package:maating/pages/register_page2.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('register page 2', () {
    testWidgets('no given values return errors', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      SharedPreferences.setMockInitialValues({});

      final nextBtn = find.byKey(const Key('nextButton'));

      await tester.pumpWidget(
        const MaterialApp(
          home: RegisterPage2(userFirstInfo: []),
        ),
      );
      await tester.tap(nextBtn);
      await tester.pump();

      expect(
        find.text('Veuillez renseignez une date.'),
        findsOneWidget,
      );
      expect(
        find.text('Veuillez renseigner une ville.'),
        findsOneWidget,
      );
    });
  });
}
