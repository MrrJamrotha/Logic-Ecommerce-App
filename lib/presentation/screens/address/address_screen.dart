import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foxShop/presentation/widgets/box_address_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/data/models/address_model.dart';
import 'package:foxShop/presentation/screens/address/address_cubit.dart';
import 'package:foxShop/presentation/screens/address/address_state.dart';
import 'package:foxShop/presentation/screens/create_address/create_address_screen.dart';
import 'package:foxShop/presentation/screens/update_address/update_address_screen.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/error_type_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key, required this.parameters});
  static const routeName = 'address';
  static const routePath = '/address';
  final Map<String, dynamic> parameters;

  @override
  AddressScreenState createState() => AddressScreenState();
}

class AddressScreenState extends State<AddressScreen>
    with TickerProviderStateMixin {
  final screenCubit = AddressCubit();
  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  void _handleDelete(String id) async {
    try {
      Navigator.pop(context);
      LoadingOverlay.show(context);
      await screenCubit.deleteAddress(id);
      LoadingOverlay.hide();
    } catch (e) {
      throw Exception(e);
    }
  }

  void _setDefaultAddress(String id) async {
    try {
      LoadingOverlay.show(context);
      await screenCubit.setDefaultAddress(id);
      LoadingOverlay.hide();
    } catch (e) {
      throw Exception(e);
    }
  }

  showDialogDeleteAddress(String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: appWhite,
          title: Text('delete'.tr),
          content: Text('delete_address_content'.tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'cancel'.tr,
                color: appRedAccent,
              ),
            ),
            TextButton(
              onPressed: () => _handleDelete(id),
              child: TextWidget(
                text: 'ok'.tr,
                color: appBlack,
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleUpdateOpen(BuildContext context, String id) {
    Navigator.pushNamed(context, UpdateAddressScreen.routeName,
        arguments: {'id': id}).then((response) {
      var data = response as Map;
      if (data['record'] != null) {
        screenCubit.updateAddress(data['record']);
      }
    });
  }

  void _handleDeleteOpen(BuildContext context, String id) {
    showDialogDeleteAddress(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: 'address'.tr,
        isBack: true,
        onBackPress: () {
          Navigator.pop(context, {'state': widget.parameters['state']});
        },
      ),
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
            child: Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                children: [
                  SlidableAction(
                    padding: EdgeInsets.all(appPedding.scale),
                    backgroundColor: appGreen,
                    onPressed: (context) => _handleUpdateOpen(
                      context,
                      record.id,
                    ),
                    icon: Icons.edit_document,
                    label: 'update'.tr,
                  ),
                  SlidableAction(
                    onPressed: (context) =>
                        _handleDeleteOpen(context, record.id),
                    icon: Icons.delete,
                    backgroundColor: appRedAccent,
                    label: 'delete'.tr,
                  ),
                ],
              ),
              child: BoxAddressWidget(
                record: record,
                onTap: () => _setDefaultAddress(record.id),
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
