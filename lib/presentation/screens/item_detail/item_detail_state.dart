import 'package:logic_app/data/models/product_model.dart';

class ItemDetailState {
  final bool isLoading;
  final bool isLoadingRelatedProduct;
  final String? error;
  final List<ProductModel>? relatedProducts;

  const ItemDetailState({
    this.isLoading = false,
    this.isLoadingRelatedProduct = false,
    this.error,
    this.relatedProducts,
  });

  ItemDetailState copyWith({
    bool? isLoading,
    String? error,
    bool? isLoadingRelatedProduct,
    List<ProductModel>? relatedProducts,
  }) {
    return ItemDetailState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      isLoadingRelatedProduct:
          isLoadingRelatedProduct ?? this.isLoadingRelatedProduct,
      relatedProducts: relatedProducts ?? this.relatedProducts,
    );
  }
}
