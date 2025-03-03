import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/common/product_search_response.dart';
import 'package:foxShop/core/constants/app_size_config.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/product_model.dart';
import 'package:foxShop/presentation/screens/item_detail/item_detail_screen.dart';
import 'package:foxShop/presentation/screens/typesense_search_delegate/search_cubit.dart';
import 'package:foxShop/presentation/screens/typesense_search_delegate/search_state.dart';
import 'package:foxShop/presentation/widgets/product_card_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class TypesenseSearchDelegate extends SearchDelegate {
  final screenCubit = SearchCubit();

  @override
  void dispose() {
    screenCubit.close();
    super.dispose();
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear search query
          showSuggestions(context); // Refresh suggestions
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final double width = AppSizeConfig.screenWidth;
    double widthCard = 170.scale;
    int countRow = width ~/ widthCard;

    // Check if the query is empty
    if (query.isEmpty) {
      return centerText(message: 'Please enter a search query.');
    }
    screenCubit.searchProducts(parameters: {'query': query});
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: screenCubit,
      builder: (context, state) {
        if (state.isLoading) {
          return centerLoading();
        }
        return PagedMasonryGridView.count(
          padding: EdgeInsets.all(appPedding.scale),
          pagingController: screenCubit.pagingProductController,
          crossAxisSpacing: appSpace.scale,
          mainAxisSpacing: appSpace.scale,
          builderDelegate: PagedChildBuilderDelegate<ProductModel>(
            itemBuilder: (context, record, index) {
              return ProductCardWidget(
                onTap: () {
                  Navigator.pushNamed(context, ItemDetailScreen.routeName,
                      arguments: {
                        'product_id': record.id,
                        'category_id': record.categoryId,
                        'brand_id': record.brandId,
                      });
                },
                record: record,
                isLoading: false,
              );
            },
            firstPageProgressIndicatorBuilder: (_) => centerLoading(),
            newPageProgressIndicatorBuilder: (_) => centerLoading(),
            noItemsFoundIndicatorBuilder: (_) => centerText(),
          ),
          crossAxisCount: countRow,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    screenCubit.typesenceProduct(query: query, pageKey: 1);
    return BlocBuilder<SearchCubit, SearchState>(
      bloc: screenCubit,
      builder: (context, state) {
        if (state.isLoading) {
          return centerLoading();
        }
        return PagedListView(
          pagingController: screenCubit.pagingSuggesstionController,
          builderDelegate: PagedChildBuilderDelegate<Hit>(
            itemBuilder: (context, item, index) {
              return ListTile(
                title: TextWidget(text: item.document.name),
                onTap: () {
                  query = item.document.name;
                  showResults(context);
                },
                trailing: Icon(Icons.arrow_outward_rounded),
              );
            },
          ),
        );
      },
    );
  }
}
