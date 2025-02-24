import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/edit_profile/edit_profile_cubit.dart';
import 'package:logic_app/presentation/screens/edit_profile/edit_profile_state.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});
  static const routeName = 'edit_profile';

  @override
  EditProfileScreenState createState() => EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  final screenCubit = EditProfileCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<EditProfileCubit, EditProfileState>(
        bloc: screenCubit,
        listener: (BuildContext context, EditProfileState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, EditProfileState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(EditProfileState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
