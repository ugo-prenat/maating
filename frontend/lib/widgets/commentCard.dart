import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:maating/extension/date_time_extension.dart';
import 'package:maating/models/comment.dart';
import 'package:maating/models/event.dart';
import 'package:maating/utils/backendUtils.dart';
import 'package:maating/utils/eventUtils.dart';
import 'package:maating/services/requestManager.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({
    super.key,
    required this.comment,
  });

  final Comment comment;

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  final f = DateFormat('dd/MM/yy');
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey[300]!,
        ),
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
      margin: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: const Color(0xFF0085FF),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(getBackendUrl() +
                                widget.comment.author['avatar_url'])),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: SizedBox(
                            width: 120,
                            child: Text(
                              widget.comment.author['name'],
                              style: const TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            f.format(DateTime.parse(widget.comment.date)) +
                                " - " +
                                DateTime.parse(widget.comment.date).timeAgo(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 9,
                                color: Colors.grey,
                                decoration: TextDecoration.none),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: SizedBox(
                        width: 120,
                        child: Text(
                          widget.comment.event['name'],
                          textAlign: TextAlign.end,
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              overflow: TextOverflow.ellipsis),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10, top: 5),
                      child: Text(
                        f.format(DateTime.parse(widget.comment.event['date'])) +
                            " - " +
                            DateTime.parse(widget.comment.event['date'])
                                .timeAgo(),
                        textAlign: TextAlign.end,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 9,
                            color: Colors.grey,
                            decoration: TextDecoration.none),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(children: [
                for (var i = 1; i < 6; i++)
                  Padding(
                      padding: const EdgeInsets.only(left: 3),
                      child: LayoutBuilder(builder: (context, constraints) {
                        if (i <= widget.comment.note) {
                          return const Icon(
                            Icons.star,
                            color: Color(0xFF0085FF),
                            size: 20,
                          );
                        } else if (widget.comment.note == (i - 0.5)) {
                          return const Icon(
                            Icons.star_half,
                            color: Color(0xFF0085FF),
                            size: 20,
                          );
                        } else {
                          return const Icon(
                            Icons.star_border,
                            color: Color(0xFF0085FF),
                            size: 20,
                          );
                        }
                      }))
              ])),
          Padding(
            padding: const EdgeInsets.only(top: 6, left: 7),
            child: Text(
              widget.comment.body,
              textAlign: TextAlign.start,
            ),
          )
        ],
      ),
    );
  }
}
