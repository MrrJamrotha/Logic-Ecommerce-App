import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/order_card_widget.dart';

class CompleteTabScreen extends StatefulWidget {
  const CompleteTabScreen({super.key});

  @override
  State<CompleteTabScreen> createState() => _CompleteTabScreenState();
}

class _CompleteTabScreenState extends State<CompleteTabScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.all(appPedding.scale),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(bottom: appSpace.scale),
          child: OrderCardWidget(
            orderStatus: OrderStatus.completed,
          ),
        );
      },
    );
  }
}
