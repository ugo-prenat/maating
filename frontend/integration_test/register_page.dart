import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maating/main.dart' as app;
import 'package:maating/pages/login_page.dart';
import 'package:maating/pages/register_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('register page', () {
    testWidgets('no given values return errors', (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      SharedPreferences.setMockInitialValues({});

      final nextBtn = find.byKey(const Key('nextButton'));

      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));
      await tester.tap(nextBtn);
      await tester.pump();

      expect(
        find.text('Veuillez renseignez votre prénom'),
        findsOneWidget,
      );
      expect(
        find.text('Veuillez renseignez un email.'),
        findsOneWidget,
      );
      expect(
        find.text('Veuillez renseignez un mot de\n passe.'),
        findsOneWidget,
      );
    });
    testWidgets('wrong input values return errors',
        (WidgetTester tester) async {
      app.main();
      await tester.pumpAndSettle();
      SharedPreferences.setMockInitialValues({});

      final firstNameInput = find.byKey(const Key('firstNameInput'));
      final emailInput = find.byKey(const Key('emailInput'));
      final passwordInput = find.byKey(const Key('passwordInput'));
      await tester.pumpWidget(const MaterialApp(home: RegisterPage()));

      await tester.enterText(firstNameInput, 'a');
      await tester.enterText(emailInput, 'a');
      await tester.enterText(passwordInput, 'a');
      await tester.pump();

      expect(
        find.text('Votre prénom doit comporter \n au moins 3 caractères.'),
        findsOneWidget,
      );
      expect(
        find.text('Mauvais format d\'email.'),
        findsOneWidget,
      );
      expect(
        find.text('Le mot de passe doit contenir \n plus de 5 caractères'),
        findsOneWidget,
      );
    });
  });
}
