import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';

class AddToCartButtonWidget extends StatelessWidget {
  const AddToCartButtonWidget({super.key});
  final bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return IconButton.outlined(
      padding: EdgeInsets.all(5.scale),
      constraints: BoxConstraints(),
      isSelected: isSelected,
      style: IconButton.styleFrom(
          side: BorderSide(
        width: 0.1,
        color: textColor,
      )),
      onPressed: () {
        //TODO: this
      },
      selectedIcon: IconWidget(
        assetName: addSvg,
        width: 20.scale,
        height: 20.scale,
      ),
      icon: IconWidget(
        assetName: removeSvg,
        width: 18.scale,
        height: 18.scale,
      ),
    );
  }
}
