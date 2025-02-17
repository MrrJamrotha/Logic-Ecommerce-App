import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/check_out/check_out_cubit.dart';
import 'package:logic_app/presentation/screens/check_out/check_out_state.dart';
import 'package:logic_app/presentation/widgets/aba_box_widget.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'check_out'.tr),
      body: BlocConsumer<CheckOutCubit, CheckOutState>(
        bloc: screenCubit,
        listener: (BuildContext context, CheckOutState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, CheckOutState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(CheckOutState state) {
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
          BoxWidget(
            borderRadius: BorderRadius.circular(appRadius.scale),
            padding: EdgeInsets.all(appSpace.scale),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 5.scale,
              children: [
                TextWidget(
                  text: 'Home',
                  fontWeight: FontWeight.w600,
                ),
                TextWidget(
                  text: '099 299 011',
                  fontSize: 12.scale,
                ),
                TextWidget(
                  text:
                      "Lorem Ipsumis simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's",
                  fontSize: 12.scale,
                ),
              ],
            ),
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
          _buildListProductSummary(),
          _buildListProductSummary(),
          TextWidget(
            text: 'payment_methods'.tr,
            fontWeight: FontWeight.w600,
            fontSize: 16.scale,
          ),
          AbaBoxWidget(
            imgUrl:
                'https://eliteextra.com/wp-content/uploads/2022/11/best-practices-for-managing-cash-on-delivery.jpg',
            blurHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
            title: 'Casg on delivery',
            subTitle: '',
            value: 'cash_on_delivery',
            groupValue: '',
            onChanged: (p0) {},
          ),
          AbaBoxWidget(
            imgUrl:
                'https://devithuotkeo.com/static/image/portfolio/khqr/khqr-5.png',
            blurHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
            title: 'ABA',
            subTitle: 'Scan to pay with any banking app',
            value: 'aba',
            groupValue: '',
            onChanged: (p0) {},
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
                _buildRow(left: 'total_items'.tr, right: '6'),
                _buildRow(left: 'subtotal'.tr, right: '3499.99\$'),
                _buildRow(left: 'delivery_fee'.tr, right: '0\$'),
                _buildRow(left: 'total_discount'.tr, right: '0\$'),
                _buildRow(
                  left: 'total_amount'.tr,
                  right: '3499.99\$',
                  color: primary,
                ),
              ],
            ),
          ),
          ButtonWidget(
            title: 'place_order'.tr,
            onPressed: () {
              //TODO:
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

  BoxWidget _buildListProductSummary() {
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
}
