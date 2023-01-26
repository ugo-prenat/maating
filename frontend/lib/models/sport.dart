class Sport {
  String id;
  String name;

  Sport(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {"id": id, "name": name};
  }

  Sport.fromMap(map)
      : id = map["_id"].toString(),
        name = map["name"];
}
