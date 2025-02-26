import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:logic_app/core/constants/app_colors.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_icons.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/helper/loading_overlay.dart';
import 'package:logic_app/data/models/country_model.dart';
import 'package:logic_app/presentation/screens/auth/login/login_cubit.dart';
import 'package:logic_app/presentation/screens/auth/login/login_state.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_screen.dart';
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
  final _searchTextCtr = TextEditingController();
  final _phoneNumberCtr = TextEditingController();
  final _dialCodeCtr = TextEditingController(text: "+855");
  final _formKey = GlobalKey<FormState>();

  List<String> scopes = <String>['email'];

  late GoogleSignIn _googleSignIn;

  @override
  void initState() {
    screenCubit.getCountries();
    _googleSignIn = GoogleSignIn(
      // serverClientId: dotenv.env['GOOGLE_SERVER_CLIENT_ID'],
      clientId: dotenv.env['GOOGLE_CLIENT_ID'],
      // scopes: scopes,
    );
    super.initState();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      try {
        LoadingOverlay.show(context);
        final result = await screenCubit.generateOtpCode(
          parameters: {
            'phone_number': '${_dialCodeCtr.text}${_phoneNumberCtr.text}',
          },
        );
        if (result) {
          if (!mounted) return;
          showMessage(
            message: screenCubit.state.message ?? "",
            status: MessageStatus.success,
          );
          Navigator.pushNamed(context, OtpScreen.routeName, arguments: {
            'phone_number': '${_dialCodeCtr.text}${_phoneNumberCtr.text}',
          }).then((value) {
            var data = value as Map;
            if (!mounted) return;
            Navigator.pop(context, data);
          });
        } else {
          showMessage(
            message: screenCubit.state.message ?? "",
            status: MessageStatus.warning,
          );
        }

        LoadingOverlay.hide();
      } catch (e) {
        LoadingOverlay.hide();
        showMessage(
          message: "Failed to generate OTP code. Please try again later.",
          status: MessageStatus.error,
        );
      }
    }
  }

  void _handleLoginWithGoogle() async {
    try {
      print('==============google============');
      var user = await _googleSignIn.signIn();
      print(user);
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext contex5t) {
    return Scaffold(
      appBar: AppbarWidget(
        title: '',
        isNotification: false,
      ),
      body: BlocBuilder<LoginCubit, LoginState>(
        bloc: screenCubit,
        builder: (BuildContext context, LoginState state) {
          if (state.isLoading) {
            return centerLoading();
          }

          return buildBody(state);
        },
      ),
    );
  }

  void showModalCountries() {
    showModalBottomSheet(
      isScrollControlled: true,
      useRootNavigator: true,
      useSafeArea: true,
      showDragHandle: true,
      backgroundColor: appWhite,
      context: context,
      builder: (context) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.5,
          expand: false,
          snap: true,
          builder: (BuildContext context, ScrollController scrollController) {
            return Column(
              children: [
                // 🔹 Search Bar
                Padding(
                  padding: EdgeInsets.all(appPedding.scale),
                  child: CupertinoSearchTextField(
                    controller: _searchTextCtr,
                    placeholder: 'search_country'.tr,
                    onChanged: (value) {
                      screenCubit.searchCountries(value);
                    },
                  ),
                ),

                // 🔹 Scrollable List with Search Results
                Expanded(
                  child:
                      BlocSelector<LoginCubit, LoginState, List<CountryModel>>(
                    bloc: screenCubit,
                    selector: (state) {
                      return state.countries ?? [];
                    },
                    builder: (context, filteredCountries) {
                      return ListView.builder(
                        controller: scrollController,
                        itemCount: filteredCountries.length,
                        itemBuilder: (context, index) {
                          final country = filteredCountries[index];
                          return ListTile(
                            leading: Text(
                              country.emoji,
                              style: TextStyle(fontSize: 24.scale),
                            ),
                            title: TextWidget(text: country.name),
                            subtitle: TextWidget(text: country.dialCode),
                            trailing: TextWidget(text: country.code),
                            onTap: () {
                              screenCubit.selectDialcode(country.dialCode);
                              _dialCodeCtr.text = country.dialCode;
                              Navigator.pop(context);
                            },
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget buildBody(LoginState state) {
    return Center(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(appPedding.scale),
        child: Form(
          key: _formKey,
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
                text: 'enter_phone'.tr,
                fontSize: 20.scale,
                fontWeight: FontWeight.w700,
              ),
              TextWidget(
                text: 'login_content'.tr,
                fontSize: 14.scale,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: appSpace.scale,
                children: [
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      controller: _dialCodeCtr,
                      readOnly: true,
                      onTap: () {
                        showModalCountries();
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
                      controller: _phoneNumberCtr,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'phone_number_required'.tr;
                        }
                        if (value.length < 8) {
                          return 'phone_number_length'.tr;
                        }
                        return null;
                      },
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.done,
                      onFieldSubmitted: (v) => _handleLogin(),
                      onEditingComplete: () => _handleLogin(),
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
                onPressed: () => _handleLogin(),
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
                onPressed: () => _handleLoginWithGoogle(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroudButtonColor.withOpacity(0.1),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(appRadius.scale),
                  ),
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
      ),
    );
  }
}
