import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/presentation/screens/address/address_cubit.dart';
import 'package:logic_app/presentation/screens/address/address_state.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});
  static const routeName = 'address';
  

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen> {
  final screenCubit = AddressCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AddressCubit, AddressState>(
        bloc: screenCubit,
        listener: (BuildContext context, AddressState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, AddressState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(AddressState state) {
    return ListView(
      children: [
        // TODO your code here
      ],
    );
  }
}
