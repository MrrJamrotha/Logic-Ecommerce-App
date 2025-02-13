import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/presentation/widgets/add_to_cart_button_widget.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';
import 'package:logic_app/presentation/widgets/wishlist_button_widget.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
    required this.record,
    required this.isLoading,
  });
  final ProductModel record;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return SizedBox.shrink();
    }
    return BoxWidget(
      width: 170.scale,
      borderRadius: BorderRadius.circular(appRadius.scale),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CatchImageNetworkWidget(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(appRadius.scale),
                  topLeft: Radius.circular(appRadius.scale),
                ),
                height: 126.scale,
                width: double.infinity,
                imageUrl: record.picture,
                blurHash: record.pictureHash,
                boxFit: BoxFit.cover,
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 10.scale,
                  vertical: 5.scale,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextWidget(text: record.name, fontSize: 10.scale),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '${record.price} ',
                            style: TextStyle(
                              color: primary,
                              fontSize: 12.scale,
                            ),
                          ),
                          TextSpan(
                            text: record.price,
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              color: textColor,
                              decorationColor: textColor,
                              fontSize: 10.scale,
                            ),
                          )
                        ],
                      ),
                    ),
                    RatingBar.builder(
                      //TODO : with data
                      ignoreGestures: true,
                      initialRating: 3,
                      tapOnlyMode: true,
                      updateOnDrag: true,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemSize: 10.scale,
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: appYellow,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                    TextWidget(
                      text: '120 Reviews', //TODO: with data
                      fontSize: 10.scale,
                      color: textColor,
                    )
                  ],
                ),
              )
              // TextWidget(text: 'text'),
            ],
          ),
          Positioned(
            top: -5.scale,
            right: -5.scale,
            child: WishlistButtonWidget(),
          ),
          Positioned(
            right: -5.scale,
            bottom: -5.scale,
            child: AddToCartButtonWidget(),
          ),
        ],
      ),
    );
  }
}
