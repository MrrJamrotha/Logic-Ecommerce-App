import 'package:flutter/material.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class RenderAssetEntityImageWidget extends StatelessWidget {
  const RenderAssetEntityImageWidget({super.key, required this.entity});
  final AssetEntity entity;
  @override
  Widget build(BuildContext context) {
    return AssetEntityImage(
      width: 150.scale,
      height: 180.scale,
      entity,
      isOriginal: false,
      thumbnailSize: const ThumbnailSize.square(250),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.error,
            size: 24.scale,
          ),
        );
      },
    );
  }
}
