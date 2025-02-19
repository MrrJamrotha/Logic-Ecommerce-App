import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ErrorTypeWidget extends StatelessWidget {
  const ErrorTypeWidget({super.key, required this.type});
  final ErrorType type;
  @override
  Widget build(BuildContext context) {
    String name = "";
    String text = "";
    switch (type) {
      case ErrorType.empty:
        name = emptyImg;
        text = "empty_record";
        break;
      case ErrorType.notFound:
        name = notfoundImg;
        text = "page_not_found";
        break;
      case ErrorType.serverError:
        name = errorServerImg;
        text = "someting_want_wrong";
        break;
    }
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: appPedding.scale,
          children: [
            Image.asset(
              name,
              width: 200.scale,
              height: 200.scale,
            ),
            TextWidget(
              text: text.tr,
              fontSize: 18.scale,
              fontWeight: FontWeight.w700,
            ),
          ],
        ),
      ),
    );
  }
}
