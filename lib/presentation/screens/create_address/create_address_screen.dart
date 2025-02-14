import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/create_address/create_address_cubit.dart';
import 'package:logic_app/presentation/screens/create_address/create_address_state.dart';

class CreateAddressScreen extends StatefulWidget {
  const CreateAddressScreen({super.key});
  static const routeName = 'create_address';
  static const routePath = '/create_address';

  @override
  CreateAddressScreenState createState() => CreateAddressScreenState();
}

class CreateAddressScreenState extends State<CreateAddressScreen> {
  final screenCubit = CreateAddressCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CreateAddressCubit, CreateAddressState>(
        bloc: screenCubit,
        listener: (BuildContext context, CreateAddressState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, CreateAddressState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(CreateAddressState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Column(
        children: [
          SizedBox(
            height: 300.scale,
            child: GoogleMap(
              mapType: MapType.normal,
              initialCameraPosition: CameraPosition(
                target: LatLng(11.5564, 104.9282),
              ),
              onMapCreated: (controller) {
                
              },
            ),
          ),
        ],
      ),
    );
  }
}
