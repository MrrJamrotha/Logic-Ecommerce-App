import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/check_out/check_out_cubit.dart';
import 'package:logic_app/presentation/screens/check_out/check_out_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const routeName = 'check_out';
  static const routePath = '/check_out';

  @override
  CheckOutScreenState createState() => CheckOutScreenState();
}

class CheckOutScreenState extends State<CheckOutScreen> {
  final screenCubit = CheckOutCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'check_out'.tr),
      body: BlocConsumer<CheckOutCubit, CheckOutState>(
        bloc: screenCubit,
        listener: (BuildContext context, CheckOutState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, CheckOutState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(CheckOutState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
