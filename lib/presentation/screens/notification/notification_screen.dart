import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/notification/notification_cubit.dart';
import 'package:logic_app/presentation/screens/notification/notification_state.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  final screenCubit = NotificationCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<NotificationCubit, NotificationState>(
        bloc: screenCubit,
        listener: (BuildContext context, NotificationState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, NotificationState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(NotificationState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
