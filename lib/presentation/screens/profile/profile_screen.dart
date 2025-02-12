import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/profile/profile_cubit.dart';
import 'package:logic_app/presentation/screens/profile/profile_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final screenCubit = ProfileCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'Account'.tr),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        bloc: screenCubit,
        listener: (BuildContext context, ProfileState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ProfileState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ProfileState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
