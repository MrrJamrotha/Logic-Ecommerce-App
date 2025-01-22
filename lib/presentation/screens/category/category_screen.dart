import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/category/category_cubit.dart';
import 'package:logic_app/presentation/screens/category/category_state.dart';

class CategoryScreen extends StatefulWidget {
	const CategoryScreen({Key? key}) : super(key: key);
	
	@override
	_CategoryScreenState createState() => _CategoryScreenState();
}
	
class _CategoryScreenState extends State<CategoryScreen> {
	final screenCubit = CategoryCubit();
	
	@override
	void initState() {
		screenCubit.loadInitialData();
		super.initState();
	}
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: BlocConsumer<CategoryCubit, CategoryState>(
				bloc: screenCubit,
				listener: (BuildContext context, CategoryState state) {
					if (state.error != null) {
						// TODO your code here
					}
				},
				builder: (BuildContext context, CategoryState state) {
					if (state.isLoading) {
						return Center(child: CircularProgressIndicator());
					}
	
					return buildBody(state);
				},
			),
		);
	}
	
	Widget buildBody(CategoryState state) {
		return ListView(
			children: [
				// TODO your code here
			],
		);
	}
}
