import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/presentation/screens/product_by_category/product_by_category_cubit.dart';
import 'package:logic_app/presentation/screens/product_by_category/product_by_category_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/product_card_widget.dart';
import 'package:logic_app/presentation/widgets/rating_bar_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ProductByCategoryScreen extends StatefulWidget {
  const ProductByCategoryScreen({
    super.key,
    required this.parameters,
  });
  final Map<String, dynamic> parameters;
  @override
  ProductByCategoryScreenState createState() => ProductByCategoryScreenState();
}

class ProductByCategoryScreenState extends State<ProductByCategoryScreen> {
  final screenCubit = ProductByCategoryCubit();
  List<int> ratings = [5, 4, 3, 2, 1];
  @override
  void initState() {
    screenCubit.loadInitialData(
      parameters: {
        'category_id': widget.parameters['category_id'],
        'brand_id': "",
      },
    );
    _initPagination();
    super.initState();
  }

  void _initPagination() {
    screenCubit.pagingController.addPageRequestListener((pageKey) {
      screenCubit.paginationProductByCategory(
        pageKey: pageKey,
        parameters: {
          'category_id': widget.parameters['category_id'],
          'brand_id': screenCubit.state.selectBrandId,
        },
      );
    });
  }

  //use for select from category
  void selectFilterProductByBrand(String id) {
    screenCubit.filterProductByBrand(parameters: {
      'category_id': widget.parameters['category_id'],
      'brand_id': id,
    });
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
        return BlocBuilder<ProductByCategoryCubit, ProductByCategoryState>(
          bloc: screenCubit,
          builder: (context, state) {
            final brands = state.brands ?? [];
            final priceRange = state.rangeValues;
            if (priceRange == null) {
              return SizedBox.expand();
            }
            return SingleChildScrollView(
              padding: EdgeInsets.all(appPedding.scale),
              child: Column(
                spacing: appSpace.scale,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
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
                                label: TextWidget(text: record.name),
                                selected: false,
                                selectedColor: primary,
                                onSelected: (bool value) {
                                  //TODO: check
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
                  RangeSlider(
                    inactiveColor: primary,
                    activeColor: primary,
                    values: state.rangeValues ?? RangeValues(0, 1),
                    min: AppFormat.toDouble(state.priceRangeModel?.minPrice),
                    max: AppFormat.toDouble(state.priceRangeModel?.maxPrice),
                    divisions: 5,
                    labels: RangeLabels(
                      state.priceRangeModel!.minPrice,
                      state.priceRangeModel!.maxPrice,
                    ),
                    onChanged: (RangeValues values) {
                      screenCubit.priceRangeChange(values);
                    },
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
                      //TODO: next time
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: widget.parameters['title'],
        isFilter: true,
        onTapFilter: () {
          showFilterModal();
        },
      ),
      body: BlocBuilder<ProductByCategoryCubit, ProductByCategoryState>(
        bloc: screenCubit,
        builder: (BuildContext context, ProductByCategoryState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ProductByCategoryState state) {
    final brands = state.brands ?? [];
    final double width = AppSizeConfig.screenWidth;
    double widthCard = 170.scale;
    int countRow = width ~/ widthCard;
    return CustomScrollView(
      key: Key('fetching'),
      slivers: [
        SliverFloatingHeader(
          child: _buildHorizontalList(
            items: brands,
            selectId: state.selectBrandId ?? "",
            onPressed: selectFilterProductByBrand,
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
              firstPageProgressIndicatorBuilder: (_) => Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              newPageProgressIndicatorBuilder: (_) => Center(
                child: CircularProgressIndicator.adaptive(),
              ),
              noItemsFoundIndicatorBuilder: (_) => Center(
                child: TextWidget(text: "not_found_product".tr),
              ),
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
