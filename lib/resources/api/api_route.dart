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
  saveEvents
}

class ApiRoute implements APIRouteConfigurable {
  final ApiType type;
  final String? routeParams;
  final Map<String, dynamic>? data;
  final headers = {
    'accept': 'application/graphql',
    'content-type': 'application/graphql'
  };
  ApiRoute(this.type, {this.routeParams, this.data});
  @override
  RequestOptions? getConfig() {
    switch (type) {
      case ApiType.fetchListImage:
        return RequestOptions(method: ApiMethod.post, data: data);
      case ApiType.checkEmail:
        return RequestOptions(method: ApiMethod.post, data: data);

      case ApiType.fetchEventsDetails:
        return RequestOptions(method: ApiMethod.post, data: data);

      case ApiType.signIn:
        return RequestOptions(method: ApiMethod.post, data: data);
      case ApiType.searchEventsByDate:
        return RequestOptions(method: ApiMethod.post, data: data);
      case ApiType.fetchUserInfo:
        return RequestOptions(method: ApiMethod.post, data: data);
      case ApiType.changePassword:
        return RequestOptions(method: ApiMethod.post, data: data);
      case ApiType.saveEvents:
        return RequestOptions(method: ApiMethod.post, data: data);
    }
  }
}
