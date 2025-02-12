import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/cart/cart_cubit.dart';
import 'package:logic_app/presentation/screens/cart/cart_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
      body: BlocConsumer<CartCubit, CartState>(
        bloc: screenCubit,
        listener: (BuildContext context, CartState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
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
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
