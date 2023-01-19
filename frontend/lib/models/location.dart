class Location {
  String? id;
  String name;
  String address;
  String thumbnailUrl;
  LoctSchema loc;

  Location(this.name, this.address, this.thumbnailUrl, this.loc, [this.id]);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "thumbnail_url": thumbnailUrl,
    };
  }

  Location.fromMap(Map<String, dynamic> map)
      : id = map["_id"],
        name = map["name"],
        address = map["address"],
        thumbnailUrl = map["thumbnail_url"],
        loc = LoctSchema.fromMap(map["loc"]);
}

class LoctSchema {
  String type;
  List<dynamic> coordinates;

  LoctSchema(this.type, this.coordinates);

  Map<String, dynamic> toMap() {
    return {
      "type": type,
      "coordinates": coordinates,
    };
  }

  LoctSchema.fromMap(Map<String, dynamic> map)
      : type = map["type"],
        coordinates = map["coordinates"] as List<dynamic>;
}
