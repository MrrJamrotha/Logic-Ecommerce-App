import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/order_detail/order_detail_cubit.dart';
import 'package:logic_app/presentation/screens/order_detail/order_detail_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/order_card_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class OrderDetailScreen extends StatefulWidget {
  const OrderDetailScreen({super.key});
  static const routeName = 'order_detail';
  static const routePath = '/order_detail';

  @override
  OrderDetailScreenState createState() => OrderDetailScreenState();
}

class OrderDetailScreenState extends State<OrderDetailScreen> {
  final screenCubit = OrderDetailCubit();
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  // Future<void> _goToTheLake() async {
  //   final GoogleMapController controller = await _controller.future;
  //   await controller.animateCamera(CameraUpdate.newCameraPosition( ));
  // }

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
                TextWidget(text: 'Please choose product for write review'),
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
      body: BlocConsumer<OrderDetailCubit, OrderDetailState>(
        bloc: screenCubit,
        listener: (BuildContext context, OrderDetailState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, OrderDetailState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(OrderDetailState state) {
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
          OrderCardWidget(orderStatus: OrderStatus.completed),
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
                  right:
                      "Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
                ),
                _buildRow(left: 'phone_number'.tr, right: '099 299 020'),
                _buildRow(left: 'phone_number'.tr, right: '099 299 020'),
                _buildRow(left: 'home_no'.tr, right: '123'),
                _buildRow(left: 'street_no'.tr, right: '123'),
                _buildRow(left: 'postal_code'.tr, right: '123213'),
                _buildRow(left: 'city'.tr, right: 'Pnhom penh'),
                _buildRow(left: 'country'.tr, right: 'Cambodia'),
                _buildRow(
                  left: 'note'.tr,
                  leftColor: appYellow,
                  right:
                      "Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
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
                      target: LatLng(11.5564, 104.9282),
                      zoom: 15,
                    ),
                    onMapCreated: (controller) {
                      _controller.complete(controller);
                    },
                    markers: {
                      const Marker(
                        markerId: MarkerId('Sydney'),
                        position: LatLng(11.5564, 104.9282),
                      )
                    },
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
            2,
            (index) => Padding(
              padding: EdgeInsets.only(bottom: appSpace.scale),
              child: _buildListProductSummary(),
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

  BoxWidget _buildListProductSummary() {
    return BoxWidget(
      padding: EdgeInsets.all(appSpace.scale),
      borderRadius: BorderRadius.circular(appRadius.scale),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.scale,
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
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '1299.99\$ ',
                        style: TextStyle(
                          fontSize: 14.scale,
                          color: primary,
                        ),
                      ),
                      TextSpan(
                        text: '1399.99\$',
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
            text: '2599.99\$',
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
}
