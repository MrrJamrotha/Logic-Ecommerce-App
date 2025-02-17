import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:logic_app/presentation/screens/setting/setting_state.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';

class MainScreen extends StatefulWidget {
  static const routePath = '/main';
  static const routeName = 'main';
  const MainScreen({
    super.key,
    this.initialPage = 0,
    required this.navigationShell,
  });
  final int initialPage;

  final StatefulNavigationShell navigationShell;

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _onTap(index) {
    context.read<SettingCubit>().onPageChanged(index);
    widget.navigationShell.goBranch(
      index,
      initialLocation: index == widget.navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSizeConfig().init(context);
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Scaffold(
          body: widget.navigationShell,
          bottomNavigationBar: NavigationBar(
            backgroundColor: appWhite,
            onDestinationSelected: _onTap,
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
