import 'package:dio/dio.dart';

abstract class APIRouteConfigurable {
  RequestOptions? getConfig();
}

class ApiMethod {
  static const get = 'GET';
  static const post = 'POST';
  static const put = 'PUT';
  static const patch = 'PATCH';
  static const delete = 'DELETE';
}

enum ApiType {
  fetchListImage,
  fetchEventsDetails,
  checkEmail,
  signIn,
  searchEventsByDate,
  fetchUserInfo,
  changePassword,
  saveEvents,
  removeSavedEvent
}

class ApiRoute implements APIRouteConfigurable {
  final ApiType type;
  final String? routeParams;
  final Map<String, dynamic>? data;
  Map<String, dynamic>? headers;
  // = {
  //   "user_id": "80",
  //   // 'accept': 'application/json',
  //   'content-type': 'application/json'
  // };
  ApiRoute(this.type, {this.routeParams, this.data});
  @override
  RequestOptions? getConfig() {
    switch (type) {
      case ApiType.fetchListImage:
        return RequestOptions(
          method: ApiMethod.post, data: data, //headers: headers
          //   headers: headers,
        );
      case ApiType.checkEmail:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          //  headers: headers,
        );

      case ApiType.fetchEventsDetails:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          //  headers: headers,
        );

      case ApiType.signIn:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          //  headers: headers,
        );
      case ApiType.searchEventsByDate:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          //  headers: headers,
        );
      case ApiType.fetchUserInfo:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          //   headers: headers,
        );
      case ApiType.changePassword:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          //   headers: headers,
        );
      case ApiType.saveEvents:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          // headers: headers,
        );
      case ApiType.removeSavedEvent:
        return RequestOptions(
          method: ApiMethod.post,
          data: data,
          // headers: headers,
        );
    }
  }
}
