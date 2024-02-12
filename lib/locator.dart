import 'package:ame/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api/log_interceptor.dart';

GetIt locator = GetIt.I;

void setLocatorUp()async{
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();


 // UserPreference preference = UserPreference(preferences: sharedPreferences);

  ()=> APIClient(
      BaseOptions(
    baseUrl: "https://api.muskaapp.com"
    )
  );
  final interceptors = [
    APILogInterceptor(),
   // AuthInterceptor(client: locator<APIClient>()),
  ];
  locator<APIClient>().instance.interceptors.addAll(interceptors);
}