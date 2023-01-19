class Sport {
  String id;
  String name;

  Sport(this.id, this.name);

  Map<String, dynamic> toMap() {
    return {"name": name};
  }

  Sport.fromMap(map)
      : id = map["_id"],
        name = map["name"];
}
