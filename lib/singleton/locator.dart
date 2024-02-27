import 'package:ame/resources/api/api_client.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../resources/api/log_interceptor.dart';
import '../services/authentication_service.dart';

GetIt locator = GetIt.I;

void setLocatorUp() async {
  //SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // UserPreference preference = UserPreference(preferences: sharedPreferences);
  GetIt.I.registerLazySingleton(
    () => APIClient(BaseOptions(baseUrl: "https://bonako.dev:3005/graphql")),
  );
  final interceptors = [
    APILogInterceptor(),
    // AuthInterceptor(client: locator<APIClient>()),
  ];
  locator<APIClient>().instance.interceptors.addAll(interceptors);

  GetIt.I.registerLazySingleton(() => AuthenticationService());
}
