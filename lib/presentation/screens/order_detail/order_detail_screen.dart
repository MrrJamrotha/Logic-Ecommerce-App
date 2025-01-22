import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/order_detail/order_detail_cubit.dart';
import 'package:logic_app/presentation/screens/order_detail/order_detail_state.dart';

class OrderDetailScreen extends StatefulWidget {
	const OrderDetailScreen({Key? key}) : super(key: key);
	
	@override
	_OrderDetailScreenState createState() => _OrderDetailScreenState();
}
	
class _OrderDetailScreenState extends State<OrderDetailScreen> {
	final screenCubit = OrderDetailCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<OrderDetailCubit, OrderDetailState>(
				bloc: screenCubit,
				listener: (BuildContext context, OrderDetailState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, OrderDetailState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(OrderDetailState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
