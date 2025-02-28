import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/di/injection.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/merchant_model.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/data/remote/network/api_client.dart';
import 'package:foxShop/data/repositories/merchant/merchant_repository.dart';

class MerchantRepositoryImpl implements MerchantRepository {
  final _apiClient = di.get<ApiClient>();
  @override
  Future<Result<MerchantModel, Failure>> getMerchantProfile({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getMerchantProfile(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      final record = MerchantModel.fromJson(result.data);
      return Result.right(record, message: result.message);
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }

  @override
  Future<Result<List<ProductModel>, Failure>> getProductByMerchant({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result =
          await _apiClient.getProductByMerchnat(parameters: parameters);
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
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
      return Result.left(Failure(error.toString()));
    }
  }
}
