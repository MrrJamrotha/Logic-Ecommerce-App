import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_cubit.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/header_delegate_widget.dart';
import 'package:logic_app/presentation/widgets/product_card_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class FetchingItemsScreen extends StatefulWidget {
  const FetchingItemsScreen({
    super.key,
    required this.title,
    required this.type,
  });
  final String title;
  final FetchingType type;
  @override
  FetchingItemsScreenState createState() => FetchingItemsScreenState();
}

class FetchingItemsScreenState extends State<FetchingItemsScreen> {
  final screenCubit = FetchingItemsCubit();
  List<int> ratings = [5, 4, 3, 2, 1];
  @override
  void initState() {
    screenCubit.loadInitialData(type: widget.type);
    super.initState();
  }

  void selectFilterProductByCategory(String id) {
    screenCubit.filterByCategory(id.isEmpty ? "" : id);
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
        return BlocBuilder<FetchingItemsCubit, FetchingItemsState>(
          bloc: screenCubit,
          builder: (context, state) {
            final categories = state.categories ?? [];
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
                  TextWidget(
                    text: 'categpries'.tr,
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
                          label: TextWidget(text: record.name),
                          selected: false,
                          selectedColor: primary,
                          onSelected: (bool value) {
                            //TODO:
                          },
                        );
                      }).toList()),
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
                        title: RatingBarIndicator(
                          itemSize: 20.scale,
                          rating: rating.toDouble(),
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: appYellow,
                          ),
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
        title: widget.title,
        isFilter: true,
        onTapFilter: () {
          showFilterModal();
        },
      ),
      body: BlocBuilder<FetchingItemsCubit, FetchingItemsState>(
        bloc: screenCubit,
        builder: (BuildContext context, FetchingItemsState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(FetchingItemsState state) {
    final categories = state.categories ?? [];
    final double width = AppSizeConfig.screenWidth;
    double widthCard = 170.scale;
    int countRow = width ~/ widthCard;
    return CustomScrollView(
      key: Key('fetching'),
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HeaderDelegateWidget(
            maxHeight: 75,
            minHeight: 75,
            child: Container(
              color: appWhite,
              child: ListView.builder(
                padding: EdgeInsets.all(appPedding.scale),
                itemCount: categories.length + 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  if (index == 0) {
                    return _buildTextButton(
                      id: "",
                      title: 'all'.tr,
                      selectCategoryId: state.selectCategoryId ?? "",
                      onPressed: () {
                        selectFilterProductByCategory("");
                      },
                    );
                  }
                  final record = categories[index - 1];
                  return _buildTextButton(
                    id: record.id,
                    title: record.name,
                    selectCategoryId: state.selectCategoryId ?? "",
                    onPressed: () {
                      selectFilterProductByCategory(record.id);
                    },
                  );
                },
              ),
            ),
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

  _buildTextButton({
    required id,
    required String title,
    Function()? onPressed,
    required String selectCategoryId,
  }) {
    return Padding(
      padding: EdgeInsets.only(right: appSpace.scale),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side: BorderSide(
            color:
                selectCategoryId == id ? primary : textColor.withOpacity(0.5),
          ),
          backgroundColor: selectCategoryId == id ? primary : appWhite,
          padding: EdgeInsets.all(appSpace.scale),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(appRadius.scale),
          ),
        ),
        child: TextWidget(
          text: title,
          color: selectCategoryId == id ? appWhite : appBlack,
          fontSize: 14.scale,
        ),
      ),
    );
  }
}
