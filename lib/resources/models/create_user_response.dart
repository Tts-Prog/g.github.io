import 'package:ame/resources/api/from_json.dart';

class CreateUserResponse implements FromJson<CreateUserResponse> {
  CreateUser? createUser;

  CreateUserResponse({this.createUser});
  @override
  CreateUserResponse fromJson(Map<String, dynamic> json) {
    createUser = json['createUser'] != null
        ? CreateUser().fromJson(json['createUser'])
        : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (createUser != null) {
      data['createUser'] = createUser!.toJson();
    }
    return data;
  }
}

class CreateUser {
  String? id;

  CreateUser({this.id});

  CreateUser fromJson(Map<String, dynamic> json) {
    id = json['id'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    return data;
  }
}
