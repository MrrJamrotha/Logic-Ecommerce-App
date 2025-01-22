import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/promotion_detail/promotion_detail_cubit.dart';
import 'package:logic_app/presentation/screens/promotion_detail/promotion_detail_state.dart';

class PromotionDetailScreen extends StatefulWidget {
  const PromotionDetailScreen({Key? key}) : super(key: key);

  @override
  _PromotionDetailScreenState createState() => _PromotionDetailScreenState();
}

class _PromotionDetailScreenState extends State<PromotionDetailScreen> {
  final screenCubit = PromotionDetailCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PromotionDetailCubit, PromotionDetailState>(
        bloc: screenCubit,
        listener: (BuildContext context, PromotionDetailState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, PromotionDetailState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(PromotionDetailState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
