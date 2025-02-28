import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_enum.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_images.dart';
import 'package:foxShop/core/constants/app_space.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/data/models/user_model.dart';
import 'package:foxShop/presentation/screens/address/address_screen.dart';
import 'package:foxShop/presentation/screens/auth/login/login_screen.dart';
import 'package:foxShop/presentation/screens/cubit/currency_screen.dart';
import 'package:foxShop/presentation/screens/edit_profile/edit_profile_screen.dart';
import 'package:foxShop/presentation/screens/language/language_screen.dart';
import 'package:foxShop/presentation/screens/order/order_screen.dart';
import 'package:foxShop/presentation/screens/profile/profile_cubit.dart';
import 'package:foxShop/presentation/screens/profile/profile_state.dart';
import 'package:foxShop/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/box_widget.dart';
import 'package:foxShop/presentation/widgets/button_widget.dart';
import 'package:foxShop/presentation/widgets/catch_image_network_widget.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  static const routeName = 'profile_screen';
  static const routePath = '/profile_screen';

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final screenCubit = ProfileCubit();
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  final List listMenus = [
    {
      'id': 1,
      'name': 'orders',
      'icon_name': orderSvg,
      'is_arrow': true,
      'route': OrderScreen.routeName,
    },
    {
      'id': 2,
      'name': 'wishlists',
      'icon_name': wishlist,
      'is_arrow': true,
      'route': WishlistScreen.routeName,
    },
    {
      'id': 3,
      'name': 'address',
      'icon_name': locationSvg,
      'is_arrow': true,
      'route': AddressScreen.routeName,
    },
    {
      'id': 4,
      'name': 'language',
      'icon_name': languageSvg,
      'is_arrow': true,
      'route': LanguageScreen.routeName,
    },
    {
      'id': 5,
      'name': 'currency',
      'icon_name': currencySvg,
      'is_arrow': true,
      'route': CurrencyScreen.routeName,
    },
    {
      'id': 6,
      'name': 'logout',
      'icon_name': logoutSvg,
      'is_arrow': false,
      'route': ''
    },
  ];

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  void handelOnTap(int index) {
    try {
      final route = listMenus[index]['route'];
      switch (route) {
        case OrderScreen.routeName:
          Navigator.pushNamed(context, OrderScreen.routeName);
          break;
        case WishlistScreen.routeName:
          Navigator.pushNamed(context, WishlistScreen.routeName);
          break;
        case AddressScreen.routeName:
          Navigator.pushNamed(context, AddressScreen.routeName);
          break;
        case LanguageScreen.routeName:
          Navigator.pushNamed(context, LanguageScreen.routeName);
          break;
        case CurrencyScreen.routeName:
          Navigator.pushNamed(context, CurrencyScreen.routeName);
          break;
        case '':
          showDialogLogout();
          break;
        default:
          showDialogLogout();
          break;
      }
    } catch (e) {
      logger.e(e);
    }
  }

  void _handleLogout() async {
    try {
      Navigator.pop(context);
      LoadingOverlay.show(context);
      String googleId = screenCubit.state.userModel?.googleId ?? "";
      final result = await screenCubit.logout();
      if (googleId.isNotEmpty) {
        await _googleSignIn.signOut();
      }
      if (result) {
        showMessage(message: 'you_logout_success'.tr);
      } else {
        showMessage(message: 'logout_failed'.tr, status: MessageStatus.warning);
      }
      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
    }
  }

  showDialogLogout() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: TextWidget(text: 'logout'.tr),
          content: TextWidget(text: 'logout_content'.tr),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: TextWidget(
                text: 'cancel'.tr,
                color: appRedAccent,
              ),
            ),
            TextButton(
              onPressed: () => _handleLogout(),
              child: TextWidget(
                text: 'ok'.tr,
                color: appBlack,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'account'.tr),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        bloc: screenCubit,
        builder: (BuildContext context, ProfileState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ProfileState state) {
    if (!state.isLogin) {
      return Padding(
        padding: EdgeInsets.all(appPedding.scale),
        child: Column(
          spacing: appPedding.scale,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                loginPng,
                width: 200.scale,
                height: 200.scale,
              ),
            ),
            ButtonWidget(
              title: 'sign_in'.tr,
              onPressed: () {
                Navigator.pushNamed(context, LoginScreen.routeName)
                    .then((value) {
                  screenCubit.loadInitialData();
                });
              },
            )
          ],
        ),
      );
    }
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Column(
        spacing: appPedding.scale,
        children: [
          _buildBoxProfile(state.userModel),
          _buildListMenu(),
        ],
      ),
    );
  }

  Row _buildBoxProfile(UserModel? user) {
    return Row(
      spacing: appSpace.scale,
      children: [
        CatchImageNetworkWidget(
          width: 120.scale,
          height: 120.scale,
          boxFit: BoxFit.cover,
          borderRadius: BorderRadius.circular(100.scale),
          imageUrl: user?.avatar ?? "",
          blurHash: user?.avatarHash ?? "",
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 5.scale,
            children: [
              TextWidget(
                text: user?.username ?? "",
                fontSize: 18.scale,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              TextWidget(
                text: user?.phoneNumber ?? "",
                fontSize: 16.scale,
                color: textColor,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              ButtonWidget(
                title: 'edit_profile'.tr,
                onPressed: () {
                  Navigator.pushNamed(context, EditProfileScreen.routeName)
                      .then((value) {
                    screenCubit.loadInitialData();
                  });
                },
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListMenu() {
    return BoxWidget(
      borderRadius: BorderRadius.circular(appSpace.scale),
      padding: EdgeInsets.symmetric(
        vertical: appSpace.scale,
        horizontal: appPedding.scale,
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
          // ignore: deprecated_member_use
          color: textColor.withOpacity(0.1),
          height: 0.1.scale,
        ),
        itemCount: listMenus.length,
        itemBuilder: (context, index) {
          final record = listMenus[index];
          return ListTile(
            contentPadding: EdgeInsets.zero,
            onTap: () => handelOnTap(index),
            leading: IconWidget(
              assetName: record['icon_name'],
              width: 24.scale,
              height: 24.scale,
            ),
            title: TextWidget(text: record['name'].toString().tr),
            trailing: record['is_arrow'] == true
                ? IconWidget(
                    assetName: arrowRightSvg,
                    width: 24.scale,
                    height: 24.scale,
                  )
                : null,
          );
        },
      ),
    );
  }
}
