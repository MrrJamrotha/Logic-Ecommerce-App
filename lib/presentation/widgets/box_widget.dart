import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';

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
    this.color = appWhite,
  });
  final Widget child;
  final Function()? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;

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
              color: color,
              borderRadius: borderRadius,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08), // rgba(0, 0, 0, 0.08)
                  offset: Offset(0, 4), // 0px 4px
                  blurRadius: 12, // 12px
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
