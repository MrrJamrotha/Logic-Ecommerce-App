import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/presentation/global/wishlist/wishlist_cubit.dart';
import 'package:foxShop/presentation/global/wishlist/wishlist_state.dart';
import 'package:foxShop/presentation/screens/auth/login/login_screen.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';

class WishlistButtonWidget extends StatelessWidget {
  const WishlistButtonWidget({
    super.key,
    required this.productId,
    this.variantId,
  });
  final String productId;
  final String? variantId;

  Future<void> _toggleWishlist(BuildContext context) async {
    try {
      bool isAuth = context.read<WishlistCubit>().state.isAuthenticated;
      if (isAuth) {
        var wishlists = context.read<WishlistCubit>().state.wishlists ?? [];
        var indexWishlist =
            wishlists.indexWhere((e) => e.productId == productId);
        if (indexWishlist != -1) {
          LoadingOverlay.show(context);
          await context.read<WishlistCubit>().toggleWishlist(parameters: {
            'id': wishlists[indexWishlist].id,
            'product_id': productId,
            'variant_id': variantId,
          });
          LoadingOverlay.hide();
        } else {
          LoadingOverlay.show(context);
          await context.read<WishlistCubit>().toggleWishlist(parameters: {
            'product_id': productId,
            'variant_id': variantId,
          });
          LoadingOverlay.hide();
        }
      } else {
        Navigator.pushNamed(context, LoginScreen.routeName).then((value) async {
          if (!context.mounted) return;
          await context.read<WishlistCubit>().getAuth();
        });
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        var records = state.wishlists ?? [];
        return IconButton(
          padding: EdgeInsets.all(5.scale),
          constraints: const BoxConstraints(),
          style: IconButton.styleFrom(
            backgroundColor: appWhite,
          ),
          onPressed: () => _toggleWishlist(context),
          icon: IconWidget(
            assetName: records.any((item) => item.productId == productId)
                ? heartSvg
                : wishlist,
            width: 18.scale,
            height: 18.scale,
          ),
        );
      },
    );
  }
}
