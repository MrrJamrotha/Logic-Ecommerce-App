import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class RowViewMoreWidget extends StatelessWidget {
  const RowViewMoreWidget({
    super.key,
    required this.title,
    required this.child,
    this.onTap,
  });
  final String title;
  final Widget child;
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextWidget(text: title),
            TextButton(
              onPressed: onTap,
              child: TextWidget(
                text: 'view_more'.tr,
                color: primary,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        child
      ],
    );
  }
}
