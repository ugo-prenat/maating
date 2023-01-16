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
        body: Center(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 60, right: 80, left: 80),
            child: Text(
              "Renseigne les sports que tu pratiques",
              style: TextStyle(fontFamily: "Poppins", fontSize: 24),
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
                        fontFamily: "Poppins",
                        fontSize: 18,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )),
          const Divider(
            height: 10,
            thickness: 2,
            indent: 70,
            endIndent: 70,
            color: Colors.black,
          ),
          const Padding(
            padding: EdgeInsets.only(top: 5, right: 90),
            child: Text(
              "Sport  -  Niveau",
              style: TextStyle(fontFamily: "Poppins", fontSize: 24),
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
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
                        fontFamily: "Poppins",
                        fontSize: 22,
                        fontWeight: FontWeight.normal),
                  ),
                ),
              )),
        ],
      ),
    ));
  }

  displaySnackBar(String msg) {
    var snackBar = SnackBar(backgroundColor: Colors.red, content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
