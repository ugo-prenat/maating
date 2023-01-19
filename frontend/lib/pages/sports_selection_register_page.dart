import 'dart:io';

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

class SportSelectionRegisterPage extends StatefulWidget {
  const SportSelectionRegisterPage({super.key, required this.sports});

  final List<SportSchema> sports;
  @override
  State<SportSelectionRegisterPage> createState() =>
      _SportSelectionRegisterPage();
}

class _SportSelectionRegisterPage extends State<SportSelectionRegisterPage> {
  Sport? dropdownValueSport;
  String? dropdownValueLevel;
  @override
  Widget build(BuildContext context) {
    List<Sport> dropdownValueList = [];
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF2196F3),
          elevation: 0.0,
        ),
        body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Color(0xFF2196F3), Color(0xFF000000)],
                  begin: FractionalOffset.topCenter,
                  end: FractionalOffset.bottomCenter,
                  stops: [0.0, 1.0],
                  tileMode: TileMode.clamp),
            ),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Image.asset(
                      'lib/assets/logo_maating.png',
                      fit: BoxFit.contain,
                      width: 150,
                      height: 150,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(bottom: 5, top: 50),
                        child: Text(
                          "Choisis un sport",
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: FutureBuilder<List<Sport>>(
                                future: getSports(),
                                builder: (
                                  BuildContext context,
                                  AsyncSnapshot<List<Sport>> snapshot,
                                ) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.grey),
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
                                                    value,
                                                orElse: () => SportSchema(
                                                    Sport("", ""), 0));
                                        if (sportSchema.sport.name == "") {
                                          dropdownValueList = [
                                            ...dropdownValueList,
                                            value
                                          ];
                                        }
                                      }).toList();
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        physics:
                                            const NeverScrollableScrollPhysics(),
                                        itemBuilder: (context, index) =>
                                            DropdownButton<Sport>(
                                                value: dropdownValueSport,
                                                underline: Container(),
                                                isExpanded: true,
                                                hint: Text(
                                                  snapshot.data![0].name,
                                                  style: const TextStyle(
                                                      color: Colors.grey),
                                                ),
                                                items: dropdownValueList.map<
                                                    DropdownMenuItem<
                                                        Sport>>((Sport? value) {
                                                  return DropdownMenuItem<
                                                      Sport>(
                                                    value: value,
                                                    child: Text(
                                                      value!.name,
                                                    ),
                                                  );
                                                }).toList(),
                                                onChanged: (Sport? value) {
                                                  setState(() {
                                                    dropdownValueSport = value!;
                                                  });
                                                }),
                                        itemCount: snapshot.data!.length,
                                      );
                                    } else {
                                      return const Text(
                                          'Aucun évènement trouvé');
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
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 300,
                        height: 50,
                        child: DecoratedBox(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: DropdownButton<String>(
                                  value: dropdownValueLevel,
                                  underline: Container(),
                                  isExpanded: true,
                                  hint: Text(
                                    levels.first.name.toString(),
                                    style: TextStyle(color: Colors.grey),
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
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          RegisterSportPage(
                                            sports: [
                                              ...widget.sports,
                                              SportSchema(
                                                  dropdownValueSport!,
                                                  int.parse(
                                                      dropdownValueLevel!))
                                            ],
                                          )));
                            } else {
                              displaySnackBar(
                                  "Veuillez renseigner le sport et votre niveau");
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
                  Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: SizedBox(
                        width: 125,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        RegisterSportPage(
                                          sports: widget.sports,
                                        )));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white),
                          child: const Text(
                            "Annuler",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.normal,
                                color: Color(0xFF0085FF)),
                          ),
                        ),
                      )),
                ],
              ),
            )));
  }

  displaySnackBar(String? msg) {
    var snackBar =
        SnackBar(backgroundColor: Colors.red, content: Text(msg ?? ""));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
