import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:logic_app/core/di/injection.dart';

class CatchImageNetworkWidget extends StatelessWidget {
  const CatchImageNetworkWidget({
    super.key,
    required this.imageUrl,
    required this.blurHash,
    this.boxFit = BoxFit.contain,
    this.width,
    this.height,
    this.borderRadius,
  });
  final String imageUrl;
  final String blurHash;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final BorderRadiusGeometry? borderRadius;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      cacheManager: di.get<BaseCacheManager>(),
      imageUrl: imageUrl,
      fit: boxFit,
      width: width,
      height: height,
      filterQuality: FilterQuality.high,
      imageBuilder: (context, imageProvider) {
        return Container(
          width: height,
          height: width,
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            image: DecorationImage(
              image: imageProvider,
              fit: boxFit,
              filterQuality: FilterQuality.high,
            ),
          ),
        );
      },
      placeholder: (context, url) {
        return BlurHash(hash: blurHash);
      },
      errorWidget: (context, url, error) {
        return Text('Error loading image');
      },
    );
  }
}
