import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_global_key.dart';
import 'package:logic_app/presentation/screens/address/address_screen.dart';
import 'package:logic_app/presentation/screens/auth/login/login_screen.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_screen.dart';
import 'package:logic_app/presentation/screens/brand/brand_screen.dart';
import 'package:logic_app/presentation/screens/cart/cart_screen.dart';
import 'package:logic_app/presentation/screens/category/category_screen.dart';
import 'package:logic_app/presentation/screens/check_out/check_out_screen.dart';
import 'package:logic_app/presentation/screens/create_address/create_address_screen.dart';
import 'package:logic_app/presentation/screens/cubit/currency_screen.dart';
import 'package:logic_app/presentation/screens/fetching_items/fetching_items_screen.dart';
import 'package:logic_app/presentation/screens/home/home_screen.dart';
import 'package:logic_app/presentation/screens/item_detail/item_detail_screen.dart';
import 'package:logic_app/presentation/screens/language/language_screen.dart';
import 'package:logic_app/presentation/screens/main_screen.dart';
import 'package:logic_app/presentation/screens/merchant_profile/merchant_profile_screen.dart';
import 'package:logic_app/presentation/screens/order/order_screen.dart';
import 'package:logic_app/presentation/screens/order_detail/order_detail_screen.dart';
import 'package:logic_app/presentation/screens/profile/profile_screen.dart';
import 'package:logic_app/presentation/screens/review_product/review_product_screen.dart';
import 'package:logic_app/presentation/screens/update_address/update_address_screen.dart';
import 'package:logic_app/presentation/screens/write_review/write_review_screen.dart';
import 'package:logic_app/presentation/widgets/error_type_widget.dart';

class MainRouter {
  static GoRouter createRouter(BuildContext context) {
    return GoRouter(
      initialLocation: HomeScreen.routePath,
      navigatorKey: rootNavigatorKey,
      debugLogDiagnostics: true,
      routes: [
        StatefulShellRoute.indexedStack(
          builder: (context, state, navigationShell) {
            return MainScreen(navigationShell: navigationShell);
          },
          branches: [
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: [
                GoRoute(
                  path: HomeScreen.routePath,
                  name: HomeScreen.routeName,
                  builder: (context, state) {
                    return HomeScreen(
                      key: state.pageKey,
                    );
                  },
                  routes: [
                    GoRoute(
                      path: '/home_fetching_item',
                      name: 'home_fetching_item',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) {
                        final datas = state.extra as Map<String, dynamic>;
                        return FetchingItemsScreen(parameters: datas);
                      },
                    ),
                    GoRoute(
                      path: '/brand',
                      name: 'brand',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) {
                        return BrandScreen();
                      },
                    ),
                    GoRoute(
                      path: '/home-item-detail',
                      name: 'home-item-detail',
                      parentNavigatorKey: rootNavigatorKey,
                      builder: (context, state) {
                        final parameters = state.extra as Map<String, dynamic>;
                        return ItemDetailScreen(parameters: parameters);
                      },
                      routes: [
                        GoRoute(
                          path: '/review-product',
                          name: 'review-product',
                          parentNavigatorKey: rootNavigatorKey,
                          builder: (context, state) {
                            final parameters =
                                state.extra as Map<String, dynamic>;
                            return ReviewProductScreen(parameters: parameters);
                          },
                        ),
                        GoRoute(
                          path: '/merchant-profile',
                          name: 'merchant-profile',
                          parentNavigatorKey: rootNavigatorKey,
                          builder: (context, state) {
                            final parameters =
                                state.extra as Map<String, dynamic>;
                            return MerchantProfileScreen(
                                parameters: parameters);
                          },
                          routes: [
                            GoRoute(
                              path: '/merchant-item-detail',
                              name: 'merchant-item-detail',
                              parentNavigatorKey: rootNavigatorKey,
                              builder: (context, state) {
                                final parameters =
                                    state.extra as Map<String, dynamic>;
                                return ItemDetailScreen(parameters: parameters);
                              },
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: [
                GoRoute(
                  path: CategoryScreen.routePath,
                  name: CategoryScreen.routeName,
                  builder: (context, state) {
                    return CategoryScreen(key: state.pageKey);
                  },
                )
              ],
            ),
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: [
                GoRoute(
                    path: CartScreen.routePath,
                    name: CartScreen.routeName,
                    builder: (context, state) {
                      return CartScreen(key: state.pageKey);
                    },
                    routes: [
                      GoRoute(
                        path: CheckOutScreen.routePath,
                        name: CheckOutScreen.routeName,
                        parentNavigatorKey: rootNavigatorKey,
                        pageBuilder: (context, state) {
                          return CustomTransitionPage(
                            child: CheckOutScreen(),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              return FadeTransition(
                                  opacity: animation, child: child);
                            },
                          );
                        },
                        routes: [
                          GoRoute(
                            path: AddressScreen.routePath,
                            name: 'checkout_address',
                            // parentNavigatorKey: rootNavigatorKey,
                            pageBuilder: (context, state) {
                              return CustomTransitionPage(
                                child: AddressScreen(),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  return FadeTransition(
                                    opacity: animation,
                                    child: child,
                                  );
                                },
                              );
                            },
                            routes: [
                              GoRoute(
                                path: CreateAddressScreen.routePath,
                                name: 'checkout_create_address',
                                pageBuilder: (context, state) {
                                  return CustomTransitionPage(
                                    child: CreateAddressScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                          opacity: animation, child: child);
                                    },
                                  );
                                },
                              ),
                              GoRoute(
                                path: UpdateAddressScreen.routePath,
                                name: 'checkout_update_address',
                                pageBuilder: (context, state) {
                                  return CustomTransitionPage(
                                    child: UpdateAddressScreen(),
                                    transitionsBuilder: (context, animation,
                                        secondaryAnimation, child) {
                                      return FadeTransition(
                                          opacity: animation, child: child);
                                    },
                                  );
                                },
                              )
                            ],
                          )
                        ],
                      ),
                    ]),
              ],
            ),
            StatefulShellBranch(
              navigatorKey: GlobalKey<NavigatorState>(),
              routes: [
                GoRoute(
                  path: ProfileScreen.routePath,
                  name: ProfileScreen.routeName,
                  builder: (context, state) {
                    return ProfileScreen(key: state.pageKey);
                  },
                  routes: [
                    GoRoute(
                      path: AddressScreen.routePath,
                      name: '/profile_address',
                      parentNavigatorKey: rootNavigatorKey,
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          child: AddressScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        );
                      },
                      routes: [
                        GoRoute(
                          path: CreateAddressScreen.routePath,
                          name: 'profile_create_address',
                          pageBuilder: (context, state) {
                            return CustomTransitionPage(
                              child: CreateAddressScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            );
                          },
                        ),
                        GoRoute(
                          path: UpdateAddressScreen.routePath,
                          name: 'profile_update_address',
                          pageBuilder: (context, state) {
                            return CustomTransitionPage(
                              child: UpdateAddressScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
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
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        );
                      },
                      routes: [
                        GoRoute(
                            path: OrderDetailScreen.routePath,
                            name: OrderDetailScreen.routeName,
                            pageBuilder: (context, state) =>
                                CustomTransitionPage(
                                  child: OrderDetailScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                                pageBuilder: (context, state) =>
                                    CustomTransitionPage(
                                  child: WriteReviewScreen(),
                                  transitionsBuilder: (context, animation,
                                      secondaryAnimation, child) {
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
                    // GoRoute(
                    //   path: NotificationScreen.routePath,
                    //   name: NotificationScreen.routeName,
                    //   parentNavigatorKey: rootNavigatorKey,
                    //   pageBuilder: (context, state) {
                    //     return CustomTransitionPage(
                    //       child: NotificationScreen(),
                    //       transitionsBuilder:
                    //           (context, animation, secondaryAnimation, child) {
                    //         return FadeTransition(
                    //             opacity: animation, child: child);
                    //       },
                    //     );
                    //   },
                    // ),
                    GoRoute(
                      path: LanguageScreen.routePath,
                      name: LanguageScreen.routeName,
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          child: LanguageScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
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
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        );
                      },
                    ),
                    GoRoute(
                      path: LoginScreen.routePath,
                      name: LoginScreen.routeName,
                      pageBuilder: (context, state) {
                        return CustomTransitionPage(
                          child: LoginScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            return FadeTransition(
                                opacity: animation, child: child);
                          },
                        );
                      },
                      routes: [
                        GoRoute(
                          path: OtpScreen.routePath,
                          name: OtpScreen.routeName,
                          pageBuilder: (context, state) {
                            return CustomTransitionPage(
                              child: OtpScreen(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                    opacity: animation, child: child);
                              },
                            );
                          },
                        )
                      ],
                    )

                    ///==
                  ],
                )
              ],
            ),
          ],
        ),
      ],
      errorBuilder: (context, state) =>
          ErrorTypeWidget(type: ErrorType.notFound),
    );
  }
}
