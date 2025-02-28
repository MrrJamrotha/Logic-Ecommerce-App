import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/brand_model.dart';

abstract class BrandRepository {
  Future<Result<List<BrandModel>, Failure>> getBrands({
    Map<String, dynamic>? parameters,
  });
}
