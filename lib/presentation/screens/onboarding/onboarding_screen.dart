import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_cubit.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_state.dart';

class OnboardingScreen extends StatefulWidget {
	const OnboardingScreen({Key? key}) : super(key: key);
	
	@override
	_OnboardingScreenState createState() => _OnboardingScreenState();
}
	
class _OnboardingScreenState extends State<OnboardingScreen> {
	final screenCubit = OnboardingCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<OnboardingCubit, OnboardingState>(
				bloc: screenCubit,
				listener: (BuildContext context, OnboardingState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, OnboardingState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(OnboardingState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
