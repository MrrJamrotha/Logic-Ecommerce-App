import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/order_model.dart';
import 'package:foxShop/presentation/screens/order_detail/order_detail_screen.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class OrderCardWidget extends StatelessWidget {
  const OrderCardWidget({
    super.key,
    required this.orderStatus,
    required this.record,
  });
  final OrderStatus orderStatus;
  final OrderModel record;

  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      onTap: () {
        Navigator.pushNamed(context, OrderDetailScreen.routeName, arguments: {
          'id': record.id,
        });
      },
      borderRadius: BorderRadius.circular(appRadius.scale),
      padding: EdgeInsets.all(10.scale),
      child: Column(
        spacing: appSpace.scale,
        children: [
          _buildRow(
            left: 'status'.tr,
            right: record.orderStatus,
            isStatus: true,
          ),
          _buildRow(left: record.documentCode, right: record.orderDate),
          _buildRow(
            left: 'payment_method'.tr,
            right: record.paymentMethodModel.name,
          ),
          _buildRow(left: 'total_items'.tr, right: record.orderLinesCount),
          _buildRow(left: 'delivery_fee'.tr, right: record.deliveryFee),
          _buildRow(left: 'total_discount'.tr, right: record.totalDiscount),
          _buildRow(left: 'total_amount'.tr, right: record.totalAmount),
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
