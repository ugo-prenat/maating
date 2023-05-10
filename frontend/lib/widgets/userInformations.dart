import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maating/pages/comment_profil_add_page.dart';
import 'package:maating/widgets/userCommentsList.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:test/test.dart';
import '../main.dart';
import '../models/comment.dart';
import '../models/event.dart';
import '../models/user.dart';
import '../services/requestManager.dart';

class UserInformations extends StatelessWidget {
  final User user;
  final int nbParticipationsEvent;
  final int nbOrganizationsEvent;
  final List<SportSchema> sports;
  final PanelController panelController;
  final client;
  final VoidCallback onPop;

  const UserInformations(
      {Key? key,
      required this.onPop,
      required this.user,
      required this.nbParticipationsEvent,
      required this.nbOrganizationsEvent,
      required this.panelController,
      required this.sports,
      required this.client})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserActivities(
            user, nbParticipationsEvent, nbOrganizationsEvent, context),
        const SizedBox(height: 20),
        UserSports(user.sports),
        sp.getString('User') != user.id!
            ? RateButton(client, context, user)
            : Container(),
      ],
    );
  }

  /// Widget to display the user activities
// ignore: non_constant_identifier_names
  Widget UserActivities(
      User user, int nbParticipationsEvent, int nbOrganizationsEvent, context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 80,
          child: Center(
            child: Column(
              children: [
                Text(
                  nbOrganizationsEvent.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0085FF)),
                ),
                const Text(
                  'Événements',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
                const Text(
                  'créés',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40),
        SizedBox(
          width: 80,
          child: Center(
            child: Column(
              children: [
                Text(
                  nbParticipationsEvent.toString(),
                  style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0085FF)),
                ),
                const Text(
                  'Événements',
                  style: TextStyle(fontSize: 10),
                ),
                const Text(
                  'rejoins',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 40),
        UserRating(user, context),
      ],
    );
  }

  /// Widget to display the user ratings
// ignore: non_constant_identifier_names
  Widget UserRating(User user, context) {
    if (user.ratingNumber == 0) {
      return SizedBox(
          width: 80,
          child: Center(
              child: Column(children: const [
            Padding(
              padding: EdgeInsets.only(top: 6),
              child: Text(
                "Pas de note",
                style: TextStyle(
                  fontSize: 12,
                  color: Color(0xFF0085FF),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 8,
              ),
              child: Text('0 avis',
                  style: TextStyle(fontSize: 10, color: Color(0xFF0085FF))),
            ),
          ])));
    }
    return SizedBox(
      width: 80,
      child: Center(
        child: Column(
          children: [
            Row(
              children: [
                const Icon(
                  Icons.star,
                  color: Color(0xFF0085FF),
                  size: 25,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 4),
                  child: Text(
                    user.personalRating!.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 20,
                      color: Color(0xFF0085FF),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 4, right: 8),
                child: RichText(
                  text: TextSpan(
                    text: '${user.ratingNumber} avis',
                    style: const TextStyle(
                        fontSize: 10,
                        color: Color(0xFF0085FF),
                        decoration: TextDecoration.underline),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        panelController.open();
                      },
                  ),
                )),
          ],
        ),
      ),
    );
  }

  /// Widget to display the user sports
// ignore: non_constant_identifier_names
  Widget UserSports(List<SportSchema> list) {
    List<LevelSchema> levels = <LevelSchema>[
      LevelSchema("Débutant", 0),
      LevelSchema("Intermédiaire", 1),
      LevelSchema("Avancé", 3),
      LevelSchema("Expert", 4)
    ];

    return Column(children: [
      const Center(
        child: Text("Sports pratiqués",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      Center(
          child: SizedBox(
        width: 320,
        height: 180,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      list[index].sport.name,
                      style: const TextStyle(fontSize: 20),
                    ),
                    Text(
                      levels
                          .firstWhere(
                              (level) => level.level == list[index].level)
                          .name,
                      style: const TextStyle(
                          color: Color(0xFF0085FF), fontSize: 14),
                    )
                  ],
                ));
          },
          itemCount: list.length,
        ),
      ))
    ]);
  }

  /// Widget to the button to rate the user
// ignore: non_constant_identifier_names
  Widget RateButton(_client, context, user) {
    return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: SizedBox(
          width: 280,
          height: 40,
          child: ElevatedButton(
            onPressed: () async {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return CommentProfilAddPage(
                  user: user,
                );
              })).then((_) => onPop());
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color(0xFF0085FF),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            child: const Text('NOTER L\'UTILISATEUR',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
          ),
        ));
  }
}
