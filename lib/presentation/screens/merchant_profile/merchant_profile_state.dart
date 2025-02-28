import 'package:foxShop/data/models/merchant_model.dart';
import 'package:foxShop/data/models/product_model.dart';

class MerchantProfileState {
  final bool isLoading;
  final String? error;
  final MerchantModel? record;
  final bool isLoadingProduct;
  final List<ProductModel>? products;
  final int currentPage;
  final int lastPage;

  const MerchantProfileState({
    this.isLoading = false,
    this.error,
    this.record,
    this.isLoadingProduct = false,
    this.products,
    this.currentPage = 1,
    this.lastPage = 1,
  });

  MerchantProfileState copyWith({
    bool? isLoading,
    String? error,
    MerchantModel? record,
    bool? isLoadingProduct,
    List<ProductModel>? products,
    int? currentPage,
    int? lastPage,
  }) {
    return MerchantProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      record: record ?? this.record,
      isLoadingProduct: isLoadingProduct ?? this.isLoadingProduct,
      products: products ?? this.products,
      currentPage: currentPage ?? this.currentPage,
      lastPage: lastPage ?? this.lastPage,
    );
  }
}
