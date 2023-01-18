import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:maating/models/user.dart';
import 'package:maating/pages/register_sports_page.dart';

List<LevelSchema> levels = <LevelSchema>[
  LevelSchema("Débutant", 0),
  LevelSchema("Intermédiaire", 1),
  LevelSchema("Avancé", 3),
  LevelSchema("Expert", 4)
];

class CustomListViewSportsRegister extends StatefulWidget {
  const CustomListViewSportsRegister(
      {super.key, required this.list, required this.onDeletePressed});

  final List<SportSchema> list;
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
              padding: const EdgeInsets.only(bottom: 5, left: 77, right: 60),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${widget.list[index].sport.name} - ${levels.firstWhere((level) => level.level == widget.list[index].level).name}",
                    style: const TextStyle(color: Colors.white, fontSize: 18),
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
                        icon: Icon(
                          Icons.close,
                          color: Colors.white,
                        )),
                  )
                ],
              ));
        },
        itemCount: widget.list.length,
      );
    }
  }
}
