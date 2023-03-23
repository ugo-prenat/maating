import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maating/main.dart' as app;
import 'package:maating/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('register page', () {
    testWidgets('no given values return errors', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      SharedPreferences.setMockInitialValues({});

      final firstNameInput = find.byKey(const Key('firstNameInput'));

      expect(find.text('Mauvais format d\'email.'), findsOneWidget);
    });
  });
}
