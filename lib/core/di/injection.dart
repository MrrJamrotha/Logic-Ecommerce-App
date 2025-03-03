import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:foxShop/data/remote/search/typesense_client.dart';
import 'package:foxShop/data/repositories/cart/cart_repository_impl.dart';
import 'package:foxShop/data/repositories/checkout/check_out_repository_impl.dart';
import 'package:foxShop/data/repositories/order/order_repository_impl.dart';
import 'package:foxShop/data/repositories/search/search_repository_impl.dart';
import 'package:get_it/get_it.dart';
import 'package:foxShop/core/locale/locale_manager.dart';
import 'package:foxShop/core/service/database_service.dart';
import 'package:foxShop/core/service/geocoding_service.dart';
import 'package:foxShop/core/service/geolocator_service.dart';
import 'package:foxShop/core/service/photo_manager_service.dart';
import 'package:foxShop/core/service/secure_storage_service.dart';
import 'package:foxShop/core/service/shared_preferences_service.dart';
import 'package:foxShop/core/service/user_session_service.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:http/http.dart' as http;
import 'package:foxShop/data/repositories/address/address_repository_impl.dart';
import 'package:foxShop/data/repositories/auth/auth_repository_impl.dart';
import 'package:foxShop/data/repositories/brand/brand_repository_impl.dart';
import 'package:foxShop/data/repositories/category/category_repository_impl.dart';
import 'package:foxShop/data/repositories/fetching_item/fetching_item_repository_impl.dart';
import 'package:foxShop/data/repositories/home/home_repository_impl.dart';
import 'package:foxShop/data/repositories/item_detail/item_detail_repository_impl.dart';
import 'package:foxShop/data/repositories/merchant/merchant_repository_impl.dart';
import 'package:foxShop/data/repositories/product_by_brand/product_by_brand_repository_impl.dart';
import 'package:foxShop/data/repositories/product_by_category/product_by_category_repository_impl.dart';
import 'package:foxShop/data/repositories/user/user_repository_impl.dart';
import 'package:foxShop/data/repositories/wishlist/wishlist_repository_impl.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

final di = GetIt.instance;
void setupInjector() {
  //API
  di.registerLazySingleton<http.Client>(() => http.Client());
  di.registerLazySingleton<ApiClient>(() => ApiClient(http.Client()));

  di.registerLazySingleton<TypesenseClient>(() => TypesenseClient());

  //Repositories
  di.registerLazySingleton<UserRepositoryImpl>(() => UserRepositoryImpl());
  di.registerLazySingleton<HomeRepositoryImpl>(() => HomeRepositoryImpl());
  di.registerLazySingleton<CategoryRepositoryImpl>(
      () => CategoryRepositoryImpl());

  di.registerLazySingleton<BrandRepositoryImpl>(() => BrandRepositoryImpl());
  di.registerLazySingleton<FetchingItemRepositoryImpl>(
      () => FetchingItemRepositoryImpl());

  di.registerLazySingleton<ItemDetailRepositoryImpl>(
      () => ItemDetailRepositoryImpl());

  di.registerLazySingleton<MerchantRepositoryImpl>(
      () => MerchantRepositoryImpl());

  di.registerLazySingleton<ProductByCategoryRepositoryImpl>(
      () => ProductByCategoryRepositoryImpl());

  di.registerLazySingleton<ProductByBrandRepositoryImpl>(
      () => ProductByBrandRepositoryImpl());

  di.registerLazySingleton<AuthRepositoryImpl>(() => AuthRepositoryImpl());
  di.registerLazySingleton<AddressRepositoryImpl>(
      () => AddressRepositoryImpl());

  di.registerLazySingleton<WishlistRepositoryImpl>(
      () => WishlistRepositoryImpl());

  di.registerLazySingleton<CartRepositoryImpl>(() => CartRepositoryImpl());
  di.registerLazySingleton<CheckOutRepositoryImpl>(
      () => CheckOutRepositoryImpl());

  di.registerLazySingleton<SearchRepositoryImpl>(() => SearchRepositoryImpl());
  di.registerLazySingleton<OrderRepositoryImpl>(() => OrderRepositoryImpl());

  //Services
  di.registerLazySingleton<GeocodingService>(() => GeocodingService());
  di.registerSingleton<DatabaseService>(DatabaseService.instance);
  di.registerLazySingleton<LocaleManager>(() => LocaleManager());
  di.registerLazySingleton<PhotoManagerService>(
      () => PhotoManagerService.instance);
  di.registerLazySingleton<UserSessionService>(
      () => UserSessionService.instance);
  di.registerLazySingleton<SharedPreferencesService>(
      () => SharedPreferencesService.instance);

  di.registerLazySingleton<BaseCacheManager>(() => DefaultCacheManager());

  di.registerLazySingleton<SecureStorageService>(() => SecureStorageService());
  di.registerLazySingleton<GeolocatorService>(() => GeolocatorService());
  di.registerSingleton<PusherChannelsFlutter>(
      PusherChannelsFlutter.getInstance());
}
