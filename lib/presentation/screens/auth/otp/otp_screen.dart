import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_cubit.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_state.dart';

class OtpScreen extends StatefulWidget {
	const OtpScreen({Key? key}) : super(key: key);
	
	@override
	_OtpScreenState createState() => _OtpScreenState();
}
	
class _OtpScreenState extends State<OtpScreen> {
	final screenCubit = OtpCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<OtpCubit, OtpState>(
				bloc: screenCubit,
				listener: (BuildContext context, OtpState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, OtpState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(OtpState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
