import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/brand_model.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/price_range_model.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/fetching_item/fetching_item_repository.dart';

class FetchingItemRepositoryImpl implements FetchingItemRepository {
  final _apiClient = di.get<ApiClient>();

  @override
  Future<Result<List<ProductModel>, dynamic>> getRecommendedForYou({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getRecommendForYou(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result(
        success: records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }

  @override
  Future<Result<List<ProductModel>, dynamic>> getBastSeller({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getProductBastReview(parameters: parameters);

      if (result.status != 'success') {
        return Result(failed: result.message);
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);

      return Result(
        success: records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }

  @override
  Future<Result<List<ProductModel>, dynamic>> getNewArrival({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getProductNewArrivals(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result(
        success: records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }

  @override
  Future<Result<List<ProductModel>, dynamic>> getSpacialProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getSpacialProduct(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result(
        success: records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }

  @override
  Future<Result<List<ProductModel>, dynamic>> getRelatedProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getRelatedProduct(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result(
        success: records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      if (error is ServerFailure) {
        return Result(failed: "Server error: ${error.message}");
      } else if (error is NetworkFailure) {
        return Result(failed: "Network error: ${error.message}");
      } else if (error is CacheFailure) {
        return Result(failed: "Cache error: ${error.message}");
      } else {
        return Result(failed: "Unexpected error: ${error.toString()}");
      }
    }
  }
}
