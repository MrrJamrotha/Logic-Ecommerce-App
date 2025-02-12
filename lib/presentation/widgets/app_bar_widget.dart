import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    this.isSearch = false,
    this.isBack = false,
    required this.title,
    this.onBackPress,
  });
  final bool isSearch;
  final String title;
  final bool isBack;

  final Function()? onBackPress;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: isBack
          ? IconButton(
              onPressed: onBackPress,
              icon: IconWidget(
                assetName: arrowLeftSvg,
                width: 24.scale,
                height: 24.scale,
              ),
            )
          : null,
      centerTitle: false,
      title: TextWidget(
        text: title,
      ),
      actions: [
        if (isSearch)
          IconButton(
            onPressed: () {
              //TODO:
              // context.goNamed(ChatRoomScreen.routeName);
            },
            icon: IconWidget(
              assetName: searchSvg,
              width: 24.scale,
              height: 24.scale,
            ),
          ),
        IconButton(
          onPressed: () {
            // context.goNamed(ChatRoomScreen.routeName);
          },
          icon: Badge.count(
            count: 10,
            child: IconWidget(
              assetName: notificationSvg,
              width: 24.scale,
              height: 24.scale,
            ),
          ),
        ),
      ],
    );
  }
}
