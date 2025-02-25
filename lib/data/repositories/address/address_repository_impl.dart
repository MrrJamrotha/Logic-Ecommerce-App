import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/address_model.dart';
import 'package:logic_app/data/remote/network/api_client.dart';
import 'package:logic_app/data/repositories/address/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final _apiClient = di.get<ApiClient>();

  @override
  Future<Result<List<AddressModel>, Failure>> getUserAddress({
    Map<String, dynamic>? parameters,
  }) async {
    try {
      final result = await _apiClient.getUserAddress();
      if (result.status != 'success') {
        return Result.left(Failure(result.message));
      }
      List<AddressModel> records = [];
      for (var address in result.data) {
        records.add(AddressModel.fromJson(address));
      }
      return Result.right(
        records,
        message: result.message,
        lastPage: result.lastPage,
        currentPage: result.currentPage,
      );
    } catch (error) {
      return Result.left(Failure(error.toString()));
    }
  }
}
