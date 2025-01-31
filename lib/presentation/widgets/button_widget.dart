import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key, required this.title, required this.onPressed});
  final String title;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        padding: EdgeInsets.all(10.scale),
      ),
      child: SizedBox(
        width: double.infinity,
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
