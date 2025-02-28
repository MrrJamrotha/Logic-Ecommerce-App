import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/presentation/global/wishlist/wishlist_cubit.dart';
import 'package:logic_app/presentation/global/wishlist/wishlist_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/product_card_widget.dart';
import 'package:logic_app/presentation/widgets/rating_bar_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class WishlistScreen extends StatefulWidget {
  const WishlistScreen({super.key});
  static const routeName = 'wishlist';

  @override
  State<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  List<int> ratings = [5, 4, 3, 2, 1];
  final screenCubit = WishlistCubit();
  @override
  void initState() {
    screenCubit.getMyWishlist();
    super.initState();
  }

  showFilterModal() {
    showModalBottomSheet(
      backgroundColor: appWhite,
      context: context,
      useSafeArea: true,
      isScrollControlled: true,
      useRootNavigator: true,
      isDismissible: true,
      showDragHandle: true,
      builder: (context) {
        return BlocBuilder<WishlistCubit, WishlistState>(
          bloc: screenCubit,
          builder: (context, state) {
            final categories = state.categories ?? [];
            final brands = state.brands ?? [];
            final priceRange = state.rangeValues;
            if (priceRange == null) {
              return SizedBox.expand();
            }

            var selectCategoryIds = state.selectCategoryIds ?? [];
            var selectBrandIds = state.selectBrandIds ?? [];
            return SingleChildScrollView(
              padding: EdgeInsets.all(appPedding.scale),
              child: Column(
                spacing: appSpace.scale,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (categories.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: appSpace.scale,
                      children: [
                        TextWidget(
                          text: 'categories'.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.scale,
                        ),
                        Divider(
                          height: 1,
                          color: textColor,
                        ),
                        Wrap(
                            runSpacing: appSpace.scale,
                            spacing: appSpace.scale,
                            children: categories.map((record) {
                              return FilterChip(
                                backgroundColor: appWhite,
                                label: TextWidget(
                                  text: record.name,
                                  color: selectCategoryIds.contains(record.id)
                                      ? appWhite
                                      : appBlack,
                                ),
                                selected: selectCategoryIds.contains(record.id),
                                selectedColor: primary,
                                checkmarkColor:
                                    selectCategoryIds.contains(record.id)
                                        ? appWhite
                                        : appBlack,
                                deleteIconColor:
                                    selectCategoryIds.contains(record.id)
                                        ? appWhite
                                        : appBlack,
                                onSelected: (bool value) {
                                  screenCubit.selectCategoryIds(record.id);
                                },
                                onDeleted: () {
                                  screenCubit.removeCategoryIds(record.id);
                                },
                              );
                            }).toList()),
                      ],
                    ),
                  if (brands.isNotEmpty)
                    Column(
                      spacing: appSpace.scale,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextWidget(
                          text: 'brands'.tr,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.scale,
                        ),
                        Divider(
                          height: 1,
                          color: textColor,
                        ),
                        Wrap(
                            runSpacing: appSpace.scale,
                            spacing: appSpace.scale,
                            children: brands.map((record) {
                              return FilterChip(
                                backgroundColor: appWhite,
                                label: TextWidget(
                                  text: record.name,
                                  color: selectBrandIds.contains(record.id)
                                      ? appWhite
                                      : appBlack,
                                ),
                                selected: selectBrandIds.contains(record.id),
                                selectedColor: primary,
                                checkmarkColor: appWhite,
                                deleteIconColor:
                                    selectBrandIds.contains(record.id)
                                        ? appWhite
                                        : appBlack,
                                onSelected: (bool value) {
                                  screenCubit.selectBrandIds(record.id);
                                },
                                onDeleted: () {
                                  screenCubit.removeBrandIds(record.id);
                                },
                              );
                            }).toList()),
                      ],
                    ),
                  TextWidget(
                    text: 'price_range'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.scale,
                  ),
                  Divider(
                    height: 1,
                    color: textColor,
                  ),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextWidget(
                            text: state.rangeValues!.start.toStringAsFixed(2),
                          ),
                          TextWidget(
                            text: state.rangeValues!.end.toStringAsFixed(2),
                          )
                        ],
                      ),
                      RangeSlider(
                        inactiveColor: unratedColor,
                        activeColor: primary,
                        values: state.rangeValues ?? RangeValues(0, 1),
                        min:
                            AppFormat.toDouble(state.priceRangeModel?.minPrice),
                        max:
                            AppFormat.toDouble(state.priceRangeModel?.maxPrice),
                        divisions: 5,
                        labels: RangeLabels(
                          state.rangeValues!.start.toStringAsFixed(2),
                          state.rangeValues!.end.toStringAsFixed(2),
                        ),
                        onChanged: (RangeValues values) {
                          screenCubit.priceRangeChange(values);
                        },
                      ),
                    ],
                  ),
                  TextWidget(
                    text: 'product_rating'.tr,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.scale,
                  ),
                  Divider(
                    height: 1,
                    color: textColor,
                  ),
                  Column(
                    children: ratings.map((rating) {
                      return CheckboxListTile.adaptive(
                        contentPadding: EdgeInsets.zero,
                        title: RatingBarWidget(
                          itemSize: 20.scale,
                          rating: rating.toDouble(),
                        ),
                        value: state.selectedRatings?[rating] ?? false,
                        onChanged: (value) {
                          screenCubit.selectStars(rating, value ?? false);
                        },
                      );
                    }).toList(),
                  ),
                  ButtonWidget(
                    title: 'show_results'.tr,
                    onPressed: () {
                      screenCubit.filterProducts();
                      Navigator.pop(context);
                    },
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void selectFilterProductByCategory(String id) {
    screenCubit.filterByCategory(categoryId: id.isEmpty ? "" : id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'wishlist'.tr,
        isFilter: true,
        onTapFilter: () {
          showFilterModal();
        },
      ),
      body: BlocBuilder<WishlistCubit, WishlistState>(
        bloc: screenCubit,
        builder: (BuildContext context, WishlistState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(WishlistState state) {
    final categories = state.categories ?? [];
    final double width = AppSizeConfig.screenWidth;
    double widthCard = 170.scale;
    int countRow = width ~/ widthCard;
    return CustomScrollView(
      key: Key('fetching'),
      slivers: [
        SliverFloatingHeader(
          child: _buildHorizontalList(
            items: categories,
            selectId: state.selectCategoryId ?? "",
            onPressed: selectFilterProductByCategory,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.all(appPedding.scale),
          sliver: PagedSliverAlignedGrid.count(
            pagingController: screenCubit.pagingController,
            builderDelegate: PagedChildBuilderDelegate<dynamic>(
              itemBuilder: (context, record, index) {
                return ProductCardWidget(
                  key: ValueKey(record.id),
                  record: record,
                  isLoading: false,
                );
              },
              firstPageProgressIndicatorBuilder: (_) => centerLoading(),
              newPageProgressIndicatorBuilder: (_) => centerLoading(),
              noItemsFoundIndicatorBuilder: (_) => centerNotFoundProduct(),
            ),
            crossAxisCount: countRow,
            crossAxisSpacing: appSpace.scale,
            mainAxisSpacing: appSpace.scale,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalList({
    required List<dynamic> items,
    required String selectId,
    required void Function(String) onPressed,
  }) {
    return Container(
      color: appWhite,
      height: 75.scale,
      child: ListView.builder(
        padding: EdgeInsets.all(appPedding.scale),
        itemCount: items.length + 1,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildTextButton(
              id: "",
              title: 'all'.tr,
              selectId: selectId,
              onPressed: () => onPressed(""),
            );
          }
          final record = items[index - 1];
          return _buildTextButton(
            id: record.id,
            title: record.name,
            selectId: selectId,
            onPressed: () => onPressed(record.id),
          );
        },
      ),
    );
  }

  _buildTextButton({
    required id,
    required String title,
    Function()? onPressed,
    required String selectId,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: appSpace.scale),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            // ignore: deprecated_member_use
            color: selectId == id ? primary : textColor.withOpacity(0.5),
          ),
          backgroundColor: selectId == id ? primary : appWhite,
          padding: EdgeInsets.all(appSpace.scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(appRadius.scale),
          ),
        ),
        child: TextWidget(
          text: title,
          color: selectId == id ? appWhite : appBlack,
          fontSize: 14.scale,
        ),
      ),
    );
  }
}
