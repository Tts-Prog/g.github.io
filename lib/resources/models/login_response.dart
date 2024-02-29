import '../api/from_json.dart';

class LoginResponse implements FromJson<LoginResponse> {
  Login? login;

  LoginResponse({this.login});
  @override
  LoginResponse fromJson(Map<String, dynamic> json) {
    login = json['login'] != null ? Login().fromJson(json['login']) : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (login != null) {
      data['login'] = login!.toJson();
    }
    return data;
  }
}

class Login {
  String? id;

  Login({this.id});

  Login fromJson(Map<String, dynamic> json) {
    id = json['id'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    return data;
  }
}
