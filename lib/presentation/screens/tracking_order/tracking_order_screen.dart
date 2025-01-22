import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/tracking_order/tracking_order_cubit.dart';
import 'package:logic_app/presentation/screens/tracking_order/tracking_order_state.dart';

class TrackingOrderScreen extends StatefulWidget {
	const TrackingOrderScreen({Key? key}) : super(key: key);
	
	@override
	_TrackingOrderScreenState createState() => _TrackingOrderScreenState();
}
	
class _TrackingOrderScreenState extends State<TrackingOrderScreen> {
	final screenCubit = TrackingOrderCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<TrackingOrderCubit, TrackingOrderState>(
				bloc: screenCubit,
				listener: (BuildContext context, TrackingOrderState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, TrackingOrderState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(TrackingOrderState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
