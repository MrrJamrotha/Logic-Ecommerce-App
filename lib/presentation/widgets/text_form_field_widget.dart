import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.controller,
    this.labelText,
    this.labelStyle,
    this.hintStyle,
    this.hintText,
    this.readOnly = false,
    this.validator,
  });
  final TextEditingController? controller;
  final String? labelText;
  final TextStyle? labelStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final bool readOnly;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      cursorColor: primary,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appRadius.scale),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(appRadius.scale),
          borderSide: BorderSide(color: primary),
        ),
        focusColor: primary,
        labelText: labelText,
        labelStyle: labelStyle,
        hintText: hintText,
        hintStyle: hintStyle,
      ),
    );
  }
}
