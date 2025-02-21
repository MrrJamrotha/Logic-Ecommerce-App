import 'package:logic_app/data/models/item_detail_model.dart';
import 'package:logic_app/data/models/product_model.dart';

class ItemDetailState {
  final bool isLoading;
  final bool isLoadingRelatedProduct;
  final String? error;
  final List<ProductModel>? relatedProducts;
  final ItemDetailModel? itemDetailModel;

  const ItemDetailState({
    this.isLoading = false,
    this.isLoadingRelatedProduct = false,
    this.error,
    this.relatedProducts,
    this.itemDetailModel,
  });

  ItemDetailState copyWith({
    bool? isLoading,
    String? error,
    bool? isLoadingRelatedProduct,
    List<ProductModel>? relatedProducts,
    ItemDetailModel? itemDetailModel,
  }) {
    return ItemDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isLoadingRelatedProduct:
          isLoadingRelatedProduct ?? this.isLoadingRelatedProduct,
      relatedProducts: relatedProducts ?? this.relatedProducts,
      itemDetailModel: itemDetailModel ?? this.itemDetailModel,
    );
  }
}
