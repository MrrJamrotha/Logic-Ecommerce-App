import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/data/models/order_model.dart';
import 'package:foxShop/presentation/screens/order/order_cubit.dart';
import 'package:foxShop/presentation/screens/order/order_state.dart';
import 'package:foxShop/presentation/widgets/order_card_widget.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PendingTabScreen extends StatefulWidget {
  const PendingTabScreen({super.key});

  @override
  State<PendingTabScreen> createState() => _PendingTabScreenState();
}

class _PendingTabScreenState extends State<PendingTabScreen> {
  final screenCubit = OrderCubit();

  @override
  void initState() {
    screenCubit.loadInitialData(parameters: {'status': 'Pending'});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrderCubit, OrderState>(
      bloc: screenCubit,
      builder: (context, state) {
        if (state.isLoading) {
          return centerLoading();
        }

        return PagedListView.separated(
          padding: EdgeInsets.all(appPedding.scale),
          pagingController: screenCubit.pagingController,
          separatorBuilder: (context, index) =>
              SizedBox(height: appPedding.scale),
          builderDelegate: PagedChildBuilderDelegate<OrderModel>(
            itemBuilder: (context, item, index) {
              return OrderCardWidget(
                record: item,
                orderStatus: OrderStatus.pending,
              );
            },
            firstPageProgressIndicatorBuilder: (_) => centerLoading(),
            newPageProgressIndicatorBuilder: (_) => centerLoading(),
            noItemsFoundIndicatorBuilder: (_) => centerText(),
          ),
        );
      },
    );
  }
}
