import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/home/home_screen.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/lottie_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(appPedding.scale),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: appPedding.scale,
            children: [
              LottieWidget(
                assets: doneLottie,
                width: 200.scale,
                height: 200.scale,
              ),
              TextWidget(
                text: 'thank_you'.tr,
                fontWeight: FontWeight.w600,
                fontSize: 30.scale,
              ),
              TextWidget(
                text: 'pay_success'.tr,
                fontSize: 20.scale,
              ),
              TextWidget(
                text: '3489.99\$'.tr,
                fontSize: 20.scale,
                color: primary,
              ),
              ButtonWidget(
                title: 'continue_shopping'.tr,
                onPressed: () {
                  context.read<SettingCubit>().onPageChanged(0);
                  context.go(HomeScreen.routePath);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
