import 'package:flutter/material.dart';
import 'package:maating/main.dart';
import 'package:maating/pages/sports_selection_register_page.dart';
import 'package:maating/widgets/register_sports_list.dart';

class SportSchema {
  String sport;
  int level;

  SportSchema(this.sport, this.level);
}

class LevelSchema {
  String name;
  int level;

  LevelSchema(this.name, this.level);
}

class RegisterSportPage extends StatefulWidget {
  const RegisterSportPage({super.key, required this.sports});

  final List<SportSchema> sports;
  @override
  State<RegisterSportPage> createState() => _RegisterSportPage();
}

class _RegisterSportPage extends State<RegisterSportPage> {
  @override
  Widget build(BuildContext context) {
    List<SportSchema> sportsToAdd = widget.sports;
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
                  const Padding(
                    padding: EdgeInsets.only(top: 50, right: 80, left: 80),
                    child: Text(
                      "Renseigne les sports que tu pratiques",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: SizedBox(
                        width: 200,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SportSelectionRegisterPage(
                                            sports: sportsToAdd)));
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0085FF)),
                          child: const Text(
                            "Ajouter un sport",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.normal),
                          ),
                        ),
                      )),
                  const Divider(
                    height: 10,
                    thickness: 2,
                    indent: 70,
                    endIndent: 70,
                    color: Colors.white,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 10, right: 90, bottom: 10),
                    child: Text(
                      "Sport - Niveau",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                      height: 110,
                      width: MediaQuery.of(context).size.width,
                      child: CustomListViewSportsRegister(
                          onDeletePressed: (List<SportSchema> newSports) {
                            setState(() {
                              sportsToAdd = newSports;
                            });
                          },
                          list: sportsToAdd)),
                  Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            displaySnackBar("inscription");
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF0085FF)),
                          child: const Text(
                            "S'inscrire",
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            )));
  }

  displaySnackBar(String msg) {
    var snackBar = SnackBar(backgroundColor: Colors.red, content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
