import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/models/slide_show_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/home/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<SlideShowModel>, Failure>> getSlideShow({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getSlideShow(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }

      final records = (result.data as List<dynamic>).map((item) {
        return SlideShowModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<BrandModel>, Failure>> getBrands({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getBrands(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }

      final records = (result.data as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<CategoryModel>, Failure>> getBrowseCategories({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getBrowseCategories(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getRecommendedForYou({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getRecommendForYou(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getProductNewArrivals({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getProductNewArrivals(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getProductBastReview({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getProductBastReview(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getSpacialProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getSpacialProduct(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      return Result.right(records, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
