import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:logic_app/core/service/database_service.dart';
import 'package:logic_app/core/service/photo_manager_service.dart';
import 'package:logic_app/core/service/secure_storage_service.dart';
import 'package:logic_app/core/service/shared_preferences_service.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:http/http.dart' as http;

final di = GetIt.instance;
void setupInjector() {
  di.registerLazySingleton<http.Client>(() => http.Client());
  di.registerLazySingleton<ApiClient>(() => ApiClient(http.Client()));
  di.registerLazySingleton<PhotoManagerService>(
      () => PhotoManagerService.instance);

  di.registerLazySingleton<BaseCacheManager>(() => DefaultCacheManager());
  di.registerLazySingleton<DatabaseService>(() => DatabaseService.instance);
  di.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  di.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService.instance);
}
