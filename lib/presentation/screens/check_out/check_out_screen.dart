import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/data/models/product_cart_model.dart';
import 'package:foxShop/presentation/screens/check_out/check_out_cubit.dart';
import 'package:foxShop/presentation/screens/check_out/check_out_state.dart';
import 'package:foxShop/presentation/widgets/aba_box_widget.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/box_address_widget.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CheckOutScreen extends StatefulWidget {
  const CheckOutScreen({super.key});
  static const routeName = 'check_out';
  static const routePath = '/check_out';

  @override
  CheckOutScreenState createState() => CheckOutScreenState();
}

class CheckOutScreenState extends State<CheckOutScreen> {
  final screenCubit = CheckOutCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  Future<void> _placeOrder() async {
    LoadingOverlay.showPlaceOrderSuccess(context);
    // Future.delayed(Duration(seconds: 3), () {
    //   LoadingOverlay.hide(); // Hide loading overlay
    // });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'check_out'.tr),
      body: BlocBuilder<CheckOutCubit, CheckOutState>(
        bloc: screenCubit,
        builder: (BuildContext context, CheckOutState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(CheckOutState state) {
    final paymentMethods = state.paymentMethods ?? [];
    final addresses = state.addresses ?? [];
    final productCarts = state.productCarts ?? [];
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Column(
        spacing: appPedding.scale,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextWidget(
            text: 'delivery_address'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 16.scale,
          ),
          Column(
            spacing: 10.scale,
            children: List.generate(addresses.length, (index) {
              final record = addresses[index];
              return BoxAddressWidget(
                record: record,
                onTap: () => _setDefaultAddress(record.id),
              );
            }).toList(),
          ),
          ButtonWidget(
            title: 'add_new_address'.tr,
            onPressed: () {
              //TODO:
            },
          ),
          TextWidget(
            text: 'order_summary'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 16.scale,
          ),
          Column(
            spacing: 10.scale,
            children: List.generate(productCarts.length, (index) {
              return _buildListProductSummary(productCarts[index]);
            }).toList(),
          ),
          TextWidget(
            text: 'payment_methods'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 16.scale,
          ),
          Column(
            spacing: 10.scale,
            children: List.generate(paymentMethods.length, (index) {
              return AbaBoxWidget(
                onTap: () {
                  screenCubit.selectPaymentMethod(paymentMethods[index].code);
                },
                imgUrl: paymentMethods[index].picture,
                blurHash: paymentMethods[index].pictureHash,
                title: paymentMethods[index].name,
                subTitle: paymentMethods[index].description,
                value: paymentMethods[index].code,
                groupValue: state.selectPaymentMethodCode,
                onChanged: (value) {
                  screenCubit.selectPaymentMethod(value ?? "");
                },
              );
            }).toList(),
          ),
          TextWidget(
            text: 'total_order'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 16.scale,
          ),
          BoxWidget(
            borderRadius: BorderRadius.circular(appRadius.scale),
            padding: EdgeInsets.all(appSpace.scale),
            child: Column(
              spacing: appSpace.scale,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(left: 'total_items'.tr, right: state.totalCart ?? ""),
                _buildRow(left: 'subtotal'.tr, right: state.subTotal ?? ""),
                // _buildRow(left: 'delivery_fee'.tr, right: '0\$'),
                _buildRow(
                  left: 'total_discount'.tr,
                  right: state.totalDiscount ?? "",
                ),
                _buildRow(
                  left: 'total_amount'.tr,
                  right: state.totalAmount ?? "",
                  color: primary,
                ),
              ],
            ),
          ),
          ButtonWidget(
            title: 'place_order'.tr,
            onPressed: () {
              _placeOrder();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildRow({
    required String left,
    required String right,
    Color? color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: left,
          fontSize: 12.scale,
        ),
        TextWidget(
          text: right,
          fontSize: 12.scale,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ],
    );
  }

  BoxWidget _buildListProductSummary(ProductCartModel record) {
    return BoxWidget(
      padding: EdgeInsets.all(appSpace.scale),
      borderRadius: BorderRadius.circular(appRadius.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: appSpace,
        children: [
          CatchImageNetworkWidget(
            borderRadius: BorderRadius.circular(appRadius.scale),
            boxFit: BoxFit.cover,
            width: 100.scale,
            height: 100.scale,
            imageUrl: record.picture,
            blurHash: record.pictureHash,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.scale,
              children: [
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: record.name,
                        style: TextStyle(
                          fontSize: 14.scale,
                        ),
                      ),
                      TextSpan(
                        text: ' x ${record.quantity}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.scale,
                        ),
                      ),
                    ],
                  ),
                ),
                if (record.sizeId.isNotEmpty && record.colorId.isNotEmpty)
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 14.scale,
                        color: textColor,
                      ),
                      children: [
                        if (record.colorId.isNotEmpty)
                          TextSpan(text: record.colorName),
                        if (record.colorId.isNotEmpty) TextSpan(text: ' | '),
                        if (record.sizeId.isNotEmpty)
                          TextSpan(text: record.sizeName),
                      ],
                    ),
                  ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: record.subtotal,
                        style: TextStyle(
                          fontSize: 14.scale,
                          color: primary,
                        ),
                      ),
                      if (record.isPromotion)
                        TextSpan(
                          text: ' ${record.totalDiscount}',
                          style: TextStyle(
                            fontSize: 12.scale,
                            color: textColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          TextWidget(
            text: record.totalAmount,
            fontSize: 14.scale,
            color: primary,
            fontWeight: FontWeight.w600,
          )
        ],
      ),
    );
  }
}
