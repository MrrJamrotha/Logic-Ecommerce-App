import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/item_detail/item_detail_cubit.dart';
import 'package:logic_app/presentation/screens/item_detail/item_detail_state.dart';

class ItemDetailScreen extends StatefulWidget {
	const ItemDetailScreen({Key? key}) : super(key: key);
	
	@override
	_ItemDetailScreenState createState() => _ItemDetailScreenState();
}
	
class _ItemDetailScreenState extends State<ItemDetailScreen> {
	final screenCubit = ItemDetailCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<ItemDetailCubit, ItemDetailState>(
				bloc: screenCubit,
				listener: (BuildContext context, ItemDetailState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, ItemDetailState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(ItemDetailState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
