import 'package:get_it/get_it.dart';
import 'package:logic_app/core/service/photo_manager_service.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:http/http.dart' as http;

final di = GetIt.instance;
void setup() {
  di.registerLazySingleton<http.Client>(() => http.Client());
  di.registerLazySingleton<ApiClient>(() => ApiClient(http.Client()));
  di.registerLazySingleton<PhotoManagerService>(
      () => PhotoManagerService.instance);
}
