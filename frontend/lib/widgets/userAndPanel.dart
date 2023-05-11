import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maating/pages/update_profil_page.dart';
import 'package:maating/widgets/userCommentsList.dart';
import 'package:maating/widgets/userInformations.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import '../main.dart';
import '../models/user.dart';
import '../services/requestManager.dart';
import 'package:http/http.dart' as http;

class UserAndPanel extends StatefulWidget {
  const UserAndPanel(
      {super.key,
      required this.user,
      required this.nbParticipationsEvent,
      required this.nbOrganizationsEvent,
      required this.goBack,
      required this.onPop});

  final bool goBack;
  final User user;
  final int nbParticipationsEvent;
  final int nbOrganizationsEvent;
  final VoidCallback onPop;

  @override
  State<UserAndPanel> createState() => _UserAndPanelState();
}

class _UserAndPanelState extends State<UserAndPanel> {
  final panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    final panelHeightOpen = MediaQuery.of(context).size.height * 0.9;
    final panelHeightClosed = MediaQuery.of(context).size.height * 0;

    return Stack(
      alignment: Alignment.topCenter,
      children: <Widget>[
        SlidingUpPanel(
          body: LoadedUser(
            widget.user,
            widget.nbParticipationsEvent,
            widget.nbOrganizationsEvent,
          ),
          panel: UserCommentsList(
            userId: widget.user.id!,
            panelController: panelController,
          ),
          collapsed: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: GestureDetector(
              onTap: () => {
                panelController.isPanelClosed
                    ? panelController.open()
                    : panelController.close(),
              },
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  dragHandle(),
                  const SizedBox(height: 15),
                  Center(
                    child: Text(
                      'Liste des avis',
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          controller: panelController,
          minHeight: panelHeightClosed,
          maxHeight: panelHeightOpen,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(13),
          ),
          parallaxEnabled: true,
          parallaxOffset: .0,
        ),
      ],
    );
  }

  Widget dragHandle() => Center(
        child: Container(
          height: 5,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );

  /// Widget to display when the user is loaded
  // ignore: non_constant_identifier_names
  Widget LoadedUser(
      User user, int nbParticipationsEvent, int nbOrganizationsEvent) {
    return Center(
      child: Stack(children: [
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 75),
              child: Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color.fromARGB(255, 156, 156, 156),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                      "$BACK_URL${user.avatarUrl!}",
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: UserInfos(user),
            ),
            const SizedBox(
                height: 20, width: 300, child: Divider(thickness: 3)),
            UserInformations(
              user: user,
              nbParticipationsEvent: nbParticipationsEvent,
              nbOrganizationsEvent: nbOrganizationsEvent,
              panelController: panelController,
              sports: user.sports,
              client: http.Client(),
              onPop: () => widget.onPop(),
            )
          ],
        ),
        sp.getString('User') == user.id!
            ? Positioned(
                right: 30,
                top: 25,
                child: IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfilPage(
                                  user: user,
                                ))).then((value) => widget.onPop());
                  },
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: Color(0xFFB8B8B8),
                    size: 40,
                  ),
                ))
            : Container(),
        widget.goBack == true
            ? Positioned(
                left: 5,
                top: 30,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black26,
                  ),
                ),
              )
            : Container(),
      ]),
    );
  }

  /// Widget to display the user main informations
// ignore: non_constant_identifier_names
  Widget UserInfos(User user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          user.location,
          style: const TextStyle(
              fontSize: 16, color: Color.fromARGB(160, 0, 0, 0)),
        ),
      ],
    );
  }
}
