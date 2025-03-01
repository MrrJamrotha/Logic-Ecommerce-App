import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/product_cart_model.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({
    super.key,
    required this.record,
    required this.removeFromCart,
    required this.incrementCart,
    required this.decrementCart,
  });
  final ProductCartModel record;
  final Function(String) removeFromCart;
  final Function(String, String, String) incrementCart;
  final Function(String, String) decrementCart;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BoxWidget(
          color: appWhite,
          padding: EdgeInsets.all(appSpace.scale),
          borderRadius: BorderRadius.circular(appRadius.scale),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            spacing: appSpace.scale,
            children: [
              CatchImageNetworkWidget(
                boxFit: BoxFit.cover,
                borderRadius: BorderRadius.circular(appRadius.scale),
                width: 100.scale,
                height: 100.scale,
                imageUrl: record.picture,
                blurHash: record.pictureHash,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextWidget(
                      text: record.name,
                      fontSize: 14.scale,
                    ),
                    if (!record.isPromotion)
                      TextWidget(
                        text: record.totalAmount,
                        fontSize: 12.scale,
                        color: primary,
                      ),
                    if (record.isPromotion)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${record.totalAmount} ',
                              style: TextStyle(
                                fontSize: 12.scale,
                                color: primary,
                              ),
                            ),
                            TextSpan(
                              text: record.totalDiscount,
                              style: TextStyle(
                                fontSize: 12.scale,
                                color: textColor,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    if (record.colorId.isNotEmpty)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${'color'.tr} : ',
                              style: TextStyle(
                                fontSize: 12.scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(text: record.colorName),
                          ],
                        ),
                      ),
                    if (record.sizeId.isNotEmpty)
                      Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: '${'size'.tr} : ',
                              style: TextStyle(
                                fontSize: 12.scale,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: record.sizeName,
                              style: TextStyle(
                                fontSize: 12.scale,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (record.isPromotion)
          Positioned(
            top: 8.scale,
            left: 8.scale,
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: appSpace.scale.scale,
                vertical: 3.scale,
              ),
              decoration: BoxDecoration(
                color: primary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(appRadius.scale),
                  bottomRight: Radius.circular(appRadius.scale),
                ),
              ),
              child: TextWidget(
                text: record.discountValue,
                fontSize: 12.scale,
                color: appWhite,
              ),
            ),
          ),
        Positioned(
          right: -5.scale,
          top: -5.scale,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () => removeFromCart(record.id),
            icon: IconWidget(
              assetName: deleteSvg,
              width: 24.scale,
              height: 24.scale,
            ),
          ),
        ),
        Positioned(
          bottom: -3.scale,
          right: -3.scale,
          child: Row(
            spacing: 5.scale,
            children: [
              IconButton.outlined(
                style: IconButton.styleFrom(
                  side: BorderSide(width: 0.1, color: textColor),
                ),
                padding: EdgeInsets.all(3.scale),
                constraints: BoxConstraints(),
                onPressed: () => decrementCart(record.id, record.quantity),
                icon: IconWidget(
                  assetName: removeSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
              ),
              TextWidget(text: record.quantity),
              IconButton.outlined(
                style: IconButton.styleFrom(
                    side: BorderSide(width: 0.1, color: textColor)),
                padding: EdgeInsets.all(3.scale),
                constraints: BoxConstraints(),
                onPressed: () => incrementCart(
                  record.id,
                  record.productId,
                  record.quantity,
                ),
                icon: IconWidget(
                  assetName: addSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
