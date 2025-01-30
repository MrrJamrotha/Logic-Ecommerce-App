import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/category/category_screen.dart';
import 'package:logic_app/presentation/screens/home/home_screen.dart';
import 'package:logic_app/presentation/screens/profile/profile_screen.dart';
import 'package:logic_app/presentation/screens/search/search_screen.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:logic_app/presentation/screens/setting/setting_state.dart';

class MainScreen extends StatefulWidget {
  static const routePath = '/main';
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late PageController _pageController;
  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    AppSizeConfig().init(context);
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return Scaffold(
          body: PageView(
            physics: NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: [
              HomeScreen(),
              CategoryScreen(),
              SearchScreen(),
              ProfileScreen(),
            ],
          ),
          bottomNavigationBar: NavigationBar(
            onDestinationSelected: (index) {
              context.read<SettingCubit>().onPageChanged(index);
              _pageController.jumpToPage(index);
            },
            selectedIndex: state.currentIndex,
            destinations: [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: 'home'.tr,
              ),
              NavigationDestination(
                icon: Icon(Icons.menu),
                label: 'category',
              ),
              NavigationDestination(
                icon: Icon(Icons.search),
                label: 'search',
              ),
              NavigationDestination(
                icon: Icon(Icons.account_circle_outlined),
                label: 'account',
              ),
            ],
          ),
        );
      },
    );
  }
}
