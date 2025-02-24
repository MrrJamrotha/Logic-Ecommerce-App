import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/product_by_brand/product_by_brand_screen.dart';
import 'package:logic_app/presentation/screens/product_by_category/product_by_category_screen.dart';
import 'package:logic_app/presentation/widgets/card_brand_widget.dart';

class ListCategoryAndBrandWidget extends StatelessWidget {
  const ListCategoryAndBrandWidget({
    super.key,
    required this.records,
    required this.listProductType,
  });
  final List<dynamic> records;
  final ListProductType listProductType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 125.scale,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Padding(
            padding: EdgeInsets.only(
              right: appSpace.scale,
              bottom: appSpace.scale,
              top: appSpace.scale,
            ),
            child: CardBrandWidget(
              onTap: () {
                Navigator.pushNamed(
                    context,
                    listProductType == ListProductType.category
                        ? ProductByCategoryScreen.routeName
                        : ProductByBrandScreen.routeName,
                    arguments: {
                      'title': record.name,
                      'category_id': record.id,
                      'brand_id': record.id,
                    });
              },
              picture: record.picture,
              pictureHash: record.pictureHash,
              title: record.name,
            ),
          );
        },
      ),
    );
  }
}
