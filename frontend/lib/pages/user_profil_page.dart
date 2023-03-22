import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:maating/main.dart';
import 'package:maating/models/user.dart';
import 'package:maating/services/requestManager.dart';
import '../utils/backendUtils.dart';
import '../widgets/userInformations.dart';

class UserProfilPage extends StatefulWidget {
  const UserProfilPage({super.key, required this.userId});

  final String userId;
  @override
  State<UserProfilPage> createState() => _UserProfilPage();
}

class _UserProfilPage extends State<UserProfilPage> {
  String BACK_URL = getBackendUrl();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
          future: Future.wait([
            getUser(widget.userId),
            getEventWithParticipantId(widget.userId),
            getEventsByOrganizerId(widget.userId)
          ]),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingUser();
            }
            if (snapshot.hasData) {
              return LoadedUser(snapshot.data![0], snapshot.data![1].length,
                  snapshot.data![2].length);
            } else {
              return const Text('Une erreur est survenue');
            }
          }),
    );
  }

  /// Widget to display when the user is loading
  // ignore: non_constant_identifier_names
  Widget LoadingUser() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

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
                      "http://$BACK_URL${user.avatarUrl!}",
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
                sports: user.sports)
          ],
        ),
        Positioned(
            right: 30,
            top: 25,
            child: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                print("Update profile");
              },
              icon: const Icon(
                Icons.edit_outlined,
                color: Color(0xFFB8B8B8),
                size: 40,
              ),
            ))
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
