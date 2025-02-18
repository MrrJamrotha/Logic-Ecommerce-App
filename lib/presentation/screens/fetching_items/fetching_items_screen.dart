import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_cubit.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
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

  @override
  void initState() {
    screenCubit.loadInitialData(type: widget.type);
    super.initState();
  }

  void selectFilterProductByCategory(String id) {
    if (id.isEmpty) {
      screenCubit.loadInitialData(type: widget.type);
    } else {
      screenCubit.filterByCategory(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.title),
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
