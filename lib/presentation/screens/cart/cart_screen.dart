import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_images.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/user_model.dart';
import 'package:foxShop/presentation/screens/auth/login/login_screen.dart';
import 'package:foxShop/presentation/screens/cart/cart_cubit.dart';
import 'package:foxShop/presentation/screens/cart/cart_state.dart';
import 'package:foxShop/presentation/screens/check_out/check_out_screen.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/cart_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  static const routeName = 'cart_screen';
  static const routePath = '/cart_screen';

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final screenCubit = CartCubit();
  UserModel? auth;
  @override
  void initState() {
    screenCubit.loadInitialData();

    super.initState();
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
      appBar: AppbarWidget(title: 'carts'.tr),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: screenCubit,
        builder: (BuildContext context, CartState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar: BlocSelector<CartCubit, CartState, UserModel?>(
        bloc: screenCubit,
        selector: (state) {
          return state.auth;
        },
        builder: (context, state) {
          // if (state == null) {
          //   return SizedBox.shrink();
          // }
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
                    rightText: '6',
                  ),
                  _buildRow(
                    leftText: 'total_amount'.tr,
                    rightText: '3499.99\$',
                    rightColor: primary,
                  ),
                  ButtonWidget(
                    title: 'check_out'.tr,
                    onPressed: () {
                      Navigator.pushNamed(context, CheckOutScreen.routeName);
                    },
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
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
    if (state.auth == null) {
      return Padding(
        padding: EdgeInsets.all(appPedding.scale),
        child: Column(
          spacing: appPedding.scale,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                loginPng,
                width: 200.scale,
                height: 200.scale,
              ),
            ),
            ButtonWidget(
              title: 'sign_in'.tr,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName)
                    .then((value) {
                  screenCubit.loadInitialData();
                });
              },
            )
          ],
        ),
      );
    }
    return ListView.builder(
      itemCount: 0,
      padding: EdgeInsets.all(appPedding.scale),
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: appPedding.scale),
          child: CartWidget(),
        );
      },
    );
  }
}
