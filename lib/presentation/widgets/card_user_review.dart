import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/utils/app_format.dart';
import 'package:foxShop/data/models/review_model.dart';
import 'package:foxShop/presentation/screens/photo_gallery/photo_gallery_screen.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/rating_bar_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CardUserReview extends StatelessWidget {
  const CardUserReview({
    super.key,
    required this.record,
  });
  final ReviewModel record;
  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      borderRadius: BorderRadius.circular(appRadius.scale),
      padding: EdgeInsets.all(appSpace.scale),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: appSpace.scale,
            children: [
              CatchImageNetworkWidget(
                width: 50.scale,
                height: 50.scale,
                borderRadius: BorderRadius.circular(100.scale),
                boxFit: BoxFit.cover,
                imageUrl: record.avatar,
                blurHash: record.avatarHash,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: maskText(record.username),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.scale,
                  ),
                  RatingBarWidget(
                    rating: AppFormat.toDouble(record.totalStar),
                    itemSize: 10.scale,
                  ),
                  TextWidget(
                    text: record.date,
                    fontSize: 12.scale,
                    color: textColor,
                  )
                ],
              )
            ],
          ),
          TextWidget(
            textAlign: TextAlign.left,
            text: record.comment,
            fontSize: 12.scale,
            color: textColor,
          ),
          if (record.pictures.isNotEmpty)
            SizedBox(
              height: 120.scale,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(
                  vertical: appPedding.scale,
                ),
                scrollDirection: Axis.horizontal,
                itemCount: record.pictures.length,
                separatorBuilder: (context, index) => SizedBox(
                  width: appSpace.scale,
                ),
                itemBuilder: (context, index) {
                  final pictures = record.pictures[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, PhotoGalleryScreen.routeName,
                          arguments: {
                            'pictures': record.pictures,
                            'initialIndex': index,
                          });
                    },
                    child: CatchImageNetworkWidget(
                      borderRadius: BorderRadius.circular(appRadius.scale),
                      width: 70.scale,
                      height: 70.scale,
                      boxFit: BoxFit.cover,
                      imageUrl: pictures.picture,
                      blurHash: pictures.pictureHash,
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
