import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/chat_room/components/text_message_clipper.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class TextMessageBubble extends StatelessWidget {
  const TextMessageBubble({
    super.key,
    required this.message,
    required this.type,
    required this.isRead,
    required this.timestamp,
  });
  final String message;
  final BubbleType type;
  final bool isRead;
  final String timestamp;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: type == BubbleType.sendBubble
          ? Alignment.topRight
          : Alignment.topLeft,
      child: PhysicalShape(
        clipper: TextMessageClipper(type: type),
        color:
            type == BubbleType.sendBubble ? primary : appGrey.withOpacity(0.3),
        shadowColor: Colors.grey.shade200,
        child: Padding(
          padding: type == BubbleType.sendBubble
              ? EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 20)
              : EdgeInsets.only(top: 10, bottom: 10, left: 20, right: 10),
          child: Column(
            children: [
              TextWidget(
                text: message,
                color: type == BubbleType.sendBubble ? appWhite : appBlack,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                spacing: 5.scale,
                children: [
                  TextWidget(
                    text: timestamp,
                    color: type == BubbleType.sendBubble ? appWhite : appBlack,
                  ),
                  IconWidget(
                    assetName: checkReadSvg,
                    colorFilter: ColorFilter.mode(
                      type == BubbleType.sendBubble ? appWhite : appBlack,
                      BlendMode.srcIn,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
