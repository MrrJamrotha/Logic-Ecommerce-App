import 'package:flutter/material.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/notification/notification_screen.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({
    super.key,
    this.isSearch = false,
    this.isBack = false,
    required this.title,
    this.onBackPress,
    this.bottom,
    this.isBottom = false,
    this.isNotification = true,
    this.isFilter = false,
    this.onTapFilter,
  });
  final bool isSearch;
  final String title;
  final bool isBack;

  final Function()? onBackPress;
  final PreferredSizeWidget? bottom;
  final bool isBottom;
  final bool isNotification;
  final bool isFilter;
  final Function()? onTapFilter;
  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight + (isBottom ? 50.scale : 0));

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appWhite,
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
      bottom: bottom,
      actions: [
        if (isSearch)
          IconButton(
            onPressed: () {
              //TODO:
            },
            icon: IconWidget(
              assetName: searchSvg,
              width: 24.scale,
              height: 24.scale,
            ),
          ),
        if (isFilter)
          IconButton(
            onPressed: onTapFilter,
            icon: IconWidget(
              assetName: filterSvg,
              width: 24.scale,
              height: 24.scale,
            ),
          ),
        if (isNotification)
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, NotificationScreen.routeName);
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
