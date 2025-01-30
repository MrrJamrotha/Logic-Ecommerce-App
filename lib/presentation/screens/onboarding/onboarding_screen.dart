import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_cubit.dart';
import 'package:logic_app/presentation/screens/onboarding/onboarding_state.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class OnboardingScreen extends StatefulWidget {
  static const routeName = 'onboarding';
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final screenCubit = OnboardingCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
      bottomSheet: Container(
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
            TextWidget(
              text: 'Look Good, Feed Good',
              fontSize: 30.scale,
              fontWeight: FontWeight.w700,
            ),
            TextWidget(
              text:
                  'Hating  the clothed in your wardrobe? Explore hundred of outfit idea ',
              fontSize: 16.scale,
              textAlign: TextAlign.center,
              color: textColor,
              height: 2.scale,
            ),
            ElevatedButton(
              onPressed: () {
                //TODO: this
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextWidget(text: 'Next'),
                ],
              ),
            ),
            SizedBox.shrink(),
            SizedBox.shrink(),
          ],
        ),
      ),
    );
  }

  Widget buildBody(OnboardingState state) {
    return Container(
      color: primary,
      child: Stack(
        children: [],
      ),
    );
  }
}
