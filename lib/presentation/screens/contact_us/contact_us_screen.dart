import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/contact_us/contact_us_cubit.dart';
import 'package:logic_app/presentation/screens/contact_us/contact_us_state.dart';

class ContactUsScreen extends StatefulWidget {
	const ContactUsScreen({Key? key}) : super(key: key);
	
	@override
	_ContactUsScreenState createState() => _ContactUsScreenState();
}
	
class _ContactUsScreenState extends State<ContactUsScreen> {
	final screenCubit = ContactUsCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<ContactUsCubit, ContactUsState>(
				bloc: screenCubit,
				listener: (BuildContext context, ContactUsState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, ContactUsState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(ContactUsState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
