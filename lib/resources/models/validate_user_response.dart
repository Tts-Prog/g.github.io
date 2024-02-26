import '../../api/from_json.dart';

class ValidateUserResponse implements FromJson<ValidateUserResponse> {
  bool? validate;

  ValidateUserResponse({this.validate});

  @override
  ValidateUserResponse fromJson(Map<String, dynamic> json) {
    validate = json['validate'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['validate'] = validate;
    return data;
  }
}
