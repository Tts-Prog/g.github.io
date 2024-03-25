import '../api/from_json.dart';
import 'all_events_response.dart';

class UserProfileInfo implements FromJson<UserProfileInfo> {
  GetUser? getUser;

  UserProfileInfo({this.getUser});
  @override
  UserProfileInfo fromJson(Map<String, dynamic> json) {
    getUser =
        json['getUser'] != null ? GetUser().fromJson(json['getUser']) : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (getUser != null) {
      data['getUser'] = getUser!.toJson();
    }
    return data;
  }
}

class GetUser {
  DateTime? updatedAt;
  String? password;
  String? name;
  String? image;
  String? id;
  String? email;
  DateTime? createdAt;
  List<EventInstance>? events;

  GetUser(
      {this.updatedAt,
      this.password,
      this.name,
      this.image,
      this.id,
      this.email,
      this.createdAt,
      this.events});

  GetUser fromJson(Map<String, dynamic> json) {
    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    updatedAt =
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;

    password = json['password'];
    name = json['name'];
    image = json['image'];
    id = json['id'];
    email = json['email'];
    if (json['events'] != null) {
      events = <EventInstance>[];
      json['events'].forEach((v) {
        events!.add(EventInstance().fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['updatedAt'] = updatedAt;
    data['password'] = password;
    data['name'] = name;
    data['image'] = image;
    data['id'] = id;
    data['email'] = email;
    data['createdAt'] = createdAt;
    if (events != null) {
      data['events'] = events!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Events {
//   String? categoryId;
//   DateTime? createdAt;
//   String? description;
//   int? duration;
//   String? id;
//   String? image;
//   String? location;
//   DateTime? startTime;
//   String? subtitle;
//   String? title;
//   DateTime? updatedAt;
//   Category? category;
//   List<Users>? users;
//   List<Artists>? artists;

//   Events(
//       {this.categoryId,
//       this.createdAt,
//       this.description,
//       this.duration,
//       this.id,
//       this.image,
//       this.location,
//       this.startTime,
//       this.subtitle,
//       this.title,
//       this.updatedAt,
//       this.category,
//       this.users,
//       this.artists});

//   Events fromJson(Map<String, dynamic> json) {
//     categoryId = json['category_id'];
//     createdAt =
//         json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
//     updatedAt =
//         json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;

//     startTime = json['start_time'] != null
//         ? DateTime.tryParse(json['start_time'])
//         : null;

//     description = json['description'];
//     duration = json['duration'];
//     id = json['id'];
//     image = json['image'];
//     location = json['location'];

//     subtitle = json['subtitle'];
//     title = json['title'];

//     category =
//         json['category'] != null ? Category().fromJson(json['category']) : null;
//     if (json['users'] != null) {
//       users = <Users>[];
//       json['users'].forEach((v) {
//         users!.add(Users().fromJson(v));
//       });
//     }
//     if (json['artists'] != null) {
//       artists = <Artists>[];
//       json['artists'].forEach((v) {
//         artists!.add(Artists.fromJson(v));
//       });
//     }
//     return this;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['category_id'] = categoryId;
//     data['createdAt'] = createdAt;
//     data['description'] = description;
//     data['duration'] = duration;
//     data['id'] = id;
//     data['image'] = image;
//     data['location'] = location;
//     data['start_time'] = startTime;
//     data['subtitle'] = subtitle;
//     data['title'] = title;
//     data['updatedAt'] = updatedAt;
//     if (category != null) {
//       data['category'] = category!.toJson();
//     }
//     if (users != null) {
//       data['users'] = users!.map((v) => v.toJson()).toList();
//     }
//     if (artists != null) {
//       data['artists'] = artists!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Category {
//   String? color;
//   DateTime? createdAt;
//   String? id;
//   String? name;
//   DateTime? updatedAt;

//   Category({this.color, this.createdAt, this.id, this.name, this.updatedAt});

//   Category fromJson(Map<String, dynamic> json) {
//     color = json['color'];

//     id = json['id'];
//     name = json['name'];
//     createdAt =
//         json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
//     updatedAt =
//         json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;

//     return this;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['color'] = color;
//     data['createdAt'] = createdAt;
//     data['id'] = id;
//     data['name'] = name;
//     data['updatedAt'] = updatedAt;
//     return data;
//   }
// }

class Users {
  String? image;
  String? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Users({this.image, this.id, this.name, this.createdAt, this.updatedAt});

  Users fromJson(Map<String, dynamic> json) {
    image = json['image'];
    id = json['id'];
    name = json['name'];
    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    updatedAt =
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = image;
    data['id'] = id;
    data['name'] = name;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

class Artists {
  String? role;
  Artist? artist;

  Artists({this.role, this.artist});

  Artists.fromJson(Map<String, dynamic> json) {
    role = json['role'];
    artist = json['artist'] != null ? Artist().fromJson(json['artist']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['role'] = role;
    if (artist != null) {
      data['artist'] = artist!.toJson();
    }
    return data;
  }
}

class Artist {
  String? biography;
  DateTime? createdAt;
  String? id;
  String? image;
  String? name;
  String? nationality;
  List<String>? roles;
  DateTime? updatedAt;

  Artist(
      {this.biography,
      this.createdAt,
      this.id,
      this.image,
      this.name,
      this.nationality,
      this.roles,
      this.updatedAt});

  Artist fromJson(Map<String, dynamic> json) {
    biography = json['biography'];
    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    id = json['id'];
    image = json['image'];
    name = json['name'];
    nationality = json['nationality'];
    roles = json['roles'].cast<String>();
    updatedAt =
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;

    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['biography'] = biography;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['image'] = image;
    data['name'] = name;
    data['nationality'] = nationality;
    data['roles'] = roles;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
