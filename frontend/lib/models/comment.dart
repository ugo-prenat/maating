class Comment {
  String? id;
  String authorId;
  String userId;
  String date;
  String event;
  int note;
  String body;

  Comment(
      this.authorId, this.userId, this.date, this.event, this.note, this.body,
      [this.id]);

  Map<String, dynamic> toMap() {
    return {
      "author": authorId,
      "user": userId,
      "date": date,
      "event": event,
      "note": note,
      "body": body
    };
  }

  Comment.fromMap(Map<String, dynamic> map)
      : id = map["_id"],
        authorId = map["author"],
        userId = map["user"],
        date = map["date"],
        event = map["event"],
        note = map["note"],
        body = map["body"];
}
