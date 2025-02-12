import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSliderWidget extends StatefulWidget {
  const CarouselSliderWidget({
    super.key,
    required this.records,
    required this.isLoading,
  });
  final List<dynamic> records;
  final bool isLoading;
  @override
  State<CarouselSliderWidget> createState() => _CarouselSliderWidgetState();
}

class _CarouselSliderWidgetState extends State<CarouselSliderWidget> {
  final _activeIndex = ValueNotifier<int>(0);
  @override
  Widget build(BuildContext context) {
    if (widget.isLoading) {
      return SizedBox.shrink();
    }

    if (widget.records.isEmpty) {
      return SizedBox.shrink();
    }
    return Column(
      spacing: 16.scale,
      children: [
        CarouselSlider.builder(
          itemCount: widget.records.length,
          itemBuilder: (context, index, realIndex) {
            final record = widget.records[index];
            return CatchImageNetworkWidget(
              boxFit: BoxFit.cover,
              height: 260.scale,
              width: double.infinity,
              imageUrl: record.picture,
              blurHash: record.pictureHash,
            );
          },
          options: CarouselOptions(
            height: 260.scale,
            aspectRatio: 16 / 9,
            viewportFraction: 1,
            initialPage: 0,
            enableInfiniteScroll: true,
            reverse: false,
            autoPlay: true,
            autoPlayInterval: Duration(seconds: 15),
            autoPlayAnimationDuration: Duration(seconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0,
            onPageChanged: (index, reason) {
              _activeIndex.value = index;
            },
            scrollDirection: Axis.horizontal,
          ),
        ),
        ValueListenableBuilder(
          valueListenable: _activeIndex,
          builder: (context, value, child) {
            return AnimatedSmoothIndicator(
              activeIndex: value,
              count: widget.records.length,
              effect: WormEffect(
                dotHeight: 5.scale,
                dotWidth: 20.scale,
                activeDotColor: primary,
              ),
            );
          },
        ),
      ],
    );
  }
}
