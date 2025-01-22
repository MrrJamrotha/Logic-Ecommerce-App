import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/privacy_terms/privacy_terms_cubit.dart';
import 'package:logic_app/presentation/screens/privacy_terms/privacy_terms_state.dart';

class PrivacyTermsScreen extends StatefulWidget {
	const PrivacyTermsScreen({Key? key}) : super(key: key);
	
	@override
	_PrivacyTermsScreenState createState() => _PrivacyTermsScreenState();
}
	
class _PrivacyTermsScreenState extends State<PrivacyTermsScreen> {
	final screenCubit = PrivacyTermsCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<PrivacyTermsCubit, PrivacyTermsState>(
				bloc: screenCubit,
				listener: (BuildContext context, PrivacyTermsState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, PrivacyTermsState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(PrivacyTermsState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
