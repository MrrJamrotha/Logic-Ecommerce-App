import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/price_range_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/fetching_item/fetching_item_repository.dart';

class FetchingItemRepositoryImpl implements FetchingItemRepository {
  final _apiClient = di.get<ApiClient>();

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
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result.right(
        records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getBastSeller({
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
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);

      return Result.right(
        records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getNewArrival({
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
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result.right(
        records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
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
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result.right(
        records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getRelatedProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getRelatedProduct(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
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
      return Result.right(
        records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
