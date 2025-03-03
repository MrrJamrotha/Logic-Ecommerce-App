import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/order_line_model.dart';
import 'package:foxShop/presentation/widgets/error_type_widget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/order_detail/order_detail_cubit.dart';
import 'package:foxShop/presentation/screens/order_detail/order_detail_state.dart';
import 'package:foxShop/presentation/screens/write_review/write_review_screen.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key, required this.parameters});
  static const routeName = 'order_detail';
  static const routePath = '/order_detail';
  final Map<String, dynamic> parameters;
  @override
  OrderDetailScreenState createState() => OrderDetailScreenState();
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  final screenCubit = OrderDetailCubit();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  void initState() {
    screenCubit.loadInitialData(parameters: {'id': widget.parameters['id']});
    super.initState();
  }

  showModelProductWriteReview() {
    showModalBottomSheet(
      backgroundColor: appWhite,
      isScrollControlled: true,
      showDragHandle: true,
      useRootNavigator: true,
      context: context,
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.9),
          child: Padding(
            padding: EdgeInsets.all(appPedding.scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 5.scale,
              children: [
                TextWidget(
                  text: 'choose_product_review'.tr,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.scale,
                ),
                Divider(),
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: appSpace.scale),
                      child: _buildListWriteReview(),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'order_detail'.tr),
      body: BlocBuilder<OrderDetailCubit, OrderDetailState>(
        bloc: screenCubit,
        builder: (BuildContext context, OrderDetailState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(OrderDetailState state) {
    final record = state.record;
    if (record == null) {
      return ErrorTypeWidget(type: ErrorType.notFound);
    }
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: appPedding.scale,
        children: [
          TextWidget(
            text: 'order_information'.tr,
            fontSize: 14.scale,
            fontWeight: FontWeight.w600,
          ),
          BoxWidget(
            onTap: () {
              Navigator.pushNamed(context, OrderDetailScreen.routeName,
                  arguments: {
                    'id': record.id,
                  });
            },
            borderRadius: BorderRadius.circular(appRadius.scale),
            padding: EdgeInsets.all(10.scale),
            child: Column(
              spacing: appSpace.scale,
              children: [
                _buildRowOrder(
                  left: 'status'.tr,
                  right: record.orderStatus,
                  isStatus: true,
                ),
                _buildRowOrder(
                    left: record.documentCode, right: record.orderDate),
                _buildRowOrder(
                  left: 'payment_method'.tr,
                  right: record.paymentMethodModel.name,
                ),
                _buildRowOrder(
                    left: 'total_items'.tr, right: record.orderLineCount),
                _buildRowOrder(
                    left: 'delivery_fee'.tr, right: record.deliveryFee),
                _buildRowOrder(
                    left: 'total_discount'.tr, right: record.totalDiscount),
                _buildRowOrder(
                    left: 'total_amount'.tr, right: record.totalAmount),
              ],
            ),
          ),
          TextWidget(
            text: 'address_information'.tr,
            fontSize: 14.scale,
            fontWeight: FontWeight.w600,
          ),
          BoxWidget(
            borderRadius: BorderRadius.circular(appRadius.scale),
            padding: EdgeInsets.all(10.scale),
            child: Column(
              spacing: appSpace.scale,
              children: [
                _buildRow(
                  left: 'address'.tr,
                  right: record.addressModel.address,
                ),
                _buildRow(
                  left: 'phone_number'.tr,
                  right: record.addressModel.phoneNumber,
                ),
                _buildRow(
                  left: 'home_no'.tr,
                  right: record.addressModel.homeNo,
                ),
                _buildRow(
                  left: 'street_no'.tr,
                  right: record.addressModel.stateNo,
                ),
                _buildRow(
                  left: 'postal_code'.tr,
                  right: record.addressModel.postalCode,
                ),
                _buildRow(left: 'city'.tr, right: record.addressModel.city),
                _buildRow(
                  left: 'country'.tr,
                  right: record.addressModel.country,
                ),
                _buildRow(
                  left: 'note'.tr,
                  leftColor: appYellow,
                  right: record.addressModel.notes,
                  rightColor: textColor,
                ),
                SizedBox(
                  height: 300.scale,
                  child: GoogleMap(
                    myLocationButtonEnabled: false,
                    myLocationEnabled: true,
                    zoomGesturesEnabled: false,
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        AppFormat.toDouble(record.addressModel.latitude),
                        AppFormat.toDouble(record.addressModel.longitude),
                      ),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    markers: {
                      Marker(
                        markerId: MarkerId(record.addressModel.phoneNumber),
                        position: LatLng(
                          AppFormat.toDouble(record.addressModel.latitude),
                          AppFormat.toDouble(record.addressModel.longitude),
                        ),
                      )
                    },
                    // ignore: prefer_collection_literals
                    gestureRecognizers: Set()
                      ..add(Factory<PanGestureRecognizer>(
                          () => PanGestureRecognizer())),
                  ),
                ),
              ],
            ),
          ),
          TextWidget(
            text: 'order_item_summart'.tr,
            fontSize: 14.scale,
            fontWeight: FontWeight.w600,
          ),
          Column(
              children: List.generate(
            record.orderLines.length,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: appSpace.scale),
              child: _buildListProductSummary(record.orderLines[index]),
            ),
          )),
          ButtonWidget(
            width: double.infinity,
            title: 'write_reviw'.tr,
            onPressed: () {
              showModelProductWriteReview();
            },
          )
        ],
      ),
    );
  }

  BoxWidget _buildListWriteReview() {
    return BoxWidget(
      onTap: () {
        Navigator.pushNamed(context, WriteReviewScreen.routeName);
        Navigator.pop(context);
      },
      padding: EdgeInsets.all(appSpace.scale),
      borderRadius: BorderRadius.circular(appRadius.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CatchImageNetworkWidget(
                borderRadius: BorderRadius.circular(appRadius.scale),
                boxFit: BoxFit.cover,
                width: 100.scale,
                height: 100.scale,
                imageUrl:
                    'https://crdms.images.consumerreports.org/prod/products/cr/models/399694-smartphones-apple-iphone-11-10008711.png',
                blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 5.scale,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'IPhone 16 pro ',
                          style: TextStyle(
                            fontSize: 14.scale,
                          ),
                        ),
                        TextSpan(
                          text: 'x 2',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14.scale,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 14.scale,
                        color: textColor,
                      ),
                      children: [
                        TextSpan(text: 'Blue'),
                        TextSpan(text: ' | '),
                        TextSpan(text: '128 GB'),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
          Center(
            child: IconWidget(
              assetName: arrowRightSvg,
              width: 24.scale,
              height: 24.scale,
            ),
          )
        ],
      ),
    );
  }

  _buildListProductSummary(OrderLineModel record) {
    return BoxWidget(
      padding: EdgeInsets.all(appSpace.scale),
      borderRadius: BorderRadius.circular(appRadius.scale),
      child: Row(
        spacing: appSpace.scale,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
                        text: 'x ${record.quantity}',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.scale,
                        ),
                      ),
                    ],
                  ),
                ),
                if (record.colorName.isNotEmpty && record.sizeName.isNotEmpty)
                  Text.rich(
                    TextSpan(
                      style: TextStyle(
                        fontSize: 14.scale,
                        color: textColor,
                      ),
                      children: [
                        if (record.colorName.isNotEmpty)
                          TextSpan(text: record.colorName),
                        if (record.colorName.isNotEmpty) TextSpan(text: ' | '),
                        if (record.sizeName.isNotEmpty)
                          TextSpan(text: record.sizeName),
                      ],
                    ),
                  ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '${record.totalAmount} ',
                        style: TextStyle(
                          fontSize: 14.scale,
                          color: primary,
                        ),
                      ),
                      if (record.isPromotion)
                        TextSpan(
                          text: record.totalDiscount,
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

  Widget _buildRow({
    required String left,
    required String right,
    Color? leftColor,
    Color? rightColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      spacing: appSpace.scale,
      children: [
        TextWidget(
          text: left,
          fontSize: 14.scale,
          fontWeight: FontWeight.w600,
          color: leftColor,
        ),
        Expanded(
          child: TextWidget(
            textAlign: TextAlign.end,
            text: right,
            fontSize: 14.scale,
            color: rightColor,
          ),
        ),
      ],
    );
  }

  Row _buildRowOrder({
    required String left,
    required String right,
    bool isStatus = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        TextWidget(
          text: left,
          fontSize: 14.scale,
          fontWeight: FontWeight.w600,
        ),
        if (!isStatus)
          TextWidget(
            text: right,
            fontSize: 14.scale,
            fontWeight: FontWeight.w600,
          ),
        if (isStatus)
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.scale,
              vertical: 5.scale,
            ),
            decoration: BoxDecoration(
              color: getOrderColorStatus(getEnumOrderStatus(right)),
              borderRadius: BorderRadius.circular(appRadius.scale),
            ),
            child: TextWidget(
              text: right,
              fontSize: 14.scale,
              fontWeight: FontWeight.w600,
              color: appWhite,
            ),
          ),
      ],
    );
  }
}
