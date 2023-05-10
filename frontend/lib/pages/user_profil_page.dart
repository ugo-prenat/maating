import 'dart:async';

import 'package:flutter/material.dart';
import 'package:maating/main.dart';
import 'package:maating/services/requestManager.dart';
import 'package:maating/widgets/userAndPanel.dart';
import '../utils/backendUtils.dart';
import 'package:http/http.dart' as http;

class UserProfilPage extends StatefulWidget {
  const UserProfilPage({super.key, required this.userId, required this.goBack});

  final bool goBack;
  final String userId;
  @override
  State<UserProfilPage> createState() => _UserProfilPage();
}

class _UserProfilPage extends State<UserProfilPage> {
  final _client = http.Client();
  String BACK_URL = getBackendUrl();

  FutureOr onPop(dynamic value) {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List>(
          future: Future.wait([
            RequestManager(_client).getUser(widget.userId),
            RequestManager(_client).getEventWithParticipantId(widget.userId),
            RequestManager(_client).getEventsByOrganizerId(widget.userId)
          ]),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingUser();
            }
            if (snapshot.hasData) {
              return UserAndPanel(
                  onPop: onPop,
                  user: snapshot.data![0],
                  nbParticipationsEvent: snapshot.data![1].length,
                  nbOrganizationsEvent: snapshot.data![2].length,
                  goBack: widget.goBack);
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
}
