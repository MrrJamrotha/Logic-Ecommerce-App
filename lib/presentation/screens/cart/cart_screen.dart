import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/cart/cart_cubit.dart';
import 'package:logic_app/presentation/screens/cart/cart_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/cart_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  CartScreenState createState() => CartScreenState();
}

class CartScreenState extends State<CartScreen> {
  final screenCubit = CartCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'carts'.tr),
      body: BlocBuilder<CartCubit, CartState>(
        bloc: screenCubit,
        builder: (BuildContext context, CartState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar: BoxWidget(
        padding: EdgeInsets.all(appSpace.scale),
        borderRadius: BorderRadius.circular(appRadius.scale),
        margin: EdgeInsets.all(appPedding.scale),
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
                //TODO: check
              },
            )
          ],
        ),
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
    return ListView.builder(
      itemCount: 10,
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
