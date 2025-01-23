import 'package:flutter/material.dart';

class AppbarWidget extends StatelessWidget implements PreferredSizeWidget {
  const AppbarWidget({super.key});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: Text('Logic'),
      actions: [
        IconButton(
          onPressed: () {
            //TODO:
          },
          icon: Icon(Icons.chat),
        ),
        IconButton(
          onPressed: () {
            //TODO:
          },
          icon: Icon(Icons.notifications),
        ),
        // IconButton(
        //   onPressed: () {
        //     //TODO:
        //   },
        //   icon: Icon(Icons),
        // ),
      ],
    );
  }
}
