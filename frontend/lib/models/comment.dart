import 'package:maating/models/event.dart';
import 'package:maating/models/user.dart';

class Comment {
  String? id;
  dynamic author;
  dynamic user;
  String date;
  dynamic event;
  double note;
  String body;

  Comment(this.author, this.user, this.date, this.event, this.note, this.body,
      [this.id]);

  Map<String, dynamic> toMap() {
    return {
      "author": author,
      "user": user,
      "date": date,
      "event": event,
      "note": note,
      "body": body
    };
  }

  Comment.fromMap(Map<String, dynamic> map)
      : id = map["_id"].toString(),
        author = map["author"],
        user = map["user"],
        date = map["date"],
        event = map["event"],
        note = map["note"].toDouble(),
        body = map["body"];
}
