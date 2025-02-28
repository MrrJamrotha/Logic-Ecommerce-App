import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:foxShop/core/constants/app_colors.dart';

class RatingBarWidget extends StatelessWidget {
  const RatingBarWidget({
    super.key,
    this.itemSize = 40,
    this.rating = 4.0,
  });
  final double itemSize;
  final double rating;
  @override
  Widget build(BuildContext context) {
    return RatingBarIndicator(
      itemSize: itemSize,
      rating: rating,
      unratedColor: unratedColor,
      itemBuilder: (context, index) => Icon(
        Icons.star,
        color: appYellow,
      ),
    );
  }
}
