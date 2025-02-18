import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:logic_app/core/service/database_service.dart';
import 'package:logic_app/core/service/geolocator_service.dart';
import 'package:logic_app/core/service/photo_manager_service.dart';
import 'package:logic_app/core/service/secure_storage_service.dart';
import 'package:logic_app/core/service/shared_preferences_service.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:logic_app/data/repositories/brand/brand_repository_impl.dart';
import 'package:logic_app/data/repositories/category/category_repository_impl.dart';
import 'package:logic_app/data/repositories/home/home_repository_impl.dart';
import 'package:logic_app/data/repositories/user/user_repository_impl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

final di = GetIt.instance;
void setupInjector() {
  di.registerSingleton<DatabaseService>(DatabaseService.instance);
  di.registerLazySingleton<http.Client>(() => http.Client());
  di.registerLazySingleton<ApiClient>(() => ApiClient(http.Client()));
  di.registerLazySingleton<PhotoManagerService>(
      () => PhotoManagerService.instance);

  di.registerLazySingleton<BaseCacheManager>(() => DefaultCacheManager());

  di.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  di.registerLazySingleton<GeolocatorService>(() => GeolocatorService());
  di.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService.instance);

  di.registerSingleton<PusherChannelsFlutter>(
      PusherChannelsFlutter.getInstance());

  //repositories
  di.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl());
  di.registerLazySingleton<HomeRepositoryImpl>(() => HomeRepositoryImpl());
  di.registerLazySingleton<CategoryRepositoryImpl>(
      () => CategoryRepositoryImpl());

  di.registerLazySingleton<BrandRepositoryImpl>(() => BrandRepositoryImpl());
}
