import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({
    super.key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textAlign,
    this.height,
    this.maxLines,
    this.overflow = TextOverflow.fade,
    this.decoration,
  });
  final String text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final double? height;
  final int? maxLines;
  final TextOverflow? overflow;
  final TextDecoration? decoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      key: super.key,
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
        overflow: overflow,
        decoration: decoration,
        decorationColor: color,
      ),
    );
  }
}
