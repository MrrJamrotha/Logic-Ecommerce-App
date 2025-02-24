import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/brand/brand_cubit.dart';
import 'package:logic_app/presentation/screens/brand/brand_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/card_brand_widget.dart';

class BrandScreen extends StatefulWidget {
  static const routeName = 'brand_screen';
  const BrandScreen({super.key});

  @override
  BrandScreenState createState() => BrandScreenState();
}

class BrandScreenState extends State<BrandScreen> {
  final screenCubit = BrandCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'popular_brands'.tr),
      body: BlocBuilder<BrandCubit, BrandState>(
        bloc: screenCubit,
        builder: (BuildContext context, BrandState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(BrandState state) {
    final records = state.records ?? [];
    final double width = AppSizeConfig.screenWidth;
    double widthCard = 130.scale;
    int countRow = width ~/ widthCard;
    return MasonryGridView.count(
      padding: EdgeInsets.all(appPedding.scale),
      crossAxisSpacing: appSpace.scale,
      mainAxisSpacing: appSpace.scale,
      itemCount: records.length,
      crossAxisCount: countRow,
      itemBuilder: (context, index) {
        final record = records[index];
        return CardBrandWidget(
          picture: record.picture,
          pictureHash: record.pictureHash,
          title: record.name,
        );
      },
    );
  }
}
