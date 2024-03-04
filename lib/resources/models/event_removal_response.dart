import 'package:ame/resources/api/from_json.dart';

class EventRemovalResponse implements FromJson<EventRemovalResponse> {
  bool? removeSavedEvent;

  EventRemovalResponse({this.removeSavedEvent});
  @override
  EventRemovalResponse fromJson(Map<String, dynamic> json) {
    removeSavedEvent = json['removeSavedEvent'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['removeSavedEvent'] = this.removeSavedEvent;
    return data;
  }
}
