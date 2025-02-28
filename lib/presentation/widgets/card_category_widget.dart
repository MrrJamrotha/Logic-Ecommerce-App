import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CardCategoryWidget extends StatelessWidget {
  const CardCategoryWidget({
    super.key,
    required this.picture,
    required this.pictureHash,
    required this.title,
    this.boxFit = BoxFit.cover,
    this.onTap,
  });
  final String picture;
  final String pictureHash;
  final String title;
  final BoxFit? boxFit;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      width: 130.scale,
      borderRadius: BorderRadius.circular(appRadius.scale),
      onTap: onTap,
      child: Column(
        spacing: 5.scale,
        children: [
          CatchImageNetworkWidget(
            boxFit: boxFit,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(appRadius.scale),
              topRight: Radius.circular(appRadius.scale),
            ),
            height: 71.scale,
            width: double.infinity,
            imageUrl: picture,
            blurHash: pictureHash,
          ),
          TextWidget(
            text: title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox.shrink(),
        ],
      ),
    );
  }
}
