import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/address/address_cubit.dart';
import 'package:logic_app/presentation/screens/address/address_state.dart';
import 'package:logic_app/presentation/screens/create_address/create_address_screen.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_screen.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});
  static const routeName = 'address';
  static const routePath = '/address';

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
      appBar: AppbarWidget(title: 'address'.tr),
      body: BlocConsumer<AddressCubit, AddressState>(
        bloc: screenCubit,
        listener: (BuildContext context, AddressState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, AddressState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(appPedding.scale),
        child: ButtonWidget(
          title: 'add_new_address'.tr,
          onPressed: () {
            Navigator.pushNamed(context, CreateAddressScreen.routeName);
          },
        ),
      ),
    );
  }

  Widget buildBody(AddressState state) {
    return ListView.builder(
      padding: EdgeInsets.all(appPedding.scale),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: appSpace.scale),
          child: BoxWidget(
            onTap: () {
              Navigator.pushNamed(context, UpdateAddressScreen.routeName);
            },
            borderRadius: BorderRadius.circular(appRadius.scale),
            padding: EdgeInsets.all(appSpace.scale),
            child: Column(
              spacing: 5.scale,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextWidget(
                  text: 'Home',
                  fontSize: 14.scale,
                  fontWeight: FontWeight.w600,
                ),
                TextWidget(
                  text: '099 299 011',
                  fontSize: 12.scale,
                  color: textColor,
                ),
                TextWidget(
                  text:
                      "Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
                  fontSize: 12,
                  color: textColor,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
