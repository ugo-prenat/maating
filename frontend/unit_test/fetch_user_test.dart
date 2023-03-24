import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:maating/models/user.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/utils/backendUtils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:maating/main.dart';

import '../test/fetch_user_test.mocks.dart';

// Generate a MockClient using the Mockito package.
// Create new instances of this class in each test.
@GenerateMocks([http.Client])
void main() {
  final getEndpoint =
      Uri.parse('${getBackendUrl()}/users/641c2057121177f07de7adaa');
  group("Fetch User", () {
    test("return a User if the http call completes successfully", () async {
      // Create a new MockClient.
      final client = MockClient();

      when(
        client.get(getEndpoint),
      ).thenAnswer((_) async => http.Response(
          '{"_id":"641c2057121177f07de7adaa","name":"Léo","sports":[{"sport":{"_id":"641874ffbbd41bbf75ab4575","name":"Golf"},"level":4}],"email":"leo@text.com","password":"\$2b\$10\$hGVVoyI82I5S2jzE4jFe2.rh0YfWL99M6WqozSdfZ36rOFb6wJjiW","birth_date":"23/03/2023","location":"Cergy","mobility_range":28000,"avatar_url":"/uploads/1679564301610-test/image_picker_2e88fcb4-35fe-4aa7-ad26-f95e195a1a47-99380-00016d379d6edbda.jpg","personal_rating":0,"rating_nb":0}',
          200));
      expect(await RequestManager(client).getUser("641c2057121177f07de7adaa"),
          isA<User>());
    });

    // Test that the correct exception is thrown if the http call completes with
    // test('throws an exception if the http call completes with an error',
    //     () async {
    //   final client = MockClient();

    //   // Use Mockito to return an unsuccessful response when it calls the
    //   // provided http.Client.
    //   when(client.get(getEndpoint))
    //       .thenAnswer((_) async => http.Response('Failed to load user', 500));

    //   expect(await RequestManager(client).getUser("641c2057121177f07de7adaa"),
    //       throwsException);
    // });
  });
}
