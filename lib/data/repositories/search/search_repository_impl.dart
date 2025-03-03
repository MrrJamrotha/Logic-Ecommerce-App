import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/common/product_search_response.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/category_model.dart';
import 'package:foxShop/data/models/price_range_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/remote/search/typesense_client.dart';
import 'package:foxShop/data/repositories/search/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final _apiClient = di<ApiClient>();
  final _typesense = di<TypesenseClient>();

  @override
  Future<Result<List<ProductModel>, Failure>> searchProduct({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.searchProducts(parameters: parameters);
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
  Future<Result<ProductSearchResponse, Failure>> typesenceProduct(
    String query, {
    int page = 1,
    int perPage = 16,
  }) async {
    final searchParameters = {
      'q': query,
      'query_by': 'name,name_2',
      'per_page': perPage.toString(),
      'page': page.toString(),
    };

    try {
      final response = await _typesense.client
          .collection('products_index')
          .documents
          .search(searchParameters);
      final responseData = response;
      final typesenseResponse = ProductSearchResponse.fromJson(responseData);

      return Result.right(typesenseResponse);
    } catch (e) {
      return Result.left(Failure(e.toString()));
    }
  }
}
