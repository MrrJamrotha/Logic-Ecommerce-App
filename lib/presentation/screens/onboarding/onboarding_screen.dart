import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_size_config.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_cubit.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_state.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/catch_image_network_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = 'onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final screenCubit = OnboardingCubit();
  final _pageController = PageController();
  final _currentIndex = ValueNotifier<int>(0);
  List onboardings = [
    {
      'id': 1,
      'image_url':
          'https://static.vecteezy.com/system/resources/previews/053/467/533/non_2x/a-man-in-a-black-leather-jacket-and-jeans-png.png',
      'content': 'Relaxed',
      'position': 'left',
      'header': 'Look Good, Feed Good',
      'body':
          'Hating  the clothed in your wardrobe? Explore hundred of outfit idea'
    },
    {
      'id': 2,
      'image_url':
          'https://static.vecteezy.com/system/resources/previews/053/236/415/non_2x/a-man-in-black-jeans-and-a-white-t-shirt-png.png',
      'content': 'Playful',
      'position': 'right',
      'header': 'Find your outfits',
      'body':
          "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book."
    },
  ];

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  void onPageChanged(int index) {
    _currentIndex.value = index;
  }

  void onNextPage(int index) {
    _pageController.animateToPage(
      index + 1,
      duration: Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  @override
  Widget build(BuildContext context) {
    AppSizeConfig().init(context);
    return Scaffold(
      body: BlocConsumer<OnboardingCubit, OnboardingState>(
        bloc: screenCubit,
        listener: (BuildContext context, OnboardingState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, OnboardingState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
      bottomSheet: _buildBottomSheet(),
    );
  }

  Widget _buildBottomSheet() {
    return ValueListenableBuilder(
      valueListenable: _currentIndex,
      builder: (context, currentIndex, child) {
        return Container(
          padding: EdgeInsets.all(16.scale),
          decoration: BoxDecoration(
            color: appWhite,
            borderRadius: BorderRadius.horizontal(
              left: Radius.circular(20.scale),
              right: Radius.circular(20.scale),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 41.scale,
            children: [
              SmoothPageIndicator(
                controller: _pageController, // PageController
                count: onboardings.length,
                effect: ExpandingDotsEffect(
                  activeDotColor: primary,
                  dotColor: textColor.withOpacity(0.3),
                ), // your preferred effect
                onDotClicked: (index) {
                  _pageController.animateToPage(
                    index,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
              ),

              TextWidget(
                text: onboardings[currentIndex]['header'],
                fontSize: 30.scale,
                fontWeight: FontWeight.w700,
              ),
              TextWidget(
                text: onboardings[currentIndex]['body'],
                fontSize: 16.scale,
                textAlign: TextAlign.center,
                color: textColor,
              ),
              ButtonWidget(
                onPressed: () {
                  onNextPage(currentIndex);
                },
                title: (currentIndex == onboardings.length - 1)
                    ? "Let’s get started".tr
                    : 'Next'.tr,
              ),
              // SizedBox.shrink(),
              // SizedBox.shrink(),
            ],
          ),
        );
      },
    );
  }

  Widget buildBody(OnboardingState state) {
    return PageView.builder(
      itemCount: onboardings.length,
      controller: _pageController,
      onPageChanged: onPageChanged,
      itemBuilder: (context, index) {
        final record = onboardings[index];
        return Container(
          key: ValueKey(record['id']),
          color: primary,
          child: Stack(
            children: [
              CatchImageNetworkWidget(
                boxFit: BoxFit.cover,
                imageUrl: record['image_url'],
                blurHash: 'LGF5?xYk^6#M@-5c,1J5@[or[Q6.',
              ),
              if (record['position'] == 'left')
                Positioned(
                  left: 0,
                  top: AppSizeConfig.screenHeight / 3,
                  // bottom: 0,
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: TextWidget(
                      text: record['content'],
                      fontSize: 50.scale,
                      fontWeight: FontWeight.w700,
                      color: appWhite,
                    ),
                  ),
                ),
              if (record['position'] == 'right')
                Positioned(
                  right: 0,
                  top: AppSizeConfig.screenHeight / 7,
                  // bottom: 0,
                  child: RotatedBox(
                    quarterTurns: 5,
                    child: TextWidget(
                      text: record['content'],
                      fontSize: 50.scale,
                      fontWeight: FontWeight.w700,
                      color: appWhite,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
