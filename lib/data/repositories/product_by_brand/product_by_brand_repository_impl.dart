import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/category_model.dart';
import 'package:logic_app/data/models/price_range_model.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/product_by_brand/product_by_brand_repository.dart';

class ProductByBrandRepositoryImpl implements ProductByBrandRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<ProductModel>, dynamic>> getProductByBrand({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getProductByBrand(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final categories = (result.categories as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result.right(
        records,
        categories: categories,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(error);
    }
  }
}
