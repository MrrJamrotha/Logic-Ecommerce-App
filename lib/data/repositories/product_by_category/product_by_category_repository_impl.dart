import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/brand_model.dart';
import 'package:foxShop/data/models/price_range_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/product_by_category/product_by_category_repository.dart';

class ProductByCategoryRepositoryImpl implements ProductByCategoryRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<ProductModel>, Failure>> getProductByCategory({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getProductByCategory(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }

      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.brands as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.priceRange);
      return Result(
        success: records,
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
