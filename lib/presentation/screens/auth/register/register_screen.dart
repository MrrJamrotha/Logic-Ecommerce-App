import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/auth/register/register_cubit.dart';
import 'package:logic_app/presentation/screens/auth/register/register_state.dart';

class RegisterScreen extends StatefulWidget {
	const RegisterScreen({Key? key}) : super(key: key);
	
	@override
	_RegisterScreenState createState() => _RegisterScreenState();
}
	
class _RegisterScreenState extends State<RegisterScreen> {
	final screenCubit = RegisterCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<RegisterCubit, RegisterState>(
				bloc: screenCubit,
				listener: (BuildContext context, RegisterState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, RegisterState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(RegisterState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
