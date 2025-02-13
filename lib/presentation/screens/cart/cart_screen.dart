import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/cart/cart_cubit.dart';
import 'package:logic_app/presentation/screens/cart/cart_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/cart_widget.dart';

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
