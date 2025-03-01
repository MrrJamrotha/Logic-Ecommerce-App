import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/presentation/screens/cart/cart_cubit.dart';
import 'package:foxShop/presentation/screens/cart/cart_state.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';

class AddToCartButtonWidget extends StatelessWidget {
  const AddToCartButtonWidget({
    super.key,
    required this.productId,
    this.variantId,
  });
  final String productId;
  final String? variantId;

  Future<void> _toggleCart(BuildContext context) async {
    try {
      var productCarts = context.read<CartCubit>().state.productCarts ?? [];
      var indexCart = productCarts.indexWhere((e) => e.productId == productId);
      if (indexCart != -1) {
        LoadingOverlay.show(context);
        await context.read<CartCubit>().toggleCart(parameters: {
          'id': productCarts[indexCart].id,
        });
        LoadingOverlay.hide();
      } else {
        LoadingOverlay.show(context);
        await context.read<CartCubit>().toggleCart(parameters: {
          'product_id': productId,
          'variant_id': variantId,
          'quantity': 1,
        });
        LoadingOverlay.hide();
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        var records = state.productCarts ?? [];
        return IconButton.outlined(
          padding: EdgeInsets.all(5.scale),
          constraints: BoxConstraints(),
          isSelected: records.any((item) => item.productId == productId),
          style: IconButton.styleFrom(
              side: BorderSide(
                width: 0.1,
                color: textColor,
              ),
              backgroundColor:
                  records.any((item) => item.productId == productId)
                      ? primary
                      : appWhite),
          onPressed: () => _toggleCart(context),
          selectedIcon: IconWidget(
            assetName: addSvg,
            width: 20.scale,
            height: 20.scale,
            colorFilter: ColorFilter.mode(
              appWhite,
              BlendMode.srcIn,
            ),
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
