import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/render_asset_entity_image_widget.dart';
import 'package:photo_manager/photo_manager.dart';

class AlbmusImageGrid extends StatelessWidget {
  const AlbmusImageGrid({
    super.key,
    this.scrollController,
    required this.records,
    this.onTap,
  });
  final ScrollController? scrollController;
  final List<AssetEntity> records;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return MasonryGridView.count(
      padding: EdgeInsets.all(5.scale),
      controller: scrollController,
      shrinkWrap: true,
      itemCount: records.length + 1,
      crossAxisCount: 3,
      mainAxisSpacing: 5.scale,
      crossAxisSpacing: 5.scale,
      itemBuilder: (context, index) {
        if (index == 0) {
          return GestureDetector(
            child: SizedBox(
              width: 150.scale,
              height: 180.scale,
              child: Icon(Icons.camera),
            ),
          );
        }
        return GestureDetector(
          onTap: onTap,
          child: RenderAssetEntityImageWidget(
            entity: records[index - 1],
          ),
        );
      },
    );
  }
}
