import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maating/models/user.dart';

List<LevelSchema> levels = <LevelSchema>[
  LevelSchema("Débutant", 0),
  LevelSchema("Intermédiaire", 1),
  LevelSchema("Avancé", 3),
  LevelSchema("Expert", 4)
];

class CustomListViewSportsRegister extends StatefulWidget {
  const CustomListViewSportsRegister(
      {super.key,
      required this.list,
      required this.onDeletePressed,
      required this.onRegister});

  final List<SportSchema> list;
  final bool onRegister;
  final Function(List<SportSchema>) onDeletePressed;

  @override
  State<CustomListViewSportsRegister> createState() =>
      _CustomListViewSportsRegister();
}

class _CustomListViewSportsRegister
    extends State<CustomListViewSportsRegister> {
  @override
  Widget build(BuildContext context) {
    if (widget.list.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(left: 80),
        child: Text("Pas de sports ajouté",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
      );
    } else {
      return ListView.builder(
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.only(bottom: 5, left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.list[index].sport.name} - ${levels.firstWhere((level) => level.level == widget.list[index].level).name}",
                    style: widget.onRegister
                        ? const TextStyle(color: Colors.white, fontSize: 18)
                        : const TextStyle(
                            color: Color(0xFF0085FF), fontSize: 18),
                  ),
                  SizedBox(
                      height: 18,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        iconSize: 18,
                        onPressed: () {
                          widget.list.removeAt(index);
                          widget.onDeletePressed(widget.list);
                        },
                        icon: widget.onRegister
                            ? Icon(
                                Icons.close,
                                color: Colors.white,
                              )
                            : Icon(
                                Icons.close,
                                color: Color(0xFF0085FF),
                              ),
                      ))
                ],
              ));
        },
        itemCount: widget.list.length,
      );
    }
  }
}
