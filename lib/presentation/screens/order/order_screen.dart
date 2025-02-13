import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/order/order_cubit.dart';
import 'package:logic_app/presentation/screens/order/order_state.dart';

class OrderScreen extends StatefulWidget {
	const OrderScreen({super.key});
  static const routeName = 'order';
  static const routePath = '/order';

	
	@override
	OrderScreenState createState() => OrderScreenState();
}
	
class OrderScreenState extends State<OrderScreen> {
	final screenCubit = OrderCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<OrderCubit, OrderState>(
				bloc: screenCubit,
				listener: (BuildContext context, OrderState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, OrderState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(OrderState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
