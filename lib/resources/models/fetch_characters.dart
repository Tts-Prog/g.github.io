import 'package:ame/api/from_json.dart';

class CharactersResponse implements FromJson<CharactersResponse> {
  Characters? characters;

  CharactersResponse({this.characters});
  @override
  CharactersResponse fromJson(Map<String, dynamic> json) {
    characters = json['characters'] != null
        ? Characters().fromJson(json['characters'])
        : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (characters != null) {
      data['characters'] = characters!.toJson();
    }
    return data;
  }

  // @override
  // CharactersResponse fromJson(Map<String, dynamic> data) {
  //   // TODO: implement fromJson
  //   throw UnimplementedError();
  // }
}

class Characters {
  List<Results>? results;

  Characters({this.results});

  Characters fromJson(Map<String, dynamic> json) {
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results().fromJson(v));
      });
    }
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Results {
  String? name;
  String? image;

  Results({this.name, this.image});

  Results fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['image'] = image;
    return data;
  }
}
