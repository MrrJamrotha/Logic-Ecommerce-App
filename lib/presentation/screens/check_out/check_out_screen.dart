import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/check_out/check_out_cubit.dart';
import 'package:logic_app/presentation/screens/check_out/check_out_state.dart';

class CheckOutScreen extends StatefulWidget {
	const CheckOutScreen({super.key});
	
	@override
	_CheckOutScreenState createState() => _CheckOutScreenState();
}
	
class _CheckOutScreenState extends State<CheckOutScreen> {
	final screenCubit = CheckOutCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<CheckOutCubit, CheckOutState>(
				bloc: screenCubit,
				listener: (BuildContext context, CheckOutState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, CheckOutState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(CheckOutState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
