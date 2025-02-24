import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/data/models/product_model.dart';
import 'package:logic_app/presentation/screens/item_detail/item_detail_screen.dart';
import 'package:logic_app/presentation/widgets/product_card_widget.dart';

class ListProductHorizontalWidget extends StatelessWidget {
  const ListProductHorizontalWidget({
    super.key,
    required this.records,
    required this.isLoading,
  });
  final List<ProductModel> records;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 210.scale,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: appSpace.scale),
        scrollDirection: Axis.horizontal,
        itemCount: records.length,
        itemBuilder: (context, index) {
          final record = records[index];
          return Padding(
            padding: EdgeInsets.only(right: appSpace.scale),
            child: ProductCardWidget(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  ItemDetailScreen.routeName,
                  arguments: {
                    'product_id': record.id,
                    'merchant_id': record.merchantId,
                    'category_id': record.categoryId,
                    'brand_id': record.brandId,
                  },
                );
              },
              record: record,
              isLoading: isLoading,
            ),
          );
        },
      ),
    );
  }
}
