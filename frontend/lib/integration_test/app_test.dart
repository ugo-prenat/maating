import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:maating/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('email input false, inform user', (tester) async {
      app.main();

      await tester.pumpAndSettle();
      final emailLoginInput = find.byKey(const Key('emailLogin'));
      await tester.enterText(emailLoginInput, 'test');
      await tester.pump();

      expect(find.text('Mauvais format d\'email.'), findsOneWidget);
    });
  });
}
