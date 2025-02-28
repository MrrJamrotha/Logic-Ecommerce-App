import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/service/user_session_service.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/data/repositories/wishlist/wishlist_repository_impl.dart';
import 'package:logic_app/presentation/global/wishlist/wishlist_state.dart';

class WishlistCubit extends Cubit<WishlistState> {
  WishlistCubit({
    String categoryId = "",
    String brandId = "",
  }) : super(WishlistState()) {
    pagingController.addPageRequestListener((pageKey) {
      var ratings = (state.selectedRatings?.keys.toList() ?? []).isNotEmpty
          ? (state.selectedRatings!.keys.toList()..sort()).join(',')
          : '';
      var categories = (state.selectCategoryIds?.toList() ?? []).isNotEmpty
          ? (state.selectCategoryIds!.toList()..sort()).join(',')
          : categoryId;
      var brands = (state.selectBrandIds?.toList() ?? []).isNotEmpty
          ? (state.selectBrandIds!.toList()..sort()).join(',')
          : brandId;
      pagination(
        pageKey: pageKey,
        parameters: {
          'min_price': state.rangeValues?.start ?? "",
          'max_price': state.rangeValues?.end ?? "",
          'rating': ratings,
          'category_id': categories,
          'brand_id': brands,
        },
      );
    });
  }
  final pagingController = PagingController(firstPageKey: 1);
  final session = di.get<UserSessionService>();
  final repos = di.get<WishlistRepositoryImpl>();

  Future<void> getAuth() async {
    try {
      final auth = await session.user;
      if (auth != null) {
        emit(state.copyWith(isAuthenticated: true));
        await getWishlist();
      } else {
        emit(state.copyWith(isAuthenticated: false));
      }
    } catch (e) {
      addError(e);
    }
  }

  Future<void> getWishlist() async {
    try {
      await repos.getWishlist().then((response) {
        response.fold((failure) {
          showMessage(message: failure.message);
          emit(state.copyWith(errorMessage: failure.message));
        }, (success) {
          emit(state.copyWith(wishlists: response.success));
        });
      });
    } catch (e) {
      addError(e);
    }
  }

  Future<void> toggleWishlist({Map<String, dynamic>? parameters}) async {
    try {
      var wishlists = List.from(state.wishlists ?? []);

      // Check if the item is already in the wishlist
      final exists = wishlists.any((item) => item.id == parameters?['id']);

      if (exists) {
        // Remove from wishlist
        await repos.removeFromWishlist(parameters: parameters).then((response) {
          response.fold((failure) {
            showMessage(
              message: failure.message,
              status: MessageStatus.warning,
            );
            emit(state.copyWith(errorMessage: failure.message));
          }, (success) {
            wishlists.removeWhere((item) => item.id == parameters?['id']);
            emit(state.copyWith(wishlists: List.from(wishlists)));
            showMessage(message: response.message ?? "Removed from wishlist");
          });
        });
      } else {
        // Add to wishlist
        await repos.addToWishList(parameters: parameters).then((response) {
          response.fold((failure) {
            showMessage(
              message: failure.message,
              status: MessageStatus.warning,
            );
            emit(state.copyWith(errorMessage: failure.message));
          }, (success) {
            wishlists.add(success);
            emit(state.copyWith(wishlists: List.from(wishlists)));
            showMessage(message: response.message ?? "Added to wishlist");
          });
        });
      }
    } catch (e) {
      addError(e);
    }
  }

  Future<void> getMyWishlist({Map<String, dynamic>? parameters}) async {
    try {
      emit(state.copyWith(isLoading: true));
      pagination(pageKey: 1, parameters: parameters);
      emit(state.copyWith(isLoading: false));
    } catch (e) {
      addError(e);
    }
  }

  Future<void> pagination({
    int pageKey = 1,
    Map<String, dynamic>? parameters,
  }) async {
    try {
      if (pageKey == 1) {
        pagingController.refresh();
      }
      await repos.getMyWishlist(parameters: parameters).then((response) {
        response.fold((failure) {
          showMessage(message: failure.message);
          emit(state.copyWith(errorMessage: failure.message));
        }, (success) {
          var records = response.success ?? [];
          final isLastPage = response.currentPage >= response.lastPage;
          if (isLastPage) {
            pagingController.appendLastPage(records);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(records, nextPageKey);
          }

          emit(state.copyWith(
            records: response.success,
            categories: response.categories,
            brands: response.brands,
            priceRangeModel: response.priceRangeModel,
            rangeValues: RangeValues(
              AppFormat.toDouble(response.priceRangeModel?.minPrice),
              AppFormat.toDouble(response.priceRangeModel?.maxPrice),
            ),
            lastPage: response.lastPage,
            currentPage: response.currentPage,
          ));
        });
      });
    } catch (e) {
      pagingController.error = e;
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void selectCategoryIds(String id) {
    if (!(state.selectCategoryIds?.contains(id) ?? false)) {
      emit(
          state.copyWith(selectCategoryIds: [...?state.selectCategoryIds, id]));
    }
  }

  void removeCategoryIds(String id) {
    emit(
      state.copyWith(
        selectCategoryIds:
            state.selectCategoryIds?.where((item) => item != id).toList(),
      ),
    );
  }

  void selectBrandIds(String id) {
    if (!(state.selectBrandIds?.contains(id) ?? false)) {
      emit(state.copyWith(selectBrandIds: [...?state.selectBrandIds, id]));
    }
  }

  void removeBrandIds(String id) {
    emit(
      state.copyWith(
        selectBrandIds:
            state.selectBrandIds?.where((item) => item != id).toList(),
      ),
    );
  }

  void priceRangeChange(RangeValues values) {
    emit(state.copyWith(rangeValues: values));
  }

  void selectStars(int rating, bool isSelected) {
    final updatedRatings = Map<int, bool>.from(state.selectedRatings ?? {});

    if (isSelected) {
      updatedRatings[rating] = true;
    } else {
      updatedRatings.remove(rating);
    }

    emit(state.copyWith(selectedRatings: updatedRatings));
  }

  Future<void> filterProducts() async {
    try {
      var ratings = (state.selectedRatings?.keys.toList() ?? []).isNotEmpty
          ? (state.selectedRatings!.keys.toList()..sort()).join(',')
          : '';
      var categories = (state.selectCategoryIds?.toList() ?? []).isNotEmpty
          ? (state.selectCategoryIds!.toList()..sort()).join(',')
          : '';
      var brands = (state.selectBrandIds?.toList() ?? []).isNotEmpty
          ? (state.selectBrandIds!.toList()..sort()).join(',')
          : '';
      emit(state.copyWith(selectCategoryId: ""));
      await pagination(
        pageKey: 1,
        parameters: {
          'min_price': state.rangeValues?.start,
          'max_price': state.rangeValues?.end,
          'rating': ratings,
          'category_id': categories,
          'brand_id': brands,
        },
      );
    } catch (e) {
      addError(e);
    }
  }

  void filterByCategory({
    String merchantId = "",
    required String categoryId,
  }) async {
    emit(state.copyWith(
      selectCategoryId: categoryId,
      selectBrandId: "",
      selectCategoryIds: [],
      selectBrandIds: [],
      selectedRatings: null,
      rangeValues: RangeValues(0, 0),
    ));
    await getMyWishlist(parameters: {
      'category_id': categoryId,
      'merchant_id': merchantId,
      'min_price': '',
      'max_price': '',
      'rating': '',
      'brand_id': '',
    });
  }

  @override
  Future<void> close() {
    pagingController.dispose();
    return super.close();
  }

  @override
  void addError(Object error, [StackTrace? stackTrace]) {
    logger.e(error, stackTrace: stackTrace);
    super.addError(error, stackTrace);
  }
}
