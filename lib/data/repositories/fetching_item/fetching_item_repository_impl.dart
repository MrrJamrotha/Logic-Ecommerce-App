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
      final categories = (result.data2 as List<dynamic>).map((item) {
        return CategoryModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      final brands = (result.data3 as List<dynamic>).map((item) {
        return BrandModel.fromJson(item as Map<String, dynamic>);
      }).toList();
      final priceRangeModel = PriceRangeModel.fromJson(result.data4);
      return Result(
        success: records,
        categories: categories,
        brands: brands,
        priceRangeModel: priceRangeModel,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      throw GenericFailure(error.toString());
    }
  }
}
