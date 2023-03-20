import 'package:flutter/material.dart';
import 'package:maating/main.dart';
import 'package:maating/models/user.dart';
import 'package:maating/services/requestManager.dart';

class UserProfilPage extends StatefulWidget {
  const UserProfilPage({super.key, required this.userId});

  final String userId;
  @override
  State<UserProfilPage> createState() => _UserProfilPage();
}

class _UserProfilPage extends State<UserProfilPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<User>(
          future: getUser(widget.userId),
          builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Text('Chargement...');
            }
            if (snapshot.hasData) {
              return LoadedUser(snapshot.data!);
            } else {
              return const Text('Une erreur est survenue');
            }
          }),
    );
  }

  Widget LoadingUser() {
    return Container();
  }

  Widget LoadedUser(User user) {
    return Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 75),
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color.fromARGB(255, 156, 156, 156),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "http://localhost:4000${user.avatarUrl!}",
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: UserInfos(user),
          ),
          SizedBox(height: 20, width: 300, child: Divider(thickness: 3)),
          UserActivities(user),
          SizedBox(height: 20),
          UserSports(user.sports),
        ],
      ),
    );
  }

  Widget UserInfos(User user) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: Text(
            user.name,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          user.location,
          style: TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget UserActivities(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 80,
          child: Center(
            child: Column(
              children: const [
                Text(
                  "2",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0085FF)),
                ),
                Text(
                  'Événements',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  'créés',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 40),
        Container(
          width: 80,
          child: Center(
            child: Column(
              children: const [
                Text(
                  "4",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0085FF)),
                ),
                Text(
                  'Événements',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  'rejoins',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          ),
        ),
        SizedBox(width: 40),
        UserRating(user),
      ],
    );
  }

  Widget UserRating(User user) {
    if (user.personalRating == null) {
      return Container(
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
              child: Text(
                '0 avis',
                style: TextStyle(
                    fontSize: 10,
                    color: Color(0xFF0085FF),
                    decoration: TextDecoration.underline),
              ),
            ),
          ])));
    }
    return Container(
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
                    user.personalRating.toString(),
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
              child: Text(
                '${user.ratingNumber} avis',
                style: const TextStyle(
                    fontSize: 10,
                    color: Color(0xFF0085FF),
                    decoration: TextDecoration.underline),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget UserSports(List<SportSchema> list) {
    List<LevelSchema> levels = <LevelSchema>[
      LevelSchema("Débutant", 0),
      LevelSchema("Intermédiaire", 1),
      LevelSchema("Avancé", 3),
      LevelSchema("Expert", 4)
    ];

    return Column(children: [
      Center(
        child: Text("Sports pratiqués",
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
      ),
      Center(
          child: Container(
        width: 400,
        height: 300,
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.only(bottom: 5, left: 77, right: 60),
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
}
