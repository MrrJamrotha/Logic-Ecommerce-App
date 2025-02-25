import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/core/error/failure.dart';
import 'package:logic_app/data/models/address_model.dart';

abstract class AddressRepository {
  Future<Result<List<AddressModel>, Failure>> getUserAddress({
    Map<String, dynamic>? parameters,
  });
}
