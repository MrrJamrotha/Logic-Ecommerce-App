import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:foxShop/data/models/picture_model.dart';

class PhotoGalleryScreen extends StatefulWidget {
  const PhotoGalleryScreen({
    super.key,
    required this.pictures,
    required this.initialIndex,
  });
  static const routeName = 'photo_gallery';
  final List<PictureModel> pictures;
  final int initialIndex;
  @override
  State<PhotoGalleryScreen> createState() => _PhotoGalleryScreenState();
}

class _PhotoGalleryScreenState extends State<PhotoGalleryScreen> {
  final _currentIndex = ValueNotifier(0);

  @override
  void initState() {
    _currentIndex.value = widget.initialIndex;
    super.initState();
  }

  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.black,
      appBar: AppBar(
        // backgroundColor: Colors.black,
        centerTitle: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Navigator.pop(context),
        ),

        title: TextWidget(text: 'preview_image'.tr),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.pictures.length,
            pageController: PageController(initialPage: widget.initialIndex),
            loadingBuilder: (context, event) => centerLoading(),
            builder: (context, index) {
              final picture = widget.pictures[index];
              return PhotoViewGalleryPageOptions(
                imageProvider: NetworkImage(picture.picture),
                initialScale: PhotoViewComputedScale.contained * 0.8,
                heroAttributes: PhotoViewHeroAttributes(tag: picture.id),
              );
            },
            pageSnapping: true,
            onPageChanged: onPageChanged,
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(
              color: Colors.black,
            ),
          ),
          Positioned(
            // left: 0,
            // right: 0,
            bottom: appPedding.scale,
            child: ValueListenableBuilder(
              valueListenable: _currentIndex,
              builder: (context, currentIndex, child) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: appPedding.scale,
                    vertical: appSpace.scale,
                  ),
                  decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(appRadius.scale),
                  ),
                  child: Text(
                    "${currentIndex + 1}/${widget.pictures.length}",
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17.0,
                      decoration: null,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
