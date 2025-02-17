import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/category/category_cubit.dart';
import 'package:logic_app/presentation/screens/category/category_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/card_category_widget.dart';

class CategoryScreen extends StatefulWidget {
  static const routeName = 'category_screen';
  static const routePath = '/category_screen';
  const CategoryScreen({super.key});

  @override
  CategoryScreenState createState() => CategoryScreenState();
}

class CategoryScreenState extends State<CategoryScreen> {
  final screenCubit = CategoryCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'categories'.tr),
      body: BlocBuilder<CategoryCubit, CategoryState>(
        bloc: screenCubit,
        builder: (BuildContext context, CategoryState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(CategoryState state) {
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
        return CardCategoryWidget(
          picture: record.picture,
          pictureHash: record.pictureHash,
          title: record.name,
        );
      },
    );
  }
}
