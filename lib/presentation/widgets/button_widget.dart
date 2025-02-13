import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({
    super.key,
    required this.title,
    required this.onPressed,
    this.color = primary,
    this.width,
  });
  final String title;
  final VoidCallback onPressed;
  final Color? color;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.all(10.scale),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(appRadius.scale)
        )
      ),
      child: SizedBox(
        width: width,
        child: TextWidget(
          text: title,
          fontSize: 16.scale,
          color: appWhite,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
