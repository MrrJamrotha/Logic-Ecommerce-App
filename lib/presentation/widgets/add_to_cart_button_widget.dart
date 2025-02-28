import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/cart/cart_cubit.dart';
import 'package:foxShop/presentation/screens/cart/cart_state.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';

class AddToCartButtonWidget extends StatelessWidget {
  const AddToCartButtonWidget({super.key, required this.productId});
  final String productId;

  final bool isSelected = false;

  Future<void> _toggleCart(BuildContext context) async {
    try {} catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return IconButton.outlined(
          padding: EdgeInsets.all(5.scale),
          constraints: BoxConstraints(),
          isSelected: isSelected,
          style: IconButton.styleFrom(
              side: BorderSide(
            width: 0.1,
            color: textColor,
          )),
          onPressed: () => _toggleCart(context),
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
      },
    );
  }
}
