import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/presentation/screens/cart/cart_cubit.dart';
import 'package:foxShop/presentation/screens/fetching_items/fetching_items_screen.dart';
import 'package:foxShop/presentation/screens/item_detail/item_detail_cubit.dart';
import 'package:foxShop/presentation/screens/item_detail/item_detail_state.dart';
import 'package:foxShop/presentation/screens/merchant_profile/merchant_profile_screen.dart';
import 'package:foxShop/presentation/screens/review_product/review_product_screen.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/card_user_review.dart';
import 'package:foxShop/presentation/widgets/carousel_slider_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/error_type_widget.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/list_product_horizontal_widget.dart';
import 'package:foxShop/presentation/widgets/rating_bar_widget.dart';
import 'package:foxShop/presentation/widgets/row_view_more_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';
import 'package:foxShop/presentation/widgets/wishlist_button_widget.dart';

class ItemDetailScreen extends StatefulWidget {
  static const routeName = 'item_detail';
  const ItemDetailScreen({super.key, required this.parameters});
  final Map<String, dynamic> parameters;
  @override
  ItemDetailScreenState createState() => ItemDetailScreenState();
}

class ItemDetailScreenState extends State<ItemDetailScreen> {
  final screenCubit = ItemDetailCubit();
  final _quantity = ValueNotifier(1);
  @override
  void initState() {
    screenCubit.loadInitialData(parameters: {
      'product_id': widget.parameters['product_id'],
    });
    screenCubit.getRelatedProduct(parameters: {
      'merchant_id': widget.parameters['merchant_id'],
      'category_id': widget.parameters['category_id'],
      'brand_id': widget.parameters['brand_id'],
    });

    var products = context.read<CartCubit>().state.productCarts ?? [];
    var index = products
        .indexWhere((e) => e.productId == widget.parameters['product_id']);
    if (index != -1) {
      _quantity.value = AppFormat.toInt(products[index].quantity);
    }

    super.initState();
  }

  void _handleQuantityChange() async {
    try {
      LoadingOverlay.show(context);
      var products = context.read<CartCubit>().state.productCarts ?? [];
      var index = products
          .indexWhere((e) => e.productId == widget.parameters['product_id']);
      if (index != -1) {
        await context.read<CartCubit>().updateCart(parameters: {
          'id': products[index].id,
          'quantity': _quantity.value.toString(),
          'product_id': widget.parameters['product_id'],
        });
        showMessage(message: 'update_cart_success'.tr);
      } else {
        await context.read<CartCubit>().toggleCart(parameters: {
          'quantity': _quantity.value.toString(),
          'product_id': widget.parameters['product_id'],
        });
        showMessage(message: 'add_to_cart_success'.tr);
      }

      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'item_details'.tr,
      ),
      body: BlocConsumer<ItemDetailCubit, ItemDetailState>(
        bloc: screenCubit,
        listener: (BuildContext context, ItemDetailState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ItemDetailState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ItemDetailState state) {
    final relatedProducts = state.relatedProducts ?? [];
    final itemDetail = state.itemDetailModel;
    if (itemDetail == null) {
      return ErrorTypeWidget(type: ErrorType.notFound);
    }
    List<dynamic> pictures = itemDetail.pictures
        .map((e) => {
              'picture': e.picture,
              'pictureHash': e.pictureHash,
            })
        .toList();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              CarouselSliderWidget(
                height: 400,
                records: pictures,
                isLoading: false,
              ),
              Positioned(
                right: 5.scale,
                top: 5.scale,
                child: WishlistButtonWidget(productId: itemDetail.id),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(appPedding.scale),
            child: Column(
              spacing: appSpace.scale,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextWidget(
                      text: itemDetail.name,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: itemDetail.price,
                            style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 20.scale,
                              color: primary,
                            ),
                          ),
                          //TODO:
                          // TextSpan(
                          //   text: '20.00\$',
                          //   style: TextStyle(
                          //     fontWeight: FontWeight.w400,
                          //     fontSize: 20.scale,
                          //     color: textColor,
                          //     decoration: TextDecoration.lineThrough,
                          //   ),
                          // )
                        ],
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    if (AppFormat.toDouble(itemDetail.totalReview) > 0)
                      RatingBarWidget(
                        itemSize: 20.scale,
                        rating: AppFormat.toDouble(itemDetail.averageStar),
                      ),
                    if (AppFormat.toDouble(itemDetail.totalReview) > 0)
                      TextWidget(
                        text: '(${itemDetail.totalReview} ${'reviews'.tr})',
                        fontSize: 12.scale,
                        color: textColor,
                      ),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: appSpace.scale,
                        vertical: 5.scale,
                      ),
                      decoration: BoxDecoration(
                        // ignore: deprecated_member_use
                        color: primary.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(appRadius.scale),
                      ),
                      child: TextWidget(
                        text: '-20%', //TODO:
                        color: primary,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (_quantity.value > 1) {
                          _quantity.value--;
                        }
                      },
                      icon: IconWidget(
                        assetName: removeSvg,
                        width: 24.scale,
                        height: 24.scale,
                      ),
                    ),
                    ValueListenableBuilder(
                      valueListenable: _quantity,
                      builder: (context, value, child) {
                        return TextWidget(
                          text: value.toString(),
                          fontSize: 18.scale,
                          fontWeight: FontWeight.w700,
                        );
                      },
                    ),
                    IconButton(
                      onPressed: () {
                        _quantity.value++;
                      },
                      icon: IconWidget(
                        assetName: addSvg,
                        width: 24.scale,
                        height: 24.scale,
                      ),
                    ),
                  ],
                ),
                ButtonWidget(
                  title: 'add_to_cart'.tr,
                  onPressed: () => _handleQuantityChange(),
                ),
                ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  backgroundColor: appWhite,
                  title: TextWidget(
                    text: 'description'.tr,
                    fontSize: 18.scale,
                    fontWeight: FontWeight.w700,
                  ),
                  initiallyExpanded: true,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  iconColor: primary,
                  children: [
                    TextWidget(text: itemDetail.description),
                    SizedBox(height: appSpace.scale),
                    TextWidget(text: itemDetail.description2)
                  ],
                ),
                TextWidget(
                  text: 'merchant_informaiton'.tr,
                  fontSize: 18.scale,
                  fontWeight: FontWeight.w700,
                ),
                SizedBox(
                  height: 170.scale,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, MerchantProfileScreen.routeName,
                          arguments: {
                            'merchant_id': itemDetail.merchantId,
                          });
                    },
                    child: Stack(
                      children: [
                        CatchImageNetworkWidget(
                          height: 120.scale,
                          width: double.infinity,
                          blurHash: itemDetail.merchant.coverHash,
                          borderRadius: BorderRadius.circular(appRadius.scale),
                          boxFit: BoxFit.cover,
                          imageUrl: itemDetail.merchant.cover,
                        ),
                        Positioned(
                          left: appPedding.scale,
                          bottom: 0,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5.scale,
                            children: [
                              CatchImageNetworkWidget(
                                width: 80.scale,
                                height: 80.scale,
                                blurHash: itemDetail.merchant.avatarHash,
                                borderRadius: BorderRadius.circular(100.scale),
                                boxFit: BoxFit.cover,
                                imageUrl: itemDetail.merchant.avatar,
                              ),
                              TextWidget(
                                text: itemDetail.merchant.storeName,
                                fontWeight: FontWeight.w600,
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                if (itemDetail.reviews.isNotEmpty)
                  RowViewMoreWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, ReviewProductScreen.routeName,
                          arguments: {
                            'product_id': itemDetail.id,
                          });
                    },
                    title: 'product_reviews'.tr,
                    child: Column(
                      children: List.generate(
                        itemDetail.reviews.length,
                        (index) =>
                            CardUserReview(record: itemDetail.reviews[index]),
                      ),
                    ),
                  ),
                if (itemDetail.itemDetailPictures.isNotEmpty)
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    backgroundColor: appWhite,
                    title: TextWidget(
                      text: 'product_details'.tr,
                      fontSize: 18.scale,
                      fontWeight: FontWeight.w700,
                    ),
                    initiallyExpanded: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    iconColor: primary,
                    children: itemDetail.itemDetailPictures.map((e) {
                      return CatchImageNetworkWidget(
                        width: double.infinity,
                        height: 400.scale,
                        boxFit: BoxFit.cover,
                        imageUrl: e.picture,
                        blurHash: e.pictureHash,
                      );
                    }).toList(),
                  ),
                if (itemDetail.itemDetailPrice.isNotEmpty)
                  ExpansionTile(
                    tilePadding: EdgeInsets.zero,
                    backgroundColor: appWhite,
                    title: TextWidget(
                      text: 'price_details'.tr,
                      fontSize: 18.scale,
                      fontWeight: FontWeight.w700,
                    ),
                    initiallyExpanded: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    iconColor: primary,
                    children: itemDetail.itemDetailPrice.map((e) {
                      return Padding(
                        padding: EdgeInsets.only(bottom: appSpace.scale),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              spacing: appSpace.scale,
                              children: [
                                Icon(Icons.circle, size: 12.scale),
                                TextWidget(
                                  text: e.name,
                                  fontSize: 14.scale,
                                  fontWeight: FontWeight.w500,
                                ),
                              ],
                            ),
                            SizedBox(height: 5.scale),
                            TextWidget(
                              text: e.description,
                              fontSize: 12.scale,
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                if (relatedProducts.isNotEmpty)
                  RowViewMoreWidget(
                    onTap: () {
                      Navigator.pushNamed(
                          context, FetchingItemsScreen.routeName,
                          arguments: {
                            'title': 'related_products'.tr,
                            'type': FetchingType.relatedProducts,
                            'merchant_id': itemDetail.merchantId,
                            'category_id': itemDetail.categoryId,
                            'brand_id': itemDetail.brandId,
                          });
                    },
                    title: 'related_products'.tr,
                    child: ListProductHorizontalWidget(
                      records: relatedProducts,
                      isLoading: state.isLoadingRelatedProduct,
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
