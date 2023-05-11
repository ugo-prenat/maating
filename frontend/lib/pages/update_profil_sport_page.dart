import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:maating/main.dart';
import 'package:maating/models/sport.dart';
import 'package:maating/models/user.dart';
import 'package:maating/pages/register_sports_page.dart';
import 'package:maating/services/requestManager.dart';

List<LevelSchema> levels = <LevelSchema>[
  LevelSchema("Débutant", 0),
  LevelSchema("Intermédiaire", 1),
  LevelSchema("Avancé", 3),
  LevelSchema("Expert", 4)
];

class UpdateProfilSportPage extends StatefulWidget {
  const UpdateProfilSportPage({super.key, required this.sports});

  final List<SportSchema> sports;
  @override
  State<UpdateProfilSportPage> createState() => _UpdateProfilSportPage();
}

class _UpdateProfilSportPage extends State<UpdateProfilSportPage> {
  final _client = http.Client();
  String? dropdownValueSport;
  String? dropdownValueLevel;
  @override
  Widget build(BuildContext context) {
    List<Sport> dropdownValueList = [];
    return Scaffold(
        body: Stack(
      children: [
        Container(
            color: Colors.white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 10),
                    child: Image.asset(
                      'lib/assets/logo_maating_map.png',
                      fit: BoxFit.contain,
                      width: 150,
                      height: 150,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Text(
                      "Ajoute un sport \nque tu pratiques",
                      style: TextStyle(color: Colors.black, fontSize: 22),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 50),
                        child: Text(
                          "Choisis un sport",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFF0085FF),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: FutureBuilder<List<Sport>>(
                                future: RequestManager(_client).getSports(),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<List<Sport>> snapshot,
                                ) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                      child: SizedBox(
                                        height: 30,
                                        width: 30,
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  Colors.grey),
                                        ),
                                      ),
                                    );
                                  }
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    if (snapshot.hasError) {
                                      return Text(snapshot.error.toString());
                                    }
                                    if (snapshot.hasData) {
                                      snapshot.data?.map((Sport value) {
                                        var sportSchema = widget.sports
                                            .firstWhere(
                                                (sportSchema) =>
                                                    sportSchema.sport.name ==
                                                    value.name,
                                                orElse: () => SportSchema(
                                                    Sport("", ""), 0));
                                        if (sportSchema.sport.name == "") {
                                          dropdownValueList = [
                                            ...dropdownValueList,
                                            value
                                          ];
                                        }
                                      }).toList();
                                      return DropdownButton<String>(
                                        value: dropdownValueSport,
                                        underline: Container(),
                                        isExpanded: true,
                                        hint: Text(
                                          snapshot.data![0].name,
                                          style: const TextStyle(
                                              color: Colors.grey),
                                        ),
                                        items: dropdownValueList
                                            .map<DropdownMenuItem<String>>(
                                                (Sport? value) {
                                          return DropdownMenuItem<String>(
                                            value: value?.name,
                                            child: Text(
                                              value!.name,
                                            ),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            dropdownValueSport = value!;
                                          });
                                        },
                                      );
                                    } else {
                                      return const Text('Aucun autre sport');
                                    }
                                  } else {
                                    return Text(
                                        'Etat: ${snapshot.connectionState}');
                                  }
                                },
                              ),
                            )),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20, bottom: 5),
                        child: Text(
                          "Niveau",
                          style: TextStyle(fontSize: 20, color: Colors.black),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              border: Border.all(
                                color: Color(0xFF0085FF),
                                width: 1,
                              ),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButton<String>(
                                  value: dropdownValueLevel,
                                  underline: Container(),
                                  isExpanded: true,
                                  hint: Text(
                                    levels.first.name.toString(),
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                  items: levels.map<DropdownMenuItem<String>>(
                                      (LevelSchema value) {
                                    return DropdownMenuItem<String>(
                                      value: value.level.toString(),
                                      child: Text(
                                        value.name.toString(),
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropdownValueLevel = value!;
                                    });
                                  }),
                            )),
                      )
                    ],
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: SizedBox(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (dropdownValueLevel != null &&
                                dropdownValueSport != null) {
                              Sport sportSelected =
                                  dropdownValueList.firstWhere((element) =>
                                      element.name == dropdownValueSport);
                              Navigator.pop(context, [
                                ...widget.sports,
                                SportSchema(sportSelected,
                                    int.parse(dropdownValueLevel!))
                              ]);
                            } else {
                              displaySnackBar(
                                  "Veuillez renseigner le sport et votre niveau",
                                  true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0085FF)),
                          child: const Text(
                            "Ajouter +",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            )),
        Positioned(
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
        ),
      ],
    ));
  }

  displaySnackBar(String? msg, bool error) {
    var snackBar = SnackBar(
        backgroundColor: error ? Colors.red : Colors.green,
        content: Text(msg ?? ""));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
