import 'package:ame/resources/api/from_json.dart';

class AllEventsResponse implements FromJson<AllEventsResponse> {
  List<EventInstance>? eventInstances;
  List<Category>? categories;

  AllEventsResponse({this.eventInstances, this.categories});

  @override
  AllEventsResponse fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      eventInstances = <EventInstance>[];
      json['events'].forEach((v) {
        eventInstances?.add(EventInstance().fromJson(v));
      });
    }
    if (json['eventsByDay'] != null) {
      eventInstances = <EventInstance>[];
      json['eventsByDay'].forEach((v) {
        eventInstances?.add(EventInstance().fromJson(v));
      });
    }

    if (json['categories'] != null) {
      categories = <Category>[];
      json['categories'].forEach((v) {
        categories?.add(Category().fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (eventInstances != null) {
      data['events'] = eventInstances?.map((v) => v.toJson()).toList();
      data['eventsByDay'] = eventInstances?.map((v) => v.toJson()).toList();
    }
    if (categories != null) {
      data['categories'] = categories?.map((v) => v.toJson()).toList();
    }

    return data;
  }
}

class EventInstance {
  List<Artists>? artists;
  Category? category;
  String? categoryId;
  DateTime? createdAt;
  String? description;
  int? duration;
  String? id;
  String? image;
  String? location;
  DateTime? startTime;
  String? subtitle;
  String? title;
  DateTime? updatedAt;
  List<Users>? users;

  EventInstance(
      {this.artists,
      this.category,
      this.categoryId,
      this.createdAt,
      this.description,
      this.duration,
      this.id,
      this.image,
      this.location,
      this.startTime,
      this.subtitle,
      this.title,
      this.updatedAt,
      this.users});

  EventInstance fromJson(Map<String, dynamic> json) {
    if (json['artists'] != null) {
      artists = <Artists>[];
      json['artists'].forEach((v) {
        artists?.add(Artists().fromJson(v));
      });
    }
    category =
        json['category'] != null ? Category().fromJson(json['category']) : null;
    categoryId = json['category_id'];
    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;
    description = json['description'];
    duration = json['duration'];
    id = json['id'];
    image = json['image'];
    location = json['location'];
    startTime = json['start_time'] != null
        ? DateTime.tryParse(json['start_time'])
        : null;
    subtitle = json['subtitle'];
    title = json['title'];
    updatedAt =
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users?.add(Users().fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (artists != null) {
      data['artists'] = artists?.map((v) => v.toJson()).toList();
    }
    if (category != null) {
      data['category'] = category?.toJson();
    }
    data['category_id'] = categoryId;
    data['createdAt'] = createdAt;
    data['description'] = description;
    data['duration'] = duration;
    data['id'] = id;
    data['image'] = image;
    data['location'] = location;
    data['start_time'] = startTime;
    data['subtitle'] = subtitle;
    data['title'] = title;
    data['updatedAt'] = updatedAt;
    if (users != null) {
      data['users'] = users?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Artists {
  Artist? artist;
  String? role;

  Artists({this.artist, this.role});

  Artists fromJson(Map<String, dynamic> json) {
    artist = json['artist'] != null ? Artist().fromJson(json['artist']) : null;
    role = json['role'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (artist != null) {
      data['artist'] = artist?.toJson();
    }
    data['role'] = role;
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

class Category {
  String? color;
  DateTime? createdAt;
  String? id;
  String? name;
  DateTime? updatedAt;

  Category({this.color, this.createdAt, this.id, this.name, this.updatedAt});

  Category fromJson(Map<String, dynamic> json) {
    color = json['color'];
    createdAt =
        json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null;

    id = json['id'];
    name = json['name'];
    updatedAt =
        json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['color'] = color;
    data['createdAt'] = createdAt;
    data['id'] = id;
    data['name'] = name;
    data['updatedAt'] = updatedAt;
    return data;
  }
}

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
