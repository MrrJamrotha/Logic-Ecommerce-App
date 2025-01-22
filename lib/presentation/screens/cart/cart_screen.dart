import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/cart/cart_cubit.dart';
import 'package:logic_app/presentation/screens/cart/cart_state.dart';

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
