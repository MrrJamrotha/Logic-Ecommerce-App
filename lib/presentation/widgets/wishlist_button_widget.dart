import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/global/wishlist/wishlist_cubit.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';

class WishlistButtonWidget extends StatefulWidget {
  const WishlistButtonWidget({super.key, required this.productId});
  final String productId;
  @override
  State<WishlistButtonWidget> createState() => _WishlistButtonWidgetState();
}

class _WishlistButtonWidgetState extends State<WishlistButtonWidget> {
  Future<void> _toggleWishlist() async {
    try {
      bool isAuth = context.read<WishlistCubit>().state.isAuthenticated;
      if (isAuth) {
        
      } else {
        //TODO :LOGIN
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.all(5.scale),
      constraints: BoxConstraints(),
      // isSelected: isSelected,
      style: IconButton.styleFrom(
        backgroundColor: appWhite,
      ),
      onPressed: () => _toggleWishlist(),
      selectedIcon: IconWidget(
        assetName: heartSvg,
        width: 18.scale,
        height: 18.scale,
      ),
      icon: IconWidget(
        assetName: wishlist,
        width: 18.scale,
        height: 18.scale,
      ),
    );
  }
}
