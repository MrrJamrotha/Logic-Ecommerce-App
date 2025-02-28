import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BoxWidget(
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
                imageUrl:
                    'https://www.zdnet.com/a/img/resize/83649d8b18524ecf15b0c9883d7adda112d3bcef/2024/09/10/64beb224-1888-4d53-bf71-78b696bcda36/blue-iphone-16-steve-jobs-theater.jpg?auto=webp&fit=crop&height=900&width=1200',
                blurHash: 'EHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    TextWidget(
                      text: 'IPhone 16 pro max',
                      fontSize: 14.scale,
                    ),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '1499.99\$ ',
                            style: TextStyle(
                              fontSize: 12.scale,
                              color: primary,
                            ),
                          ),
                          TextSpan(
                            text: '1699.99\$',
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
                          TextSpan(text: 'Gray'),
                        ],
                      ),
                    ),
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
                            text: 'Gray',
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
        Positioned(
          right: -5
            ..scale,
          top: -5.scale,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              //TODO:
            },
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
                onPressed: () {
                  //TODO:
                },
                icon: IconWidget(
                  assetName: removeSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
              ),
              TextWidget(text: '1'),
              IconButton.outlined(
                style: IconButton.styleFrom(
                    side: BorderSide(width: 0.1, color: textColor)),
                padding: EdgeInsets.all(3.scale),
                constraints: BoxConstraints(),
                onPressed: () {
                  //TODO:
                },
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
