import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/user_model.dart';
import 'package:foxShop/presentation/screens/auth/login/login_screen.dart';
import 'package:foxShop/presentation/screens/cart/cart_cubit.dart';
import 'package:foxShop/presentation/screens/cart/cart_state.dart';
import 'package:foxShop/presentation/screens/check_out/check_out_screen.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/cart_widget.dart';
import 'package:foxShop/presentation/widgets/error_type_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = 'cart_screen';
  static const routePath = '/cart_screen';

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  // final screenCubit = CartCubit();
  UserModel? auth;
  @override
  void initState() {
    _initDatas();
    super.initState();
  }

  _initDatas() async {
    Future.wait([
      context.read<CartCubit>().loadInitialData(),
      context.read<CartCubit>().getProductCarts(),
    ]);
  }

  showLogin() {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      context: context,
      builder: (context) {
        return Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhite,
      appBar: AppbarWidget(title: 'carts'.tr),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state.error != null) {
            showMessage(
              message: state.error ?? "",
              status: MessageStatus.error,
            );
          }
        },
        // bloc: screenCubit,
        builder: (BuildContext context, CartState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar: BlocBuilder<CartCubit, CartState>(
        // bloc: screenCubit,
        buildWhen: (previous, current) =>
            previous.productCarts != current.productCarts,
        builder: (context, state) {
          return _buildBottomNavigationBar(state, context);
        },
      ),
    );
  }

  _buildBottomNavigationBar(CartState state, BuildContext context) {
    var records = state.productCarts ?? [];

    if (records.isEmpty) {
      return SizedBox.shrink();
    }
    return Padding(
      padding: EdgeInsets.all(appPedding.scale),
      child: BoxWidget(
        color: appWhite,
        padding: EdgeInsets.all(appSpace.scale),
        borderRadius: BorderRadius.circular(appRadius.scale),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: appSpace.scale,
          children: [
            _buildRow(
              leftText: 'total_items'.tr,
              rightText: state.totalCart ?? "0",
            ),
            _buildRow(
              leftText: 'subtotal'.tr,
              rightText: state.subTotal ?? "0",
            ),
            _buildRow(
              leftText: 'total_commission'.tr,
              rightText: state.totalCommission ?? "0",
            ),
            _buildRow(
              leftText: 'total_discount'.tr,
              rightText: "-${state.totalDiscount}",
              rightColor: appRedAccent,
            ),
            _buildRow(
              leftText: 'total_amount'.tr,
              rightText: state.totalAmount ?? "0",
              rightColor: primary,
            ),
            ButtonWidget(
              title: 'check_out'.tr,
              onPressed: () {
                if (state.auth == null) {
                  Navigator.pushNamed(context, LoginScreen.routeName)
                      .then((value) {
                    if (!context.mounted) return;
                    context.read<CartCubit>().loadInitialData();
                  });
                } else {
                  Navigator.pushNamed(context, CheckOutScreen.routeName);
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<void> showDialogRemoveItemFromCart(String id) async {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          backgroundColor: appWhite,
          title: TextWidget(text: 'remove_from_cart'.tr),
          content: TextWidget(text: 'are_you_sure_to_remove_this_item'.tr),
          actions: [
            TextButton(
              child: TextWidget(text: 'cancel'.tr, color: appRedAccent),
              onPressed: () => Navigator.pop(context),
            ),
            TextButton(
              child: TextWidget(
                text: 'ok'.tr,
                color: appBlack,
              ),
              onPressed: () {
                Navigator.pop(context);
                _removeFromCart(id);
              },
            ),
          ],
        );
      },
    );
  }

  _removeFromCart(String id) async {
    try {
      LoadingOverlay.show(context);
      await context.read<CartCubit>().removeFromCart(parameters: {'id': id});
      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
      throw Exception(e);
    }
  }

  Future<void> _incrementCart(
    String id,
    String productId,
    String quantity,
  ) async {
    try {
      LoadingOverlay.show(context);
      await context.read<CartCubit>().incrementCart(parameters: {
        'id': id,
        'quantity': AppFormat.toInt(quantity) + 1,
        'product_id': productId,
      });
      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
      throw Exception(e);
    }
  }

  Future<void> _decrementCart(
    String id,
    String productId,
    String quantity,
  ) async {
    try {
      if (AppFormat.toInt(quantity) > 1) {
        LoadingOverlay.show(context);
        await context.read<CartCubit>().decrementCart(parameters: {
          'id': id,
          'product_id': productId,
          'quantity': AppFormat.toInt(quantity) - 1,
        });
        LoadingOverlay.hide();
      }
    } catch (e) {
      LoadingOverlay.hide();
      throw Exception(e);
    }
  }

  Widget _buildRow({
    required String leftText,
    required String rightText,
    Color? rightColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: leftText,
          fontSize: 12.scale,
        ),
        TextWidget(
          text: rightText,
          fontWeight: FontWeight.w600,
          color: rightColor,
          fontSize: 12.scale,
        ),
      ],
    );
  }

  Widget buildBody(CartState state) {
    var records = state.productCarts ?? [];

    if (records.isEmpty) {
      return ErrorTypeWidget(type: ErrorType.empty);
    }
    return ListView.separated(
      itemCount: records.length,
      padding: EdgeInsets.all(appPedding.scale),
      separatorBuilder: (context, index) => SizedBox(height: appSpace.scale),
      itemBuilder: (context, index) {
        return CartWidget(
          key: ValueKey(index),
          record: records[index],
          removeFromCart: showDialogRemoveItemFromCart,
          incrementCart: _incrementCart,
          decrementCart: _decrementCart,
        );
      },
    );
  }
}
