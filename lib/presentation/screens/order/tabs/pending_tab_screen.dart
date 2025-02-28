import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/widgets/order_card_widget.dart';

class PendingTabScreen extends StatefulWidget {
  const PendingTabScreen({super.key});

  @override
  State<PendingTabScreen> createState() => _PendingTabScreenState();
}

class _PendingTabScreenState extends State<PendingTabScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(appPedding.scale),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: appSpace.scale),
          child: OrderCardWidget(
            orderStatus: OrderStatus.pending,
          ),
        );
      },
    );
  }
}
