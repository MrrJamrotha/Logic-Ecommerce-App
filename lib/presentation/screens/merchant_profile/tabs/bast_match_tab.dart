import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/product_model.dart' show ProductModel;
import 'package:logic_app/presentation/screens/item_detail/item_detail_screen.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_cubit.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_state.dart';
import 'package:logic_app/presentation/widgets/product_card_widget.dart';

class BastMatchTab extends StatefulWidget {
  const BastMatchTab({super.key, required this.merchantId});
  final String merchantId;
  @override
  State<BastMatchTab> createState() => _BastMatchTabState();
}

class _BastMatchTabState extends State<BastMatchTab> {
  final screenCubit = MerchantProfileCubit();
  @override
  void initState() {
    screenCubit.pagingController.addPageRequestListener((pageKey) {
      screenCubit.paginationProduct(pageKey: pageKey, parameters: {
        'merchant_id': widget.merchantId,
        'status': 'best-match',
      });
    });

    screenCubit.getProductByMerchant(parameters: {
      'merchant_id': widget.merchantId,
      'status': 'best-match',
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double width = AppSizeConfig.screenWidth;
    double widthCard = 170.scale;
    int countRow = width ~/ widthCard;
    return BlocBuilder<MerchantProfileCubit, MerchantProfileState>(
      bloc: screenCubit,
      builder: (context, state) {
        if (state.isLoadingProduct) {
          return centerLoading();
        }
        return PagedMasonryGridView.count(
          padding: EdgeInsets.all(appPedding.scale),
          crossAxisCount: countRow,
          pagingController: screenCubit.pagingController,
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
                isLoading: state.isLoadingProduct,
              );
            },
            firstPageProgressIndicatorBuilder: (_) => centerLoading(),
            newPageProgressIndicatorBuilder: (_) => centerLoading(),
            noItemsFoundIndicatorBuilder: (_) => centerNotFoundProduct(),
          ),
        );
      },
    );
  }
}
