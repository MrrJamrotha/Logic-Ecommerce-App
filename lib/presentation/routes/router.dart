import 'package:flutter/material.dart';
import 'package:foxShop/presentation/screens/address/address_screen.dart';
import 'package:foxShop/presentation/screens/auth/login/login_screen.dart';
import 'package:foxShop/presentation/screens/auth/otp/otp_screen.dart';
import 'package:foxShop/presentation/screens/brand/brand_screen.dart';
import 'package:foxShop/presentation/screens/check_out/check_out_screen.dart';
import 'package:foxShop/presentation/screens/create_address/create_address_screen.dart';
import 'package:foxShop/presentation/screens/cubit/currency_screen.dart';
import 'package:foxShop/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:foxShop/presentation/screens/fetching_items/fetching_items_screen.dart';
import 'package:foxShop/presentation/screens/item_detail/item_detail_screen.dart';
import 'package:foxShop/presentation/screens/language/language_screen.dart';
import 'package:foxShop/presentation/screens/main_screen.dart';
import 'package:foxShop/presentation/screens/merchant_profile/merchant_profile_screen.dart';
import 'package:foxShop/presentation/screens/notification/notification_screen.dart';
import 'package:foxShop/presentation/screens/order/order_screen.dart';
import 'package:foxShop/presentation/screens/order_detail/order_detail_screen.dart';
import 'package:foxShop/presentation/screens/product_by_brand/product_by_brand_screen.dart';
import 'package:foxShop/presentation/screens/product_by_category/product_by_category_screen.dart';
import 'package:foxShop/presentation/screens/review_product/review_product_screen.dart';
import 'package:foxShop/presentation/screens/update_address/update_address_screen.dart';
import 'package:foxShop/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:foxShop/presentation/screens/write_review/write_review_screen.dart';

class AppNavigator {
  static SlideTransition _st(animation, child) {
    final tween = Tween(
      begin: const Offset(1.0, 0.0),
      end: Offset.zero,
    );
    final curvedAnimation = CurvedAnimation(
      parent: animation,
      curve: Curves.ease,
    );
    return SlideTransition(
      position: tween.animate(curvedAnimation),
      child: child,
    );
  }

  static Route<dynamic>? appRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => MainScreen(),
        );
      case ItemDetailScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return ItemDetailScreen(
              key: ValueKey(ItemDetailScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case FetchingItemsScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return FetchingItemsScreen(
              key: ValueKey(FetchingItemsScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case CreateAddressScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return CreateAddressScreen(
              key: ValueKey(CreateAddressScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case OrderScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return OrderScreen(
              key: ValueKey(OrderScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case WishlistScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return WishlistScreen(
              key: ValueKey(WishlistScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case AddressScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return AddressScreen(
              key: ValueKey(AddressScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case LanguageScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return LanguageScreen(
              key: ValueKey(LanguageScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case CurrencyScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return CurrencyScreen(
              key: ValueKey(CurrencyScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case EditProfileScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return EditProfileScreen(
              key: ValueKey(EditProfileScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case ProductByBrandScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return ProductByBrandScreen(
              key: ValueKey(ProductByBrandScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case BrandScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return BrandScreen(
              key: ValueKey(BrandScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case UpdateAddressScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return UpdateAddressScreen(
              key: ValueKey(BrandScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case OtpScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return OtpScreen(
              key: ValueKey(OtpScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case CheckOutScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return CheckOutScreen(
              key: ValueKey(OtpScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case ProductByCategoryScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return ProductByCategoryScreen(
              key: ValueKey(ProductByCategoryScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case MerchantProfileScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return MerchantProfileScreen(
              key: ValueKey(MerchantProfileScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case WriteReviewScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return WriteReviewScreen(
              key: ValueKey(WriteReviewScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case NotificationScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            // final parameters = settings.arguments as Map<String, dynamic>;
            return NotificationScreen(
              key: ValueKey(NotificationScreen.routeName),
              // parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case OrderDetailScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return OrderDetailScreen(
              key: ValueKey(OrderDetailScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      case ReviewProductScreen.routeName:
        return PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            final parameters = settings.arguments as Map<String, dynamic>;
            return ReviewProductScreen(
              key: ValueKey(ReviewProductScreen.routeName),
              parameters: parameters,
            );
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return _st(animation, child);
          },
        );

      default:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
    }
  }
}
