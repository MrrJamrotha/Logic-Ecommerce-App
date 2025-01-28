import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';

class CatchImageNetworkWidget extends StatelessWidget {
  const CatchImageNetworkWidget({
    super.key,
    required this.imageUrl,
    required this.blurHash,
    this.boxFit = BoxFit.contain,
  });
  final String imageUrl;
  final String blurHash;
  final BoxFit? boxFit;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: boxFit,
      filterQuality: FilterQuality.high,
      imageBuilder: (context, imageProvider) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider),
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
