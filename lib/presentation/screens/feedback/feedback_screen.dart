import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/feedback/feedback_cubit.dart';
import 'package:logic_app/presentation/screens/feedback/feedback_state.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  _FeedbackScreenState createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final screenCubit = FeedbackCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<FeedbackCubit, FeedbackState>(
        bloc: screenCubit,
        listener: (BuildContext context, FeedbackState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, FeedbackState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(FeedbackState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
