import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_colors.dart';
import 'package:foxShop/core/constants/app_icons.dart';
import 'package:foxShop/core/constants/app_size_config.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/presentation/screens/cart/cart_screen.dart';
import 'package:foxShop/presentation/screens/category/category_screen.dart';
import 'package:foxShop/presentation/screens/home/home_screen.dart';
import 'package:foxShop/presentation/screens/profile/profile_screen.dart';
import 'package:foxShop/presentation/screens/setting/setting_cubit.dart';
import 'package:foxShop/presentation/screens/setting/setting_state.dart';
import 'package:foxShop/presentation/widgets/icon_widget.dart';

class MainScreen extends StatefulWidget {
  static const routeName = '/';
  static _MainScreenState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MainScreenState>();
  const MainScreen({
    super.key,
    this.initialPage = 0,
  });
  final int initialPage;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: widget.initialPage);
    super.initState();
  }

  void jumpToPage(index) {
    _pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
    context.read<SettingCubit>().onPageChanged(index);
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialPage != oldWidget.initialPage) {
      _pageController.jumpToPage(widget.initialPage);
    }
  }

  @override
  Widget build(BuildContext context) {
    AppSizeConfig().init(context);
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              HomeScreen(),
              CategoryScreen(),
              CartScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            backgroundColor: appWhite,
            onDestinationSelected: jumpToPage,
            indicatorColor: primary,
            surfaceTintColor: appWhite,
            selectedIndex: state.currentIndex,
            destinations: [
              NavigationDestination(
                selectedIcon: IconWidget(
                  assetName: homeSvg,
                  width: 24.scale,
                  height: 24.scale,
                  colorFilter: ColorFilter.mode(appWhite, BlendMode.srcIn),
                ),
                icon: IconWidget(
                  assetName: homeSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
                label: 'home'.tr,
              ),
              NavigationDestination(
                selectedIcon: IconWidget(
                  assetName: menuSvg,
                  width: 24.scale,
                  height: 24.scale,
                  colorFilter: ColorFilter.mode(appWhite, BlendMode.srcIn),
                ),
                icon: IconWidget(
                  assetName: menuSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
                label: 'categories'.tr,
              ),
              NavigationDestination(
                selectedIcon: Badge.count(
                  count: 10, //TODO: next time
                  child: IconWidget(
                    assetName: cartSvg,
                    width: 24.scale,
                    height: 24.scale,
                    colorFilter: ColorFilter.mode(appWhite, BlendMode.srcIn),
                  ),
                ),
                icon: Badge.count(
                  count: 10, //TODO: next time
                  child: IconWidget(
                    assetName: cartSvg,
                    width: 24.scale,
                    height: 24.scale,
                  ),
                ),
                label: 'carts'.tr,
              ),
              NavigationDestination(
                selectedIcon: IconWidget(
                  assetName: userSvg,
                  width: 24.scale,
                  height: 24.scale,
                  colorFilter: ColorFilter.mode(appWhite, BlendMode.srcIn),
                ),
                icon: IconWidget(
                  assetName: userSvg,
                  width: 24.scale,
                  height: 24.scale,
                ),
                label: 'account'.tr,
              ),
            ],
          ),
        );
      },
    );
  }
}
