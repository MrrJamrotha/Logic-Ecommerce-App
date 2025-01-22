import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/promotion/promotion_cubit.dart';
import 'package:logic_app/presentation/screens/promotion/promotion_state.dart';

class PromotionScreen extends StatefulWidget {
  const PromotionScreen({Key? key}) : super(key: key);

  @override
  _PromotionScreenState createState() => _PromotionScreenState();
}

class _PromotionScreenState extends State<PromotionScreen> {
  final screenCubit = PromotionCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PromotionCubit, PromotionState>(
        bloc: screenCubit,
        listener: (BuildContext context, PromotionState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, PromotionState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(PromotionState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
