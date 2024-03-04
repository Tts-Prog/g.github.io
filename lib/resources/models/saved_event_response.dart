import '../api/from_json.dart';
import 'all_events_response.dart';

class SavedEventResponse implements FromJson<SavedEventResponse> {
  CreateSavedEvent? createSavedEvent;

  SavedEventResponse({this.createSavedEvent});
  @override
  SavedEventResponse fromJson(Map<String, dynamic> json) {
    createSavedEvent = json['createSavedEvent'] != null
        ? CreateSavedEvent().fromJson(json['createSavedEvent'])
        : null;
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    if (createSavedEvent != null) {
      data['createSavedEvent'] = createSavedEvent!.toJson();
    }
    return data;
  }
}

class CreateSavedEvent {
  int? eventId;
  String? id;
  int? userId;
  String? createdAt;
  String? updatedAt;

  CreateSavedEvent(
      {this.eventId, this.id, this.userId, this.createdAt, this.updatedAt});

  CreateSavedEvent fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    id = json['id'];
    userId = json['user_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    return this;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['event_id'] = eventId;
    data['id'] = id;
    data['user_id'] = userId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
