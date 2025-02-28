import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = primary,
    this.width,
    this.assetName,
    this.isIcon = false,
  });
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final double? width;
  final String? assetName;
  final bool isIcon;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.all(10.scale),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(appRadius.scale))),
      child: SizedBox(
        width: width,
        child: Row(
          spacing: appSpace.scale,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isIcon)
              IconWidget(
                assetName: assetName ?? "",
                width: 24.scale,
                height: 24.scale,
                colorFilter: ColorFilter.mode(appWhite, BlendMode.srcIn),
              ),
            TextWidget(
              text: title,
              fontSize: 16.scale,
              color: appWhite,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
