import '../api/from_json.dart';

class ValidateUserResponse implements FromJson<ValidateUserResponse> {
  bool? forgotPassword;

  ValidateUserResponse({this.forgotPassword});

  @override
  ValidateUserResponse fromJson(Map<String, dynamic> json) {
    forgotPassword = json['forgotPassword'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['forgotPassword'] = forgotPassword;
    return data;
  }
}
