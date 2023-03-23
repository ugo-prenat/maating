import 'package:maating/models/event.dart';
import 'package:maating/models/location.dart';
import 'package:maating/models/sport.dart';

Event mockEvent = Event(
  'test event',
  '1969-07-20 20:18:04Z',
  60,
  0,
  'event description',
  Sport('123', 'Football'),
  1,
  10,
  {'_id': 'da24ccbbd8', 'name': 'organizer'},
  [
    {
      '_id': '6688acee2b6c',
      'name': 'participant 1',
      'avatar': '/uploads/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg',
    },
    {
      '_id': '82174b175d',
      'name': 'participant 2',
      'avatar': '/uploads/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg',
    },
  ],
  [
    {
      'participantId': '6688acee2b6c',
      'nbPlaces': 1,
    }
  ],
  false,
  Location(
    'Go Park',
    '25 Rte de Menandon, 95300 Pontoise',
    'https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg',
    LoctSchema(
      'Point',
      [2.0, 2.0],
    ),
  ),
);

List<Map<String, dynamic>> groupedParticipants = [
  {
    '_id': '6688acee2b6c',
    'name': 'participant 1',
    'avatar': '/uploads/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg',
    'isOrganizer': false,
    'additionalPlaces': 1,
  },
  {
    '_id': '82174b175d',
    'name': 'participant 2',
    'avatar': '/uploads/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg',
    'isOrganizer': false,
    'additionalPlaces': 0,
  },
];
