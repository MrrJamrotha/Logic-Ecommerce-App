import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class LocationMessageBubble extends StatelessWidget {
  const LocationMessageBubble({
    super.key,
    required this.lat,
    required this.long,
    required this.timestamp,
    required this.isRead,
    required this.type,
  });
  final double lat;
  final double long;
  final String timestamp;
  final bool isRead;
  final BubbleType type;

  String get _constructUrl => Uri(
        scheme: 'https',
        host: 'maps.googleapis.com',
        port: 443,
        path: '/maps/api/staticmap',
        queryParameters: {
          'center': '$lat,$long',
          'zoom': '19',
          'size': '700x500',
          'maptype': 'roadmap',
          'key': dotenv.env['GOOGLE_MAP_KEY'].toString(),
          'markers': 'color:red|$lat,$long'
        },
      ).toString();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2.scale),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color:
            type == BubbleType.sendBubble ? primary : appGrey.withOpacity(0.2),
      ),
      child: Stack(
        children: [
          CatchImageNetworkWidget(
            borderRadius: BorderRadius.circular(5),
            height: 300.0.scale,
            width: 600.0.scale,
            imageUrl: _constructUrl,
            boxFit: BoxFit.cover,
            blurHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
          ),
          Positioned(
            bottom: 5.scale,
            right: 5.scale,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 5.scale),
              decoration: BoxDecoration(
                color: Color.fromARGB(107, 30, 30, 30),
                borderRadius: BorderRadius.circular(20.scale),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5.scale,
                children: [
                  TextWidget(
                    text: timestamp,
                    color: appWhite,
                  ),
                  IconWidget(
                    assetName: isRead ? checkReadSvg : checkSvg,
                    colorFilter: ColorFilter.mode(
                      appWhite,
                      BlendMode.srcIn,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
