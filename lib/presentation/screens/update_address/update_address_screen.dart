import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/helper/loading_overlay.dart';
import 'package:logic_app/core/utils/app_format.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_cubit.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class UpdateAddressScreen extends StatefulWidget {
  const UpdateAddressScreen({super.key, required this.parameters});
  static const routeName = 'update_address';
  final Map<String, dynamic> parameters;
  @override
  UpdateAddressScreenState createState() => UpdateAddressScreenState();
}

class UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final screenCubit = UpdateAddressCubit();

  final _controller = Completer<GoogleMapController>();
  final _formKey = GlobalKey<FormState>();
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
    "work",
    "other",
  ];
  String _currentNickName = "home";

  @override
  void initState() {
    loadInit();
    super.initState();
  }

  void loadInit() async {
    await screenCubit.loadInitialData(widget.parameters['id']);
    var state = screenCubit.state;
    _currentNickName = state.record?.type ?? "";
    _addressLine1Ctr.text = state.record?.address ?? "";
    _addressLine2Ctr.text = state.record?.address2 ?? "";
    _cityCtr.text = state.record?.city ?? "";
    _streetNoCtr.text = state.record?.stateNo ?? "";
    _homeNoCtr.text = state.record?.homeNo ?? "";
    _countryCtr.text = state.record?.country ?? "";
    _postalCodeCtr.text = state.record?.postalCode ?? "";
    _noteCtr.text = state.record?.notes ?? "";
    _phoneCtr.text = state.record?.phoneNumber ?? "";
  }

  Future<void> _updateAddress() async {
    try {
      LoadingOverlay.show(context);
      if (_formKey.currentState!.validate()) {
        await screenCubit.updateAddress(parameters: {
          'id': widget.parameters['id'],
          'type': _currentNickName,
          'phone_number': _phoneCtr.text,
          'address': _addressLine1Ctr.text.trim(),
          'address_2': _addressLine2Ctr.text.trim(),
          'city': _cityCtr.text.trim(),
          'state_no': _streetNoCtr.text.trim(),
          'home_no': _homeNoCtr.text.trim(),
          'country': _countryCtr.text.trim(),
          'postal_code': _postalCodeCtr.text.trim(),
          'notes': _noteCtr.text.trim(),
          'latitude': screenCubit.state.position?.latitude.toString(),
          'longitude': screenCubit.state.position?.longitude.toString(),
        });
      }
      LoadingOverlay.hide();
      if (!mounted) return;
      Navigator.pop(context, {
        'record': screenCubit.state.record,
        'type': StateType.updated,
      });
    } catch (error) {
      LoadingOverlay.hide();
      throw Exception(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'update_address'.tr),
      body: BlocBuilder<UpdateAddressCubit, UpdateAddressState>(
        bloc: screenCubit,
        builder: (BuildContext context, UpdateAddressState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(appPedding.scale),
        child: ButtonWidget(
          title: 'update'.tr,
          onPressed: () => _updateAddress(),
        ),
      ),
    );
  }

  Widget buildBody(UpdateAddressState state) {
    print(LatLng(
      state.position?.latitude ?? 11.5564,
      state.position?.longitude ?? 104.9282,
    ));
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Form(
        key: _formKey,
        child: Column(
          spacing: appPedding.scale,
          children: [
            SizedBox(
              height: 300.scale,
              child: Stack(
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        AppFormat.toDouble(state.record?.latitude),
                        AppFormat.toDouble(state.record?.longitude),
                      ),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    onCameraMove: (position) =>
                        screenCubit.updatePosition(position),

                    onCameraIdle: () {
                      if (state.position != null) {
                        screenCubit.getAddressFromCoordinates(
                          state.position!.latitude,
                          state.position!.longitude,
                        );
                      }
                    },
                    // ignore: prefer_collection_literals
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer())),
                  ),
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Image.asset(
                        pinPng,
                        width: 24.scale,
                        height: 24.scale,
                      ),
                    ),
                  ),
                ],
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
