import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/order_detail/order_detail_screen.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({super.key, required this.orderStatus});
  final OrderStatus orderStatus;

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailScreen.routeName);
      },
      borderRadius: BorderRadius.circular(appRadius.scale),
      padding: EdgeInsets.all(10.scale),
      child: Column(
        spacing: appSpace.scale,
        children: [
          _buildRow(left: 'status'.tr, right: 'pending'.tr, isStatus: true),
          _buildRow(left: '123CTF-0001', right: '01-Jun-2025'),
          _buildRow(left: 'payment_method'.tr, right: 'Cash on delivery'),
          _buildRow(left: 'total_items'.tr, right: '10'),
          _buildRow(left: 'delivery_fee'.tr, right: '0\$'),
          _buildRow(left: 'total_discount'.tr, right: '0\$'),
          _buildRow(left: 'total_amount'.tr, right: '10.00\$'),
        ],
      ),
    );
  }

  Row _buildRow({
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
              color: getOrderColorStatus(orderStatus),
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
