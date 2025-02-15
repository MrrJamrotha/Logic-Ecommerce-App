import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/auth/login/login_cubit.dart';
import 'package:logic_app/presentation/screens/auth/login/login_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/icon_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const routeName = 'login';
  static const routePath = '/login';

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final screenCubit = LoginCubit();

  @override
  void initState() {
    screenCubit.loadInitialData();
    super.initState();
  }

  @override
  Widget build(BuildContext contex5t) {
    return Scaffold(
      appBar: AppbarWidget(
        title: '',
        isNotification: false,
      ),
      body: BlocConsumer<LoginCubit, LoginState>(
        bloc: screenCubit,
        listener: (BuildContext context, LoginState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, LoginState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(LoginState state) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPedding.scale),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: appPedding.scale,
          children: [
            Center(
              child: Image.asset(
                logoImg,
                width: 150.scale,
                height: 150.scale,
              ),
            ),
            TextWidget(
              text: 'Enter your mobile phone',
              fontSize: 20.scale,
              fontWeight: FontWeight.w700,
            ),
            TextWidget(
              text:
                  'Please confirm your country code and enter your phone number',
              fontSize: 14.scale,
            ),
            Row(
              spacing: appSpace.scale,
              children: [
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    readOnly: true,
                    onTap: () {
                      //
                    },
                    decoration: InputDecoration(
                      hintText: 'country'.tr,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: TextFormField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    onTapOutside: (PointerDownEvent event) {
                      FocusManager.instance.primaryFocus?.unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: 'phone_number'.tr,
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
            ButtonWidget(
              title: 'continue'.tr,
              onPressed: () {
                //TODO:
              },
            ),
            Row(
              spacing: appRadius.scale,
              children: [
                Expanded(child: Divider(color: textColor)),
                TextWidget(text: 'or_sign_with'.tr, color: textColor),
                Expanded(child: Divider(color: textColor)),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroudButtonColor.withOpacity(0.1),
              ),
              child: Row(
                spacing: appSpace.scale,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconWidget(assetName: googleSvg),
                  TextWidget(
                    text: 'continue_with_google'.tr,
                    color: appBlack,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
