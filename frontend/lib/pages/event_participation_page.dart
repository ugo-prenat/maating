import 'package:flutter/material.dart';
import 'package:maating/models/event.dart';
import 'package:maating/models/user.dart';
import 'package:maating/pages/map_page.dart';
import 'package:maating/utils/eventUtils.dart';
import 'package:maating/services/requestManager.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:flutter/services.dart';

class EventParticipationPage extends StatefulWidget {
  const EventParticipationPage({
    required this.event,
    required this.user,
    super.key,
  });

  final Event event;
  final User user;

  @override
  State<EventParticipationPage> createState() => _EventParticpantsPageState();
}

class _EventParticpantsPageState extends State<EventParticipationPage> {
  int _additionalPlacesNb = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Title(),
          Column(
            children: [
              UserInfos(),
              AdditionalPlacesSelection(),
            ],
          ),
          ConfirmParticipationBtn(),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Title() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 15),
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
        Padding(
          padding: const EdgeInsets.only(left: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Inscription",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(widget.event.name)
            ],
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget UserInfos() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF0085FF),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  "$BACK_URL${widget.user.avatarUrl}",
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 9),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.user.name,
                  style: const TextStyle(
                    height: .5,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),
                Row(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 2, right: 1),
                      child: Icon(
                        Icons.star,
                        color: Color(0xFF0085FF),
                        size: 18,
                      ),
                    ),
                    Text(
                      widget.user.personalRating.toString(),
                      style: const TextStyle(
                        color: Color(0xFF0085FF),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget AdditionalPlacesSelection() {
    int participantsNb = getEventParticipantsNb(widget.event);
    int remainingPlaces = widget.event.maxNb - participantsNb;
    bool invalidNb = _additionalPlacesNb >= remainingPlaces;

    return Column(
      children: <Widget>[
        const Text(
          "Réserver des places supplémentaires :",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: IconButton(
            onPressed: () {
              HapticFeedback.vibrate();
              setState(() {
                if (_additionalPlacesNb > 0) _additionalPlacesNb--;
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_up_rounded,
              color: invalidNb
                  ? Colors.black26
                  : const Color.fromARGB(150, 0, 132, 255),
            ),
          ),
        ),
        NumberPicker(
          value: _additionalPlacesNb,
          minValue: 0,
          maxValue: 100,
          onChanged: (value) => setState(() => _additionalPlacesNb = value),
          textStyle: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: invalidNb
                ? const Color.fromARGB(80, 244, 67, 54)
                : Colors.black,
          ),
          selectedTextStyle: TextStyle(
            color: invalidNb ? Colors.red : const Color(0xFF0085FF),
            fontSize: 50,
            fontWeight: FontWeight.bold,
          ),
          itemHeight: 80,
          axis: Axis.vertical,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 20),
          child: IconButton(
            onPressed: () {
              HapticFeedback.vibrate();
              setState(() {
                if (_additionalPlacesNb < remainingPlaces)
                  // ignore: curly_braces_in_flow_control_structures
                  _additionalPlacesNb++;
              });
            },
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              color: invalidNb
                  ? Colors.black26
                  : const Color.fromARGB(150, 0, 132, 255),
            ),
          ),
        ),
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Widget ConfirmParticipationBtn() {
    int participantsNb = getEventParticipantsNb(widget.event);
    int remainingPlaces = widget.event.maxNb - participantsNb;
    bool invalidNb = _additionalPlacesNb >= remainingPlaces;

    return Padding(
      padding: const EdgeInsets.only(left: 25, right: 25, bottom: 20),
      child: ElevatedButton(
        onPressed: invalidNb
            ? null
            : () => {
                  addUserToEvent(
                    widget.event.id,
                    widget.user.id,
                    _additionalPlacesNb,
                  )
                      .then((statusCode) => statusCode == 200
                          ? Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const MapPage(
                                  successMsg: 'Inscription enregistrée',
                                ),
                              ),
                            )
                          : displaySnackBar(
                              'Une erreur est survenue, veuillez réessayer'))
                      .catchError(
                    (e) {
                      displaySnackBar(
                          'Une erreur est survenue, veuillez réessayer');
                    },
                  ),
                },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(40),
          backgroundColor: const Color(0xFF0085FF),
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
            vertical: 7.0,
          ),
        ),
        child: Text(
          invalidNb
              ? 'Uniquement $remainingPlaces place${remainingPlaces > 1 ? 's' : ''} disponible${remainingPlaces > 1 ? 's' : ''}'
              : 'Réserver ${_additionalPlacesNb + 1} place${_additionalPlacesNb > 0 ? 's' : ''}',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  displaySnackBar(String msg) {
    var snackBar = SnackBar(backgroundColor: Colors.red, content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
