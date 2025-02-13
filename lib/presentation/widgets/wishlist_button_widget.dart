import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({super.key});
  final bool isSelected = true;
  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(5.scale),
      constraints: BoxConstraints(),
      isSelected: isSelected,
      style: IconButton.styleFrom(
        backgroundColor: appWhite,
      ),
      onPressed: () {
        //TODO: this
      },
      selectedIcon: IconWidget(
        assetName: heartSvg,
        width: 18.scale,
        height: 18.scale,
      ),
      icon: IconWidget(
        assetName: wishlist,
        width: 18.scale,
        height: 18.scale,
      ),
    );
  }
}
