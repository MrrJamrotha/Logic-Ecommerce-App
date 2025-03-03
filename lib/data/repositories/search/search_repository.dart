import 'package:foxShop/core/common/result.dart';
import 'package:foxShop/core/common/product_search_response.dart';
import 'package:foxShop/core/error/failure.dart';
import 'package:foxShop/data/models/product_model.dart';

abstract class SearchRepository {
  Future<Result<List<ProductModel>, Failure>> searchProduct({
    Map<String, dynamic>? parameters,
  });

  Future<Result<ProductSearchResponse, Failure>> typesenceProduct(
    String query,
  );
}
