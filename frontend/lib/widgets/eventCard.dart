import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:maating/main.dart';
import 'package:maating/models/event.dart';
import 'package:maating/pages/user_profil_page.dart';
import 'package:maating/utils/eventUtils.dart';
import 'package:maating/services/requestManager.dart';

class EventCard extends StatefulWidget {
  const EventCard({
    super.key,
    required this.event,
  });

  final Event event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  IconData _getSportIcon(String sportName) {
    switch (sportName.toLowerCase()) {
      case 'football':
        return Icons.sports_soccer;
      case 'futsal':
        return Icons.sports_soccer;
      case 'kayak':
        return Icons.kayaking;
      case 'golf':
        return Icons.golf_course;
      default:
        return Icons.directions_run;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: <Widget>[
          // Card top
          GestureDetector(
            onTap: () {
              widget.event.isPrivate &&
                      widget.event.organizer['_id'] != sp.getString('User')
                  ? showEventCodeDialog(context)
                  : Navigator.pushNamed(
                      context,
                      '/event_page',
                      arguments: widget.event,
                    );
            },
            child: Column(children: [Location(), Places(), DateAndsport()]),
          ),
          // Card bottom
          Padding(
            padding: const EdgeInsets.only(top: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Organizer(),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.chat_outlined),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Location() => Container(
        padding: const EdgeInsets.only(bottom: 10),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0085FF),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    widget.event.location.thumbnailUrl,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, top: 7),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    widget.event.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: .8,
                    ),
                  ),
                  Text(
                    widget.event.location.address,
                    style: TextStyle(
                      color: Colors.grey[500]!,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  // ignore: non_constant_identifier_names
  Widget Places() {
    var participantsNb = getEventParticipantsNb(widget.event);
    var remainingPlaces = widget.event.maxNb - participantsNb;
    var isFull = remainingPlaces < 1;

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Icon(
              widget.event.isPrivate
                  ? Icons.lock_outline
                  : Icons.lock_open_outlined,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.people_alt_outlined,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    "$participantsNb/${widget.event.maxNb}",
                    style: const TextStyle(fontSize: 15),
                  ),
                )
              ],
            ),
          ),
          Text(
            isFull
                ? "Complet"
                : "$remainingPlaces place${remainingPlaces > 1 ? 's' : ''} restante${remainingPlaces > 1 ? 's' : ''}",
            style: TextStyle(
              color: isFull ? Colors.red : const Color(0xFF0085FF),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget DateAndsport() {
    DateTime dt = DateTime.parse(widget.event.date);
    DateFormat dateFormatter = DateFormat('EE d MMM', 'fr');
    String date = dateFormatter.format(dt);
    String hour = DateFormat.Hm('fr').format(dt);

    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[300]!,
          ),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_outlined,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    date,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              children: [
                const Icon(
                  Icons.access_time,
                  color: Colors.black,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 5),
                  child: Text(
                    hour,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                )
              ],
            ),
          ),
          Row(
            children: [
              Icon(
                _getSportIcon(widget.event.sport.name),
                color: Colors.black,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: Text(
                  widget.event.sport.name,
                  style: const TextStyle(
                    fontSize: 15,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Organizer() => GestureDetector(
        onTap: () {
          String? userId = widget.event.organizer["_id"];
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => UserProfilPage(
                        userId: userId!,
                        goBack: true,
                      )));
        },
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF0085FF),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    "$BACK_URL${widget.event.organizer["avatar_url"]}",
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
                    widget.event.organizer["name"],
                    style: const TextStyle(
                      height: .5,
                      fontWeight: FontWeight.bold,
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
                        widget.event.organizer["personal_rating"]
                            .toStringAsFixed(1),
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

  showEventCodeDialog(BuildContext context) {
    TextEditingController codeController = TextEditingController();

    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Cet événement est privé, merci de renseigner le code d'accès.",
          ),
          content: SizedBox(
            width: 300,
            height: 100,
            child: TextFormField(
              key: const Key('codeInput'),
              controller: codeController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              textInputAction: TextInputAction.next,
              maxLength: 40,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(horizontal: 15.0),
                filled: true,
                fillColor: Colors.white,
                hintText: 'Code d\'accès',
                counterText: '',
                border: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(10),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(10),
                ),
                errorStyle: const TextStyle(
                  fontSize: 16,
                ),
              ),
              validator: (input) {
                if (input!.length > 3 &&
                    input != widget.event.privateCode.toString()) {
                  return 'Code incorrect.';
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              child: const Text("Annuler"),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: const Text("Rentrer"),
              onPressed: () => {
                codeController.text == widget.event.privateCode.toString()
                    ? Navigator.pushNamed(
                        context,
                        '/event_page',
                        arguments: widget.event,
                      )
                    : null
              },
            ),
          ],
        );
      },
    );
  }
}
