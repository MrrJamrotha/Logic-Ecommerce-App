import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_cubit.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});
  static const routeName = 'otp';
  static const routePath = '/otp';
  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final screenCubit = OtpCubit();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey();
  late OTPTextEditController controller;

  @override
  void initState() {
    controller = OTPTextEditController(
      codeLength: 6,
    )..startListenUserConsent(
        (code) {
          final exp = RegExp(r'(\d{6})');
          return exp.stringMatch(code ?? '') ?? '';
        },
      );
    screenCubit.loadInitialData();
    super.initState();
  }

  void onOtpSubmit() {
    if (_formKey.currentState!.validate()) {
      // screenCubit.submitOtp(otp);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: '',
        isNotification: false,
      ),
      body: BlocConsumer<OtpCubit, OtpState>(
        bloc: screenCubit,
        listener: (BuildContext context, OtpState state) {
          if (state.error != null) {
            // TODO your code here
          }
        },
        builder: (BuildContext context, OtpState state) {
          if (state.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          return buildBody(state);
        },
      ),
    );
  }

  Widget buildBody(OtpState state) {
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
                text: 'enter_otp'.tr,
                fontSize: 20.scale,
                fontWeight: FontWeight.w700,
              ),
              TextWidget(
                text: 'otp_content'.tr,
                fontSize: 14.scale,
              ),
              Pinput(
                  controller: controller,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  onTapOutside: (PointerDownEvent event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'opt_code_required'.tr;
                    }
                    if (value.length != 6) {
                      return 'opt_code_length'.tr;
                    }
                    return null;
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    //TODO:
                  }),
              ButtonWidget(
                title: 'confirm'.tr,
                onPressed: () {
                  onOtpSubmit();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
