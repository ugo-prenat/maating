import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maating/main.dart';
import 'package:maating/models/user.dart';
import 'package:maating/pages/update_profil_sport_page.dart';
import 'package:maating/services/requestManager.dart';

import '../models/comment.dart';
import '../models/event.dart';
import '../widgets/register_sports_list.dart';

class UpdateProfilPage extends StatefulWidget {
  const UpdateProfilPage({super.key, required this.user});

  final User user;
  @override
  State<UpdateProfilPage> createState() => _UpadateProfilPage();
}

class _UpadateProfilPage extends State<UpdateProfilPage> {
  final _client = http.Client();
  User updatedUser = User("", "", "", "", [], "", 0, "", "", 0, 0.0);
  String? dropdownValueEventId;
  final f = DateFormat('dd/MM/yy');
  List<Event> events = [];
  List<SportSchema> sportsToAdd = <SportSchema>[];

  @override
  Widget build(BuildContext context) {
    updatedUser = widget.user;
    if (sportsToAdd.isEmpty) {
      setState(() {
        sportsToAdd = widget.user.sports;
      });
    }
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 45, bottom: 25),
                    child: Text(
                      "Mis à jour du profil",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
                    ),
                  ),
                  const Divider(
                      height: 10,
                      thickness: 2,
                      indent: 50,
                      endIndent: 50,
                      color: Color.fromARGB(100, 184, 184, 184)),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    child: ListView(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      children: [
                        Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 50, right: 50),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: SizedBox(
                                      width: 135,
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: const Color(0xFF0085FF),
                                                width: 1),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                initialValue: widget.user.name,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Nom",
                                                ),
                                                onChanged: (String value) {
                                                  setState(() {
                                                    updatedUser.name = value;
                                                  });
                                                },
                                              ))),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15),
                                    child: SizedBox(
                                      width: 135,
                                      child: DecoratedBox(
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            border: Border.all(
                                                color: const Color(0xFF0085FF),
                                                width: 1),
                                          ),
                                          child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10, right: 10),
                                              child: TextFormField(
                                                initialValue:
                                                    widget.user.location,
                                                decoration:
                                                    const InputDecoration(
                                                  border: InputBorder.none,
                                                  hintText: "Localisation",
                                                ),
                                                onChanged: (String value) {
                                                  setState(() {
                                                    updatedUser.location =
                                                        value;
                                                  });
                                                },
                                              ))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 300,
                              child: Row(
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20),
                                    child: Text(
                                      'Mobilité : ',
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, left: 15),
                                    child: Text(
                                        '${(updatedUser.mobilityRange != 0 ? updatedUser.mobilityRange! : widget.user.mobilityRange!) / 1000} km',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.black,
                                        )),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 350,
                              height: 100,
                              child: SliderTheme(
                                data: const SliderThemeData(
                                  valueIndicatorColor: Colors.transparent,
                                  valueIndicatorTextStyle: TextStyle(
                                    color: Color(0xFF0085FF),
                                  ),
                                ),
                                child: Slider(
                                  value: updatedUser.mobilityRange != 0
                                      ? updatedUser.mobilityRange! / 1000
                                      : widget.user.mobilityRange! / 1000,
                                  min: 1,
                                  max: 100,
                                  divisions: 100,
                                  label:
                                      '${updatedUser.mobilityRange! / 1000} km',
                                  onChanged: (double values) {
                                    setState(() {
                                      updatedUser.mobilityRange =
                                          values.round() * 1000;
                                    });
                                  },
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(
                                  padding: EdgeInsets.only(left: 50),
                                  child: Text("Sports : ",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, bottom: 20, right: 50),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xFF0085FF),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    width: 30,
                                    height: 30,
                                    child: IconButton(
                                      padding: EdgeInsets.zero,
                                      onPressed: () async {
                                        final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UpdateProfilSportPage(
                                                        sports: sportsToAdd)));
                                        if (result != null) {
                                          setState(() {
                                            sportsToAdd = result;
                                          });
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.add,
                                        color: Colors.white,
                                        size: 25,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const Divider(
                              height: 10,
                              thickness: 2,
                              indent: 70,
                              endIndent: 70,
                              color: Color(0xFF0085FF),
                            ),
                            SizedBox(
                                height: 110,
                                width: MediaQuery.of(context).size.width,
                                child: CustomListViewSportsRegister(
                                    onRegister: false,
                                    onDeletePressed:
                                        (List<SportSchema> newSports) {
                                      setState(() {
                                        sportsToAdd = newSports;
                                      });
                                    },
                                    list: sportsToAdd)),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: SizedBox(
                      width: 280,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (updatedUser.name == '' ||
                              updatedUser.mobilityRange == 0.0 ||
                              updatedUser.location == '') {
                            displaySnackBar(
                                "Veuillez remplir tous les champs", true);
                            return;
                          } else if (sportsToAdd.isEmpty) {
                            displaySnackBar(
                                "Veuillez renseigner au moins un sport", true);
                          } else {
                            updatedUser.sports = sportsToAdd;
                            try {
                              await RequestManager(_client)
                                  .updateUser(updatedUser, widget.user.id!);

                              displaySnackBar(
                                  "Votre profil est désormais à jour", false);
                              Navigator.pop(context);
                            } catch (e) {
                              displaySnackBar(
                                  "Une erreur est survenue durant la mis à jour de votre profil, veuillez réessayer plus tard",
                                  true);
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0085FF)),
                        child: const Text(
                          "Mettre à jour",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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
      ),
    );
  }

  displaySnackBar(String msg, bool error) {
    var snackBar = SnackBar(
        backgroundColor: error ? Colors.red : Colors.green,
        content: Text(
          msg,
          textAlign: TextAlign.center,
        ));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Widget DropDownEvents() {
    if (events.isEmpty) {
      return FutureBuilder<List<Event>>(
        future: RequestManager(_client)
            .getEventsPassedInCommon(widget.user.id!, sp.getString('User')!),
        builder: (
          BuildContext context,
          AsyncSnapshot<List<Event>> snapshot,
        ) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              return DropdownButton<String>(
                value: dropdownValueEventId,
                underline: Container(),
                isExpanded: true,
                hint: const Text(
                  "L'évènement participé",
                  style: TextStyle(color: Colors.grey),
                ),
                items: snapshot.data!
                    .map<DropdownMenuItem<String>>((Event? value) {
                  return DropdownMenuItem<String>(
                    value: value?.id,
                    child: Text(
                      "${value!.name.characters.take(16)} - ${f.format(DateTime.parse(value.date))}",
                      textAlign: TextAlign.center,
                    ),
                  );
                }).toList(),
                onChanged: (String? value) {
                  setState(() {
                    setState(() {
                      events = snapshot.data!;
                    });
                    dropdownValueEventId = value!;
                    // updatedUser.event = value;
                  });
                },
              );
            } else {
              return const Text('Vous n\'avez pas d\'évènement en commun');
            }
          } else {
            return Text('Etat: ${snapshot.connectionState}');
          }
        },
      );
    } else {
      return DropdownButton<String>(
        value: dropdownValueEventId,
        underline: Container(),
        isExpanded: true,
        hint: const Text(
          "L'évènement participé",
          style: TextStyle(color: Colors.grey),
        ),
        items: events.map<DropdownMenuItem<String>>((Event? value) {
          return DropdownMenuItem<String>(
            value: value?.id,
            child: Text(
              "${value!.name.characters.take(16)} - ${f.format(DateTime.parse(value.date))}",
              textAlign: TextAlign.center,
            ),
          );
        }).toList(),
        onChanged: (String? value) {
          setState(() {
            dropdownValueEventId = value!;
            // updatedUser.event = value;
          });
        },
      );
    }
  }
}
