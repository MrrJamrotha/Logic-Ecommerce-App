import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/notification_detail/notification_detail_cubit.dart';
import 'package:logic_app/presentation/screens/notification_detail/notification_detail_state.dart';

class NotificationDetailScreen extends StatefulWidget {
	const NotificationDetailScreen({Key? key}) : super(key: key);
	
	@override
	_NotificationDetailScreenState createState() => _NotificationDetailScreenState();
}
	
class _NotificationDetailScreenState extends State<NotificationDetailScreen> {
	final screenCubit = NotificationDetailCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<NotificationDetailCubit, NotificationDetailState>(
				bloc: screenCubit,
				listener: (BuildContext context, NotificationDetailState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, NotificationDetailState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(NotificationDetailState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
