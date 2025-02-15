import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_global_key.dart';
import 'package:logic_app/presentation/global/application/application_cubit.dart';
import 'package:logic_app/presentation/screens/address/address_screen.dart';
import 'package:logic_app/presentation/screens/camera/take_picture_screen.dart';
import 'package:logic_app/presentation/screens/chat_room/chat_room_screen.dart';
import 'package:logic_app/presentation/screens/chat_room/components/preview_image.dart';
import 'package:logic_app/presentation/screens/create_address/create_address_screen.dart';
import 'package:logic_app/presentation/screens/cubit/currency_screen.dart';
import 'package:logic_app/presentation/screens/language/language_screen.dart';
import 'package:logic_app/presentation/screens/main_screen.dart';
import 'package:logic_app/presentation/screens/not_found/not_found_screen.dart';
import 'package:logic_app/presentation/screens/notification/notification_screen.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_screen.dart';
import 'package:logic_app/presentation/screens/order/order_screen.dart';
import 'package:logic_app/presentation/screens/order_detail/order_detail_screen.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_screen.dart';
import 'package:logic_app/presentation/screens/write_review/write_review_screen.dart';
import 'package:photo_manager/photo_manager.dart';

class MainRouter {
  static GoRouter createRouter(BuildContext context) {
    return GoRouter(
      initialLocation: context.read<ApplicationCubit>().state.onBoarding
          ? MainScreen.routePath
          : OnboardingScreen.routePath,
      navigatorKey: rootNavigatorKey,
      routes: [
        GoRoute(
          name: OnboardingScreen.routeName,
          path: OnboardingScreen.routePath,
          builder: (context, state) => OnboardingScreen(),
        ),
        GoRoute(
          path: MainScreen.routePath,
          builder: (context, state) => MainScreen(),
          routes: [
            GoRoute(
              name: TakePictureScreen.routeName,
              path: '/take_picture_screen',
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
              pageBuilder: (context, state) => CustomTransitionPage(
                child: ChatRoomScreen(),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return FadeTransition(opacity: animation, child: child);
                },
              ),
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
            GoRoute(
              path: AddressScreen.routePath,
              name: AddressScreen.routeName,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: AddressScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
              routes: [
                GoRoute(
                  path: CreateAddressScreen.routePath,
                  name: CreateAddressScreen.routeName,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      child: CreateAddressScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    );
                  },
                ),
                GoRoute(
                  path: UpdateAddressScreen.routePath,
                  name: UpdateAddressScreen.routeName,
                  pageBuilder: (context, state) {
                    return CustomTransitionPage(
                      child: UpdateAddressScreen(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(opacity: animation, child: child);
                      },
                    );
                  },
                )
              ],
            ),
            GoRoute(
              path: OrderScreen.routePath,
              name: OrderScreen.routeName,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: OrderScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
              routes: [
                GoRoute(
                    path: OrderDetailScreen.routePath,
                    name: OrderDetailScreen.routeName,
                    pageBuilder: (context, state) => CustomTransitionPage(
                          child: OrderDetailScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                    routes: [
                      GoRoute(
                        path: WriteReviewScreen.routePath,
                        name: WriteReviewScreen.routeName,
                        pageBuilder: (context, state) => CustomTransitionPage(
                          child: WriteReviewScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                              opacity: animation,
                              child: child,
                            );
                          },
                        ),
                      )
                    ]),
              ],
            ),
            GoRoute(
              path: NotificationScreen.routePath,
              name: NotificationScreen.routeName,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: NotificationScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
            ),
            GoRoute(
              path: LanguageScreen.routePath,
              name: LanguageScreen.routeName,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: LanguageScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
            ),
            GoRoute(
              path: CurrencyScreen.routePath,
              name: CurrencyScreen.routeName,
              pageBuilder: (context, state) {
                return CustomTransitionPage(
                  child: CurrencyScreen(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                );
              },
            )
          ],
        ),
      ],
      errorBuilder: (context, state) => NotFoundScreen(),
    );
  }
}
