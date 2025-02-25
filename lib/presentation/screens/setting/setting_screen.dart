import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:logic_app/presentation/screens/setting/setting_state.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  final screenCubit = SettingCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<SettingCubit, SettingState>(
        bloc: screenCubit,
        listener: (BuildContext context, SettingState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, SettingState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(SettingState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
