import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/address_model.dart';

abstract class AddressRepository {
  Future<Result<List<AddressModel>, Failure>> getUserAddress({
    Map<String, dynamic>? parameters,
  });

  Future<Result<AddressModel, Failure>> getAddressById({
    Map<String, dynamic>? parameters,
  });

  Future<Result<AddressModel, Failure>> createAddress({
    Map<String, dynamic>? parameters,
  });

  Future<Result<AddressModel, Failure>> updateAddress({
    Map<String, dynamic>? parameters,
  });

  Future<Result<AddressModel, Failure>> deleteAddress({
    Map<String, dynamic>? parameters,
  });

  Future<Result<AddressModel, Failure>> setDefaultAddress({
    Map<String, dynamic>? parameters,
  });
}
