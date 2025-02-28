import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/search/search_cubit.dart';
import 'package:foxShop/presentation/screens/search/search_state.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final screenCubit = SearchCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SearchCubit, SearchState>(
        bloc: screenCubit,
        listener: (BuildContext context, SearchState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, SearchState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(SearchState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
