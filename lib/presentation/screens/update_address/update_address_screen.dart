import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_cubit.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({super.key});
  static const routeName = 'update_address';
  static const routePath = '/update_address';

  @override
  UpdateAddressScreenState createState() => UpdateAddressScreenState();
}

class UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final screenCubit = UpdateAddressCubit();

  final _controller = Completer<GoogleMapController>();
  final _formKey = GlobalKey<FormState>();
  final _nikeNameCtr = TextEditingController();
  final _phoneCtr = TextEditingController();
  final _addressLine1Ctr = TextEditingController();
  final _addressLine2Ctr = TextEditingController();
  final _cityCtr = TextEditingController();
  final _streetNoCtr = TextEditingController();
  final _homeNoCtr = TextEditingController();
  final _countryCtr = TextEditingController();
  final _postalCodeCtr = TextEditingController();
  final _noteCtr = TextEditingController();

  final List<String> _nickNames = [
    "home",
    "office",
    "other",
  ];
  String _currentNickName = "home";

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'update_address'.tr),
      body: BlocConsumer<UpdateAddressCubit, UpdateAddressState>(
        bloc: screenCubit,
        listener: (BuildContext context, UpdateAddressState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, UpdateAddressState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(appPedding.scale),
        child: ButtonWidget(
            title: 'update'.tr,
            onPressed: () {
              //TODO
            }),
      ),
    );
  }

  Widget buildBody(UpdateAddressState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: appPedding.scale,
          children: [
            SizedBox(
              height: 300.scale,
              child: GoogleMap(
                myLocationEnabled: false,
                myLocationButtonEnabled: false,
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    state.position?.latitude ?? 11.5564,
                    state.position?.longitude ?? 104.9282,
                  ),
                  zoom: 15,
                ),
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
                // ignore: prefer_collection_literals
                gestureRecognizers: Set()
                  ..add(Factory<PanGestureRecognizer>(
                      () => PanGestureRecognizer())),
              ),
            ),
            DropdownButton<String>(
              value: _currentNickName,
              isExpanded: true,
              itemHeight: 60,
              dropdownColor: appWhite,
              items: _nickNames.map((String item) {
                return DropdownMenuItem(
                  value: item,
                  child: Padding(
                    padding: EdgeInsets.all(appPedding.scale),
                    child: TextWidget(text: item),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _currentNickName = newValue!;
                  _nikeNameCtr.text = _currentNickName;
                });
              },
            ),
            TextFormField(
              controller: _phoneCtr,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'phone_number'.tr,
              ),
            ),
            TextFormField(
              controller: _addressLine1Ctr,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'address_line_1'.tr,
              ),
            ),
            TextFormField(
              controller: _addressLine2Ctr,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'address_line_2'.tr,
              ),
            ),
            Row(
              spacing: appSpace.scale,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _cityCtr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'city'.tr,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _homeNoCtr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'home_no'.tr,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              spacing: appSpace.scale,
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _countryCtr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'country'.tr,
                    ),
                  ),
                ),
                Expanded(
                  child: TextFormField(
                    controller: _streetNoCtr,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'street_no'.tr,
                    ),
                  ),
                ),
              ],
            ),
            TextFormField(
              controller: _postalCodeCtr,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'postal_code'.tr,
              ),
            ),
            TextFormField(
              controller: _noteCtr,
              maxLines: 5,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'note'.tr,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
