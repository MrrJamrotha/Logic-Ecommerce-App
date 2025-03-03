import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/order/order_cubit.dart';
import 'package:foxShop/presentation/screens/order/tabs/complete_tab_screen.dart';
import 'package:foxShop/presentation/screens/order/tabs/delivery_tab_screen.dart';
import 'package:foxShop/presentation/screens/order/tabs/pending_tab_screen.dart';
import 'package:foxShop/presentation/screens/order/tabs/processing_tab_screen.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});
  static const routeName = 'order';
  static const routePath = '/order';

  @override
  OrderScreenState createState() => OrderScreenState();
}

class OrderScreenState extends State<OrderScreen> {
  final screenCubit = OrderCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          appBar: AppbarWidget(
            isBottom: true,
            title: 'orders'.tr,
            bottom: TabBar(
              indicatorColor: primary,
              unselectedLabelColor: appBlack,
              labelColor: primary,
              tabs: [
                Tab(text: 'pending'.tr),
                Tab(text: 'processing'.tr),
                Tab(text: 'delivery'.tr),
                Tab(text: 'completed'.tr),
              ],
            ),
          ),
          body: TabBarView(
            physics: NeverScrollableScrollPhysics(),
            children: [
              PendingTabScreen(),
              ProcessingTabScreen(),
              DeliveryTabScreen(),
              CompleteTabScreen()
            ],
          ),
        ));
  }
}
