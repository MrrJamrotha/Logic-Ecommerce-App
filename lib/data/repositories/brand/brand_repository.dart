import 'package:logic_app/core/common/result.dart';
import 'package:logic_app/data/models/brand_model.dart';

abstract class BrandRepository {
  Future<Result<List<BrandModel>, dynamic>> getBrands({
    Map<String, dynamic>? parameters,
  });
}
