import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class CardUserReview extends StatelessWidget {
  const CardUserReview({super.key, required this.pictures});
  final List<dynamic> pictures;
  @override
  Widget build(BuildContext context) {
    return BoxWidget(
      borderRadius: BorderRadius.circular(appRadius.scale),
      padding: EdgeInsets.all(appSpace.scale),
      child: Column(
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
                imageUrl:
                    'https://t3.ftcdn.net/jpg/02/73/71/46/360_F_273714684_GXTZHmfFM3yvZwP7KaGc1h2Md00F83UF.jpg',
                blurHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(
                    text: maskText('Soeurn Rotha'),
                    fontWeight: FontWeight.w600,
                    fontSize: 14.scale,
                  ),
                  RatingBarIndicator(
                    rating: 3.5,
                    itemSize: 10.scale,
                    itemBuilder: (context, index) => Icon(
                      Icons.star,
                      color: appYellow,
                    ),
                  ),
                  TextWidget(
                    text: '19-01-2025',
                    fontSize: 12.scale,
                    color: textColor,
                  )
                ],
              )
            ],
          ),
          TextWidget(
            text:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It ",
            fontSize: 12.scale,
            color: textColor,
          ),
          if (pictures.isNotEmpty)
            SizedBox(
              height: 120.scale,
              child: ListView.builder(
                padding: EdgeInsets.symmetric(
                  vertical: appPedding.scale,
                ),
                // shrinkWrap: true,
                // physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: pictures.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: appSpace.scale),
                    child: CatchImageNetworkWidget(
                      borderRadius: BorderRadius.circular(appRadius.scale),
                      width: 70.scale,
                      height: 70.scale,
                      boxFit: BoxFit.cover,
                      imageUrl: pictures[index]['picture'],
                      blurHash: pictures[index]['pictureHash'],
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
