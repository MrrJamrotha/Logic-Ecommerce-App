import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/order_card_widget.dart';

class DeliveryTabScreen extends StatefulWidget {
  const DeliveryTabScreen({super.key});

  @override
  State<DeliveryTabScreen> createState() => _DeliveryTabScreenState();
}

class _DeliveryTabScreenState extends State<DeliveryTabScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(appPedding.scale),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: appSpace.scale),
          child: OrderCardWidget(
            orderStatus: OrderStatus.delivery,
          ),
        );
      },
    );
  }
}
