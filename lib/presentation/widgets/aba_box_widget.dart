import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class AbaBoxWidget<T> extends StatelessWidget {
  const AbaBoxWidget({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    required this.imgUrl,
    required this.blurHash,
    required this.title,
    required this.subTitle,
    this.onTap,
  });
  final T value;
  final T groupValue;
  final Function(T?)? onChanged;
  final String imgUrl;
  final String blurHash;
  final String title;
  final String subTitle;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(10.scale),
        decoration: BoxDecoration(
          color: appWhite,
          boxShadow: [
            BoxShadow(
              color: abaShadowColor.withOpacity(0.36),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(appSpace.scale),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 10.scale,
          children: [
            CatchImageNetworkWidget(
              width: 46.scale,
              height: 40.scale,
              boxFit: BoxFit.cover,
              borderRadius: BorderRadius.circular(6.scale),
              imageUrl: imgUrl,
              blurHash: blurHash,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextWidget(
                  text: title,
                  fontSize: 18.scale,
                  fontWeight: FontWeight.w700,
                ),
                if (subTitle.isNotEmpty)
                  TextWidget(
                    text: subTitle,
                    color: abaTextColor,
                  ),
              ],
            ),
            Spacer(),
            Radio.adaptive(
              activeColor: primary,
              value: value,
              groupValue: groupValue,
              onChanged: onChanged,
            )
          ],
        ),
      ),
    );
  }
}
