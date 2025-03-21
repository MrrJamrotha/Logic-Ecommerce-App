import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:foxShop/core/constants/app_size_config.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/product_model.dart' show ProductModel;
import 'package:foxShop/presentation/screens/item_detail/item_detail_screen.dart';
import 'package:foxShop/presentation/screens/merchant_profile/merchant_profile_cubit.dart';
import 'package:foxShop/presentation/screens/merchant_profile/merchant_profile_state.dart';
import 'package:foxShop/presentation/widgets/product_card_widget.dart';

class TopSaleTab extends StatefulWidget {
  const TopSaleTab({super.key, required this.merchantId});
  final String merchantId;
  @override
  State<TopSaleTab> createState() => _TopSaleTabState();
}

class _TopSaleTabState extends State<TopSaleTab> {
  final screenCubit = MerchantProfileCubit();
  @override
  void initState() {
    screenCubit.pagingController.addPageRequestListener((pageKey) {
      screenCubit.paginationProduct(pageKey: pageKey, parameters: {
        'merchant_id': widget.merchantId,
        'status': 'top-sale',
      });
    });

    screenCubit.getProductByMerchant(parameters: {
      'merchant_id': widget.merchantId,
      'status': 'top-sale',
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
            noItemsFoundIndicatorBuilder: (_) => centerText(),
          ),
        );
      },
    );
  }
}
