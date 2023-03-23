import 'package:maating/utils/eventUtils.dart';
import 'package:test/test.dart';

import '../mocks/events_mock.dart';

void main() {
  test('get event participants number', () {
    expect(getEventParticipantsNb(mockEvent), 3);
  });
  test('get event participants', () {
    expect(getEventParticipants(mockEvent), groupedParticipants);
  });
}
