import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import 'api_route.dart';
import 'api_response.dart';
import 'from_json.dart';

abstract class BaseAPIClient {
  Future<ResponseWrapper<T>> request<T extends FromJson>({
    required APIRouteConfigurable route,
    required Create<T> create,
    dynamic data,
  });
}

class APIClient implements BaseAPIClient {
  final BaseOptions options;
  late Dio instance;

  APIClient(this.options) {
    instance = Dio(options);

    //bad certificate fix TODO: remove before going live
    instance.httpClientAdapter = IOHttpClientAdapter(createHttpClient: () {
      final client = HttpClient();
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    });
  }

  @override
  Future<ResponseWrapper<T>> request<T extends FromJson>({
    required APIRouteConfigurable route,
    required Create<T> create,
    dynamic data,
  }) async {
    final config = route.getConfig();
    if (config == null) {
      throw ErrorResponse(message: 'Failed to load request options.');
    }

    //SharedPreferences preferences = await SharedPreferences.getInstance();
    //config.headers['Device-SerialNos'] = preferences.getString("MSERIAL") ?? "";

    config.baseUrl = options.baseUrl;
    if (data != null) {
      if (config.method == ApiMethod.get) {
        config.queryParameters = data;
      } else {
        config.data = data;
      }
    }
    try {
      final response = await instance.fetch(config);
      return ResponseWrapper.init(create: create, data: response.data);
    } on DioException catch (e) {
      debugPrint(e.response?.data.toString());
      if (e.error is SocketException) {
        return ResponseWrapper.init(create: create, data: {
          "status": "50",
          "message": "${e.message}",
        });
      } else {
        return ResponseWrapper.init(create: create, data: {
          "status": "50",
          "message": "An error occured, please try again later",
        });
      }
    } catch (e) {
      debugPrint(e.toString());

      //debugPrint(s.toString());
      return ResponseWrapper.init(create: create, data: {
        "status": "50",
        "message": "An error occured, please try again later",
      });
    }
    //  on DioError {

    //   return ResponseWrapper.init(create: create, data: {
    //     "status": "50",
    //     "message": "An error occured, please try again later"
    //   });
    //throw ErrorResponse(message: err.message);
    //  }
  }
}
