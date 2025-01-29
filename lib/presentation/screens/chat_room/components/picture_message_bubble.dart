import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class PictureMessageBubble extends StatelessWidget {
  const PictureMessageBubble({
    super.key,
    required this.records,
    required this.type,
    required this.isRead,
    required this.timestamp,
  });
  final List<dynamic> records;
  final BubbleType type;
  final bool isRead;
  final String timestamp;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.scale),
      decoration: BoxDecoration(
        color:
            type == BubbleType.sendBubble ? primary : appGrey.withOpacity(0.2),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Stack(
        children: [
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverQuiltedGridDelegate(
              crossAxisCount: 4, // Number of columns
              mainAxisSpacing: 4,
              crossAxisSpacing: 4,
              repeatPattern: QuiltedGridRepeatPattern.inverted,
              pattern: _generatePattern(records.length),
            ),
            itemCount: records.length,
            itemBuilder: (context, index) {
              return CatchImageNetworkWidget(
                imageUrl: records[index]['imageUrl'],
                blurHash: records[index]['blurHash'],
                boxFit: BoxFit.cover,
                borderRadius: BorderRadius.circular(4.scale),
              );
            },
          ),
          Positioned(
            bottom: 5.scale,
            right: 5.scale,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.scale),
              decoration: BoxDecoration(
                color: Color.fromARGB(107, 30, 30, 30),
                borderRadius: BorderRadius.circular(20.scale),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5.scale,
                children: [
                  TextWidget(
                    text: timestamp,
                    color: appWhite,
                  ),
                  IconWidget(
                    assetName: isRead ? checkReadSvg : checkSvg,
                    colorFilter: ColorFilter.mode(
                      appWhite,
                      BlendMode.srcIn,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<QuiltedGridTile> _generatePattern(int itemCount) {
    List<QuiltedGridTile> pattern = [];

    if (itemCount == 1) {
      pattern.add(QuiltedGridTile(3, 4));
    } else if (itemCount % 2 == 0) {
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 1));
    } else if (itemCount % 3 == 0) {
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(2, 4));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 1));
    } else if (itemCount % 4 == 0) {
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 2));
    } else if (itemCount % 5 == 0) {
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 2));
      //add from item count ==1
      pattern.add(QuiltedGridTile(3, 4));
    } else if (itemCount % 7 == 0) {
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 2));
      //add from item count ==3
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(2, 4));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 1));
    } else {
      pattern.add(QuiltedGridTile(2, 2));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 1));
      pattern.add(QuiltedGridTile(1, 2));
    }

    pattern = pattern.take(itemCount).toList();

    return pattern;
  }
}
