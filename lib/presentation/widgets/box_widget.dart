import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/helper/helper.dart';

class BoxWidget extends StatelessWidget {
  const BoxWidget({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
  });
  final Widget child;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Material(
        shape: RoundedRectangleBorder(),
        child: InkWell(
          onTap: onTap,
          child: Container(
            width: width,
            height: height,
            margin: margin,
            padding: padding,
            decoration: BoxDecoration(
              color: appWhite,
              borderRadius: borderRadius,
              border: Border.all(color: textColor, width: 0.1.scale),
              boxShadow: [
                BoxShadow(
                  color: boxShadowColor,
                  offset: Offset(0, 12.scale),
                  blurRadius: 48.scale,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
