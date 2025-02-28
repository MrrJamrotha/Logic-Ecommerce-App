import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CardBrandWidget extends StatelessWidget {
  const CardBrandWidget({
    super.key,
    required this.picture,
    required this.pictureHash,
    required this.title,
    this.onTap,
  });
  final String picture;
  final String pictureHash;
  final String title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      width: 130.scale,
      onTap: onTap,
      padding: EdgeInsets.all(5.scale),
      borderRadius: BorderRadius.circular(appRadius.scale),
      // height: 95,
      child: Column(
        spacing: 5.scale,
        children: [
          CatchImageNetworkWidget(
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
        ],
      ),
    );
  }
}
