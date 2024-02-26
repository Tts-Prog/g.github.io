import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'from_json.dart';

///A function that creates an object of type [T]
typedef Create<T> = T Function();

///Construct to get object from generic class
abstract class GenericObject<T> {
  Create<FromJson> create;

  GenericObject({required this.create});

  T genericObject(dynamic data) {
    final item = create();
    return item.fromJson(data);
  }
}

///Construct to wrap response from API.
///
///Used it as return object of APIController to handle any kind of response.
class ResponseWrapper<T> extends GenericObject<T> {
  late T response;

  ResponseWrapper({required Create<FromJson> create}) : super(create: create);

  factory ResponseWrapper.init(
      {required Create<FromJson> create, required dynamic data}) {
    final wrapper = ResponseWrapper<T>(create: create);
    wrapper.response = wrapper.genericObject(data);
    return wrapper;
  }
}

class APIResponse<T> extends GenericObject<T>
    implements FromJson<APIResponse<T>> {
  String? status;
  String? message;
  dynamic nMeta;
  dynamic nLinks;
  dynamic error;
  T? data;
  T? errorData;
  String? errorMessage;
  APIResponse({required Create<FromJson> create}) : super(create: create);

  @override
  APIResponse<T> fromJson(dynamic json) {
    try {
      status = json['status'];
      message = json['message'];
      if (message != null &&
          message!.isNotEmpty &&
          message!.contains("exception")) {
        message = "An error occurred, please try again later.";
      }
      nMeta = json['_meta'];
      nLinks = json['_links'];
      if (json['data'] != null) {
        data = genericObject(json['data']);
      }
      if (json['errors'] != null) {
        List<dynamic> errorList = (json["errors"]) as List<dynamic>;

        // error = json["errors"];
        // errorData = genericObject(errorList.first);
        error = jsonEncode(errorList[0]);
        final errorMap = jsonDecode(error) as Map;
        errorMessage = errorMap["message"];
      }
    } catch (e, stackTrace) {
      debugPrint(e.toString());
      debugPrint(stackTrace.toString());

      // status = "999";
      // message = "An error occurred";
      debugPrint("mobile app parsing_error");
    }
    return this;
  }
}

class ErrorResponse implements Exception {
  String? message;

  ErrorResponse({this.message});

  factory ErrorResponse.fromJson(Map<String, dynamic> json) {
    return ErrorResponse(message: json['message'] ?? 'Something went wrong.');
  }

  @override
  String toString() {
    return message ?? 'Failed to convert message to string.';
  }
}
