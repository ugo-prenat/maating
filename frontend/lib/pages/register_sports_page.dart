import 'package:flutter/material.dart';
import 'package:maating/main.dart';

class RegisterSportPage extends StatefulWidget {
  const RegisterSportPage({super.key});

  @override
  State<RegisterSportPage> createState() => _RegisterSportPage();
}

class _RegisterSportPage extends State<RegisterSportPage> {
  @override
  Widget build(BuildContext context) {
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
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 60, right: 80, left: 80),
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
                            displaySnackBar("ajout d'un sport");
                          },
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
                      "Sport  -  Niveau",
                      style: TextStyle(fontSize: 24, color: Colors.white),
                    ),
                  ),
                  SizedBox(
                    height: 130,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      shrinkWrap: true,
                      children: [
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(right: 40),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text(
                                    "Football  -  Débutant",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text("Volleyball  -  Expert",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 5),
                                  child: Text("Handball  -  Intermédiaire",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18)),
                                ),
                              ]),
                        ))
                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: SizedBox(
                        width: 250,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            displaySnackBar("inscription");
                          },
                          style: ElevatedButton.styleFrom(),
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
