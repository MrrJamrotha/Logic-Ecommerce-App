import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class IconWidget extends StatelessWidget {
  const IconWidget({
    super.key,
    required this.assetName,
    this.width,
    this.height,
    this.colorFilter,
    this.fit = BoxFit.contain,
  });
  final String assetName;
  final double? width;
  final double? height;
  final BoxFit fit;
  final ColorFilter? colorFilter;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      key: super.key,
      assetName,
      width: width,
      height: height,
      colorFilter: colorFilter,
      fit: fit,
    );
  }
}
