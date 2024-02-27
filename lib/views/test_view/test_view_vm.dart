import 'dart:convert';

import 'package:ame/resources/api/api_client.dart';
import 'package:ame/resources/api/api_response.dart';
import 'package:ame/resources/api/api_route.dart';
import 'package:ame/resources/api/log_interceptor.dart';
import 'package:ame/resources/models/fetch_characters.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../resources/base_view_model/base_view_model.dart';

class TestViewViewModel extends BaseViewModel {
  String title = "Template Title";
  late BuildContext context;

  init(BuildContext context) {
    this.context = context;
    // listFetching();
  }

  List<dynamic> characters = [];
  List<Results> characterList = [];
  //bool _loading = false;
  final dio = Dio(BaseOptions(
    baseUrl: "https://rickandmortyapi.com/graphql",
  ));

  listFetching() async {
    final fetchListApiservice = APIClient(BaseOptions(
      baseUrl: "https://rickandmortyapi.com/graphql",
    ));

    final interceptors = [
      APILogInterceptor(),
    ];
    fetchListApiservice.instance.interceptors.addAll(interceptors);
    setBusy(true);
    String query = r"""  query{  characters{ results{  name  image  }  }   }""";

    var response = await fetchListApiservice.request(
        route: ApiRoute(ApiType.fetchListImage),
        data: {"query": query},
        create: () => APIResponse<CharactersResponse>(
            create: () => CharactersResponse()));

    characterList = response.response.data!.characters!.results!;

    print(response.response.status);

    setBusy(false);
  }

  void fetchListWithDio() async {
    setBusy(true);
    String query = r"""  query{  characters{ results{  name  image  }  }   }""";

    try {
      dio.interceptors.add(APILogInterceptor());
      var response = await dio.post(
        "",
        data: {"query": query},
        // options: Options(
        //   headers: {
        //     HttpHeaders.contentTypeHeader: 'application/json',
        //   },
        // ),
      );

      characters = response.data!['data']['characters']['results'];

      setBusy(false);
      print(response.statusCode);
    } catch (e) {
      // print(response.s)
      print(e);
    }
  }
}
