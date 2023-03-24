import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maating/main.dart' as app;
import 'package:maating/pages/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('login page', () {
    testWidgets('bad email input return error', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      SharedPreferences.setMockInitialValues({});

      final emailLoginInput = find.byKey(const ValueKey('emailInput'));

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.enterText(emailLoginInput, 'test');
      await tester.pump();

      expect(find.text('Mauvais format d\'email.'), findsOneWidget);
    });
    testWidgets('bad password input return error', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      SharedPreferences.setMockInitialValues({});

      final passwordLoginInput = find.byKey(const ValueKey('passwordInput'));

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.enterText(passwordLoginInput, 'test');
      await tester.pump();

      expect(
        find.text('Le mot de passe doit contenir \n plus de 5 caractères'),
        findsOneWidget,
      );
    });
    testWidgets('bad login credentials return input errors',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      SharedPreferences.setMockInitialValues({});

      final loginButton = find.byKey(const ValueKey('loginButton'));

      await tester.pumpWidget(const MaterialApp(home: LoginPage()));
      await tester.tap(loginButton);
      await tester.pump();

      expect(
        find.text('Veuillez renseignez un mot de\n passe.'),
        findsOneWidget,
      );
      expect(
        find.text('Veuillez renseignez un email.'),
        findsOneWidget,
      );
    });
  });
}
