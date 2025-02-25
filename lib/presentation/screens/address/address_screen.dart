import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/address_model.dart';
import 'package:logic_app/presentation/screens/address/address_cubit.dart';
import 'package:logic_app/presentation/screens/address/address_state.dart';
import 'package:logic_app/presentation/screens/create_address/create_address_screen.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_screen.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/error_type_widget.dart';
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
      body: BlocBuilder<AddressCubit, AddressState>(
        bloc: screenCubit,
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
            Navigator.pushNamed(context, CreateAddressScreen.routeName)
                .then((value) {
              var data = value as Map;
              if (data['record'] != null) {
                screenCubit.insertAddress(data['record']);
              }
            });
          },
        ),
      ),
    );
  }

  Widget buildBody(AddressState state) {
    final records = state.records ?? [];
    if (records.isEmpty) {
      return ErrorTypeWidget(type: ErrorType.empty);
    }
    return PagedListView<int, AddressModel>(
      pagingController: screenCubit.pagingController,
      padding: EdgeInsets.all(appPedding.scale),
      builderDelegate: PagedChildBuilderDelegate<AddressModel>(
        itemBuilder: (context, record, index) {
          return Padding(
            padding: EdgeInsets.only(bottom: appSpace.scale),
            child: BoxWidget(
              onTap: () {
                Navigator.pushNamed(context, UpdateAddressScreen.routeName,
                    arguments: {'id': record.id}).then((response) {
                  var data = response as Map;
                  if (data['record'] != null) {
                    screenCubit.updateAddress(data['record']);
                  }
                });
              },
              borderRadius: BorderRadius.circular(appRadius.scale),
              padding: EdgeInsets.all(appSpace.scale),
              child: Column(
                spacing: 5.scale,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: record.type,
                    fontSize: 14.scale,
                    fontWeight: FontWeight.w600,
                  ),
                  TextWidget(
                    text: record.phoneNumber,
                    fontSize: 12.scale,
                    color: textColor,
                  ),
                  TextWidget(
                    text: record.address,
                    fontSize: 12,
                    color: textColor,
                  )
                ],
              ),
            ),
          );
        },
        firstPageProgressIndicatorBuilder: (_) => centerLoading(),
        newPageProgressIndicatorBuilder: (_) => centerLoading(),
        noItemsFoundIndicatorBuilder: (_) => centerNotFoundProduct(),
      ),
    );
  }
}
