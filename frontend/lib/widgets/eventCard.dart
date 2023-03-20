import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:maating/models/event.dart';

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
              Navigator.pushNamed(
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
    var remainingPlaces = widget.event.maxNb - widget.event.participants.length;
    var isFull = remainingPlaces == 0;

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
                    "${widget.event.participants.length}/${widget.event.maxNb}",
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
              const Icon(
                Icons.sports_soccer,
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
          print('go to user page $userId');
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
                    "http://10.0.2.2:4000${widget.event.organizer["avatar_url"]}",
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
                        widget.event.organizer["personal_rating"].toString(),
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
