class Location {
  String? id;
  String name;
  String address;
  String thumbnailUrl;
  double latitude;
  double longitude;

  Location(
      this.name, this.address, this.thumbnailUrl, this.latitude, this.longitude,
      [this.id]);

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "address": address,
      "thumbnail_url": thumbnailUrl,
      "latitude": latitude,
      "longitude": longitude,
    };
  }

  Location.fromMap(Map<String, dynamic> map)
      : id = map["_id"],
        name = map["name"],
        address = map["address"],
        thumbnailUrl = map["thumbnail_url"],
        latitude = map["latitude"],
        longitude = map["longitude"];
}
