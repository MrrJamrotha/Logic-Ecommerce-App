import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/order/order_cubit.dart';
import 'package:logic_app/presentation/screens/order/order_state.dart';
import 'package:logic_app/presentation/screens/order/tabs/complete_tab_screen.dart';
import 'package:logic_app/presentation/screens/order/tabs/delivery_tab_screen.dart';
import 'package:logic_app/presentation/screens/order/tabs/pending_tab_screen.dart';
import 'package:logic_app/presentation/screens/order/tabs/processing_tab_screen.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';

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
        body: BlocConsumer<OrderCubit, OrderState>(
          bloc: screenCubit,
          listener: (BuildContext context, OrderState state) {
            if (state.error != null) {
              // TODO your code here
            }
          },
          builder: (BuildContext context, OrderState state) {
            if (state.isLoading) {
              return Center(child: CircularProgressIndicator());
            }

            return buildBody(state);
          },
        ),
      ),
    );
  }

  Widget buildBody(OrderState state) {
    return TabBarView(
      physics: NeverScrollableScrollPhysics(),
      children: [
        PendingTabScreen(),
        ProcessingTabScreen(),
        DeliveryTabScreen(),
        CompleteTabScreen()
      ],
    );
  }
}
