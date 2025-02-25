import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/data/models/merchant_model.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/merchant/merchant_repository.dart';

class MerchantRepositoryImpl implements MerchantRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<MerchantModel, dynamic>> getMerchantProfile({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getMerchantProfile(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }
      final record = MerchantModel.fromJson(result.data);
      return Result(success: record);
    } catch (error) {
      return Result.left(error);
    }
  }

  @override
  Future<Result<List<ProductModel>, dynamic>> getProductByMerchant({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getProductByMerchnat(parameters: parameters);
      if (result.status != 'success') {
        return Result(failed: result.message);
      }

      final records = (result.data as List<dynamic>).map((item) {
        return ProductModel.fromJson(item as Map<String, dynamic>);
      }).toList();

      return Result(
        success: records,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(error);
    }
  }
}
