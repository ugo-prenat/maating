import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:maating/main.dart';
import 'package:maating/models/user.dart';
import 'package:maating/services/requestManager.dart';

import '../models/comment.dart';
import '../models/event.dart';

class CommentProfilAddPage extends StatefulWidget {
  const CommentProfilAddPage({super.key, required this.user});

  final User user;
  @override
  State<CommentProfilAddPage> createState() => _CommentProfilAddPage();
}

class _CommentProfilAddPage extends State<CommentProfilAddPage> {
  final _client = http.Client();
  Comment newCommment = Comment('', '', '', '', 0.0, '');
  String? dropdownValueEventId;
  final f = DateFormat('dd/MM/yy');
  List<Event> events = [];

  @override
  Widget build(BuildContext context) {
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
                    padding: const EdgeInsets.only(top: 60),
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color.fromARGB(255, 156, 156, 156),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            "$BACK_URL${widget.user.avatarUrl!}",
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 5),
                    child: Text(
                      "Laissez un avis sur ${widget.user.name}",
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ),
                  const Divider(
                      height: 10,
                      thickness: 2,
                      indent: 50,
                      endIndent: 50,
                      color: Color.fromARGB(100, 184, 184, 184)),
                  ListView(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 15),
                            child: SizedBox(
                              width: 300,
                              child: DecoratedBox(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                      padding: const EdgeInsets.only(
                                          left: 10, right: 10),
                                      child: DropDownEvents())),
                            ),
                          ),
                          Padding(
                              padding: const EdgeInsets.only(top: 15, left: 50),
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          "Note",
                                          style: TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                        )),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        for (var i = 1; i < 6; i++)
                                          Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8),
                                              child: LayoutBuilder(builder:
                                                  (context, constraints) {
                                                if (i <= newCommment.note) {
                                                  return IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {
                                                        setState(() {
                                                          newCommment.note =
                                                              i.toDouble();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.star,
                                                        color:
                                                            Color(0xFF0085FF),
                                                        size: 25,
                                                      ));
                                                } else if (newCommment.note ==
                                                    (i - 0.5)) {
                                                  return IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {
                                                        setState(() {
                                                          newCommment.note =
                                                              i.toDouble();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.star_half,
                                                        color:
                                                            Color(0xFF0085FF),
                                                        size: 25,
                                                      ));
                                                } else {
                                                  return IconButton(
                                                      padding: EdgeInsets.zero,
                                                      constraints:
                                                          BoxConstraints(),
                                                      onPressed: () {
                                                        setState(() {
                                                          newCommment.note =
                                                              i.toDouble();
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.star_border,
                                                        color:
                                                            Color(0xFF0085FF),
                                                        size: 25,
                                                      ));
                                                }
                                              }))
                                      ],
                                    ),
                                  ])),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 40),
                            child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: const Color(0xFF0085FF), width: 1),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                    maxLines: 8, //or null
                                    maxLength: 200,
                                    decoration: const InputDecoration.collapsed(
                                        hintText: "Entrez votre commentaire"),
                                    onChanged: (String value) {
                                      setState(() {
                                        newCommment.body = value;
                                      });
                                    },
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: SizedBox(
                              width: 280,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () async {
                                  if (newCommment.body == '' ||
                                      newCommment.note == 0.0 ||
                                      newCommment.event == '') {
                                    displaySnackBar(
                                        "Veuillez remplir tous les champs",
                                        true);
                                    return;
                                  } else {
                                    newCommment.author = sp.getString('User');
                                    newCommment.user = widget.user.id;
                                    newCommment.date =
                                        DateTime.now().toString();
                                    RequestManager(_client)
                                        .postComment(newCommment);
                                    displaySnackBar(
                                        "Commentaire posté avec succès", false);
                                    Navigator.pop(context, () {
                                      setState(() {});
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF0085FF)),
                                child: const Text(
                                  "Poster le commentaire",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
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
                    newCommment.event = value;
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
            newCommment.event = value;
          });
        },
      );
    }
  }
}
