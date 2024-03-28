import 'package:ame/resources/api/from_json.dart';

class AccountRemovalResponse implements FromJson<AccountRemovalResponse> {
  bool? removeAccount;

  AccountRemovalResponse({this.removeAccount});
  @override
  AccountRemovalResponse fromJson(Map<String, dynamic> json) {
    removeAccount = json['removeUser'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['removeUser'] = this.removeAccount;
    return data;
  }
}
