import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/presentation/screens/camera/take_picture_screen.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_screen.dart';
import 'package:logic_app/presentation/screens/chat_room/components/preview_image.dart';
import 'package:logic_app/presentation/screens/main_screen.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:photo_manager/photo_manager.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
      name: OnboardingScreen.routeName,
      path: '/',
      builder: (context, state) {
        return OnboardingScreen();
      },
      routes: [
        GoRoute(
          path: MainScreen.routePath,
          builder: (context, state) {
            return MainScreen();
          },
          routes: [
            //item detail
            GoRoute(
              name: TakePictureScreen.routeName,
              path: '/take_picture_screen',
              // builder: (context, state) {
              //   final cameraName = state.extra! as CameraDescription;
              //   return TakePictureScreen(camera: cameraName);
              // },
              pageBuilder: (context, state) {
                final cameraName = state.extra! as CameraDescription;
                return CustomTransitionPage(
                  child: TakePictureScreen(camera: cameraName),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
            ),
            GoRoute(
              name: ChatRoomScreen.routeName,
              path: '/chat-room',
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: ChatRoomScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
              routes: [
                GoRoute(
                  name: PreviewImage.routeName,
                  path: '/preview-image',
                  pageBuilder: (context, state) {
                    final records = state.extra! as List<AssetEntity>;
                    return CustomTransitionPage(
                      child: PreviewImage(records: records),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ]),
]);
