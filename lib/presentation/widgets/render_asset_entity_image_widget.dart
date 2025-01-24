import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:photo_manager_image_provider/photo_manager_image_provider.dart';

class RenderAssetEntityImageWidget extends StatelessWidget {
  const RenderAssetEntityImageWidget({super.key, required this.entity});
  final AssetEntity entity;
  @override
  Widget build(BuildContext context) {
    return AssetEntityImage(
      width: 150.w,
      height: 150.h,
      entity,
      isOriginal: false,
      thumbnailSize: const ThumbnailSize.square(250),
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Center(
          child: Icon(
            Icons.error,
            size: 24.sp,
          ),
        );
      },
    );
  }
}
