import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/address/address_screen.dart';
import 'package:logic_app/presentation/screens/cubit/currency_screen.dart';
import 'package:logic_app/presentation/screens/language/language_screen.dart';
import 'package:logic_app/presentation/screens/order/order_screen.dart';
import 'package:logic_app/presentation/screens/profile/profile_cubit.dart';
import 'package:logic_app/presentation/screens/profile/profile_state.dart';
import 'package:logic_app/presentation/screens/wishlist/wishlist_screen.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/box_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  final screenCubit = ProfileCubit();

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
          context.pushNamed(OrderScreen.routeName);
          break;
        case WishlistScreen.routeName:
          break;
        case AddressScreen.routeName:
          context.pushNamed(AddressScreen.routeName);
          break;
        case LanguageScreen.routeName:
          context.pushNamed(LanguageScreen.routeName);
          break;
        case CurrencyScreen.routeName:
          context.pushNamed(CurrencyScreen.routeName);
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
                context.pop();
              },
              child: TextWidget(
                text: 'cancel'.tr,
                color: appRedAccent,
              ),
            ),
            TextButton(
              onPressed: () {
                context.pop();
              },
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
      appBar: AppbarWidget(title: 'Account'.tr),
      body: BlocConsumer<ProfileCubit, ProfileState>(
        bloc: screenCubit,
        listener: (BuildContext context, ProfileState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, ProfileState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(ProfileState state) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(appPedding.scale),
      child: Column(
        spacing: appPedding.scale,
        children: [
          _buildBoxProfile(),
          _buildListMenu(),
        ],
      ),
    );
  }

  Row _buildBoxProfile() {
    return Row(
      spacing: appSpace.scale,
      children: [
        CatchImageNetworkWidget(
          width: 120.scale,
          height: 120.scale,
          boxFit: BoxFit.cover,
          borderRadius: BorderRadius.circular(100.scale),
          imageUrl:
              'https://sm.ign.com/t/ign_nordic/feature/t/the-avatar/the-avatar-the-last-airbender-trailer-gets-a-lot-right-but-w_tkwa.1200.jpg',
          blurHash: 'LEHV6nWB2yk8pyo0adR*.7kCMdnj',
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 5.scale,
          children: [
            TextWidget(
              text: 'Soeurn Rotha',
              fontSize: 18.scale,
            ),
            TextWidget(
              text: '099 299 011',
              fontSize: 16.scale,
              color: textColor,
            ),
            ButtonWidget(
              title: 'edit_profile'.tr,
              onPressed: () {
                //TODO:
              },
            )
          ],
        ),
      ],
    );
  }

  Widget _buildListMenu() {
    return BoxWidget(
      borderRadius: BorderRadius.circular(appSpace.scale),
      padding: EdgeInsets.symmetric(
          vertical: appSpace.scale, horizontal: appPedding.scale),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        separatorBuilder: (context, index) => Divider(
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
