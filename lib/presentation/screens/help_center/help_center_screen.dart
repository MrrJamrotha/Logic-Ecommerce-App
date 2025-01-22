import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/help_center/help_center_cubit.dart';
import 'package:logic_app/presentation/screens/help_center/help_center_state.dart';

class HelpCenterScreen extends StatefulWidget {
	const HelpCenterScreen({Key? key}) : super(key: key);
	
	@override
	_HelpCenterScreenState createState() => _HelpCenterScreenState();
}
	
class _HelpCenterScreenState extends State<HelpCenterScreen> {
	final screenCubit = HelpCenterCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<HelpCenterCubit, HelpCenterState>(
				bloc: screenCubit,
				listener: (BuildContext context, HelpCenterState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, HelpCenterState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(HelpCenterState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
