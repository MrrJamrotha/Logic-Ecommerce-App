import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/card_brand_widget.dart';

class ListCategoryAndBrandWidget extends StatelessWidget {
  const ListCategoryAndBrandWidget({super.key, required this.records});
  final List<dynamic> records;
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
