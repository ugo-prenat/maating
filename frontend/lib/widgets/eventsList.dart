import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maating/widgets/eventCard.dart';

class EventsList extends StatefulWidget {
  const EventsList({
    super.key,
    required this.eventsLocation,
  });

  final LatLng eventsLocation;

  @override
  State<EventsList> createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: FutureBuilder(
            future: getEventsByLocation(widget.eventsLocation),
            builder: (
              BuildContext context,
              AsyncSnapshot snapshot,
            ) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasError) {
                  print('Snapshot error : ${snapshot.error}');
                  return const Text('Une erreur est survenue');
                }
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) =>
                        EventCard(event: snapshot.data[index]),
                    itemCount: snapshot.data.length,
                  );
                } else {
                  return const Text('Aucun évènement trouvé');
                }
              } else {
                return Text('Etat: ${snapshot.connectionState}');
              }
            },
          ),
        ),
      ),
    );
  }

  Future<List<Map<String, dynamic>>> getEventsByLocation(
      LatLng location) async {
    // call API to get events by location

    List<Map<String, dynamic>> fakeEvents = [
      {
        "_id": "63bdb1870071a2fb0c02d9dc",
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "_id": "63bdb1870071a2fb0c02d9dc",
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-22T14:45:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "_id": "63bdb1870071a2fb0c02d9dc",
        "name": "Futsal au Go park",
        "date": "2023-01-23T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"},
          {"_id": "63bdaa841ed632860b9e5976"},
          {"_id": "63bdaa841ed632860b9e5976"},
          {"_id": "63bdaa841ed632860b9e5976"},
          {"_id": "63bdaa841ed632860b9e5976"},
          {"_id": "63bdaa841ed632860b9e5976"},
          {"_id": "63bdaa841ed632860b9e5976"},
          {"_id": "63bdaa841ed632860b9e5976"},
        ],
        "is_private": true,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "_id": "63bdb1870071a2fb0c02d9dc",
        "name": "Foot au Stade Salif Keita",
        "date": "2023-02-01T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "_id": "63bdb1870071a2fb0c02d9dc",
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": true,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": false,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
      {
        "name": "Futsal au Go park",
        "date": "2023-01-21T20:00:00.667+00:00",
        "duration": 120,
        "sport": {"name": "Futsal"},
        "max_nb": 10,
        "organizer": {
          "_id": "63bdaa4597bfb3347b2d1b52",
          "firstname": "Donald",
          "lastname": "Dupuis",
          "avatar_url": "/uploads/1673516420232-test/user01.jpeg",
          "personal_rating": 4.2,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
          {"_id": "63bdaa841ed632860b9e5976"}
        ],
        "is_private": false,
        "location": {
          "address": "25 Rte de Menandon, 95300 Pontoise",
          "thumbnail_url":
              "https://www.gopark.fr/files/dsc00141_82174b175dda24ccbbd86688acee2b6c.jpg",
        }
      },
      {
        "name": "Foot au Stade Salif Keita",
        "date": "2023-01-21T19:30:00.667+00:00",
        "duration": 60,
        "sport": {"name": "Football"},
        "max_nb": 5,
        "organizer": {
          "_id": "63bdaa841ed632860b9e5976",
          "firstname": "François",
          "lastname": "Lemont",
          "avatar_url": "/uploads/1673516444454-test/user02.png",
          "personal_rating": 3.8,
        },
        "participants": [
          {"_id": "63bdaa4597bfb3347b2d1b52"},
        ],
        "is_private": true,
        "location": {
          "address": "7 Bd d’Osny, 95800 Cergy",
          "thumbnail_url":
              "https://archello.s3.eu-central-1.amazonaws.com/images/2016/11/03/BCSALIF-KEITA04.1506082876.5663.jpg",
        }
      },
    ];

    await Future.delayed(const Duration(seconds: 5));
    return fakeEvents;
  }
}
