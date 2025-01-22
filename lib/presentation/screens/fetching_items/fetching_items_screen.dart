import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_cubit.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_state.dart';

class FetchingItemsScreen extends StatefulWidget {
	const FetchingItemsScreen({Key? key}) : super(key: key);
	
	@override
	_FetchingItemsScreenState createState() => _FetchingItemsScreenState();
}
	
class _FetchingItemsScreenState extends State<FetchingItemsScreen> {
	final screenCubit = FetchingItemsCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<FetchingItemsCubit, FetchingItemsState>(
				bloc: screenCubit,
				listener: (BuildContext context, FetchingItemsState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, FetchingItemsState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(FetchingItemsState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
