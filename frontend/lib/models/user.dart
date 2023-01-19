import 'package:maating/models/sport.dart';

class User {
  String? id;
  String name;
  String email;
  String password;
  String birthDate;
  String location;
  int? mobilityRange;
  String? avatarUrl;
  double? personalRating;
  int? ratingNumber;
  List<SportSchema> sports;

  User(this.name, this.email, this.password, this.birthDate, this.sports,
      this.location,
      [this.ratingNumber,
      this.avatarUrl,
      this.id,
      this.mobilityRange,
      this.personalRating]);

  Map<String, dynamic> toMap() {
    var sportsArray = [];
    for (var sport in sports) {
      sportsArray = [...sportsArray, sport.toMap()];
    }
    return {
      "name": name,
      "email": email,
      "password": password,
      "birth_date": birthDate,
      "location": location,
      "mobility_range": mobilityRange ?? 10000,
      "avatar_url": avatarUrl ?? defaultAvatarUrl,
      "personal_rating": personalRating ?? 0.0,
      "rating_nb": ratingNumber ?? 0,
      "sports": sportsArray
    };
  }

  User.fromMap(Map<String, dynamic> map)
      : id = map["_id"],
        name = map["name"],
        password = map["password"],
        email = map["email"],
        birthDate = map["birth_date"],
        location = map["location"],
        mobilityRange = map["mobility_range"],
        avatarUrl = map["avatar_url"],
        personalRating = map["personal_rating"],
        ratingNumber = map["rating_nb"],
        sports = map["sports"] is List<dynamic>
            ? <SportSchema>[]
            : map["sports"]
                .map((sportSchema) => SportSchema.fromMap(sportSchema))
                .toList();
}

const defaultAvatarUrl =
    "https://sustainable-investment.eu/wp-content/uploads/2021/02/profile.png";

class SportSchema {
  Sport sport;
  int level;

  SportSchema(this.sport, this.level);

  Map<String, dynamic> toMap() {
    return {"sport": sport.id, "level": level};
  }

  SportSchema.fromMap(map)
      : sport = Sport.fromMap(map["sport"]),
        level = map["level"];
}

class LevelSchema {
  String name;
  int level;

  LevelSchema(this.name, this.level);
}
