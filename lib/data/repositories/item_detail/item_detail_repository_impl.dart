import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/item_detail_model.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/item_detail/item_detail_repository.dart';

class ItemDetailRepositoryImpl implements ItemDetailRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<List<ProductModel>, Failure>> getRelatedProduct({
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
  Future<Result<ItemDetailModel, Failure>> getItemDetail({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getItemDetail(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final record = ItemDetailModel.fromJson(result.data);
      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
