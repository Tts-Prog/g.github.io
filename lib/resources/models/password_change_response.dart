import 'package:ame/resources/api/from_json.dart';

class PasswordChangeResponse implements FromJson<PasswordChangeResponse> {
  ChangePassword? changePassword;

  PasswordChangeResponse({this.changePassword});
  @override
  PasswordChangeResponse fromJson(Map<String, dynamic> json) {
    changePassword = json['changePassword'] != null
        ? ChangePassword().fromJson(json['changePassword'])
        : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (changePassword != null) {
      data['changePassword'] = changePassword!.toJson();
    }
    return data;
  }
}

class ChangePassword {
  String? id;
  String? image;
  String? email;
  String? name;
  String? password;
  String? createdAt;

  ChangePassword(
      {this.id,
      this.image,
      this.email,
      this.name,
      this.password,
      this.createdAt});

  ChangePassword fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    email = json['email'];
    name = json['name'];
    password = json['password'];
    createdAt = json['createdAt'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['image'] = image;
    data['email'] = email;
    data['name'] = name;
    data['password'] = password;
    data['createdAt'] = createdAt;
    return data;
  }
}
