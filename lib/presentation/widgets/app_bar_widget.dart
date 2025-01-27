import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_screen.dart';

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
            context.goNamed(ChatRoomScreen.routeName);
          },
          icon: Icon(Icons.chat),
        ),
        IconButton(
          onPressed: () {
            // context.goNamed(ChatRoomScreen.routeName);
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
