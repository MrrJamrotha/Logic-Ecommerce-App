import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_cubit.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/header_delegate_widget.dart';
import 'package:logic_app/presentation/widgets/product_card_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class FetchingItemsScreen extends StatefulWidget {
  const FetchingItemsScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  FetchingItemsScreenState createState() => FetchingItemsScreenState();
}

class FetchingItemsScreenState extends State<FetchingItemsScreen> {
  final screenCubit = FetchingItemsCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: widget.title),
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
    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          delegate: HeaderDelegateWidget(
            child: ListView.builder(
              padding: EdgeInsets.all(appPedding.scale),
              itemCount: 10,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(right: appSpace.scale),
                  child: OutlinedButton(
                    onPressed: () {
                      // TODO your code here
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.all(appSpace.scale),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(appRadius.scale),
                      ),
                    ),
                    child: TextWidget(text: 'text'),
                  ),
                );
              },
            ),
          ),
        ),
        // SliverList.builder(
        //   itemCount: 10,
        //   itemBuilder: (context, index) {
        //     // return ProductCardWidget(record: record, isLoading: isLoading)
        //   },
        // ),
      ],
    );
  }
}
