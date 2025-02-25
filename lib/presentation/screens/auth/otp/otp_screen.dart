import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_enum.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/constants/app_space.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/helper/loading_overlay.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_cubit.dart';
import 'package:logic_app/presentation/screens/auth/otp/otp_state.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/button_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';
import 'package:otp_autofill/otp_autofill.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, required this.parameters});
  static const routeName = 'otp';
  final Map<String, dynamic> parameters;
  @override
  OtpScreenState createState() => OtpScreenState();
}

class OtpScreenState extends State<OtpScreen> {
  final screenCubit = OtpCubit();
  final _formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey();
  late OTPTextEditController controller;
  late OTPInteractor _otpInteractor;

  @override
  void initState() {
    _otpInteractor = OTPInteractor();
    controller = OTPTextEditController(
      codeLength: 5,
      otpInteractor: _otpInteractor,
      onTimeOutException: () {
        // Restart listening on timeout, only for Android
        if (Platform.isAndroid) {
          controller.startListenUserConsent(
            (code) {
              final exp = RegExp(r'\d{5}');
              return exp.stringMatch(code ?? '') ?? '';
            },
          );
        }
      },
    );

    if (Platform.isAndroid) {
      controller.startListenUserConsent(
        (code) {
          final exp = RegExp(r'\d{5}');
          return exp.stringMatch(code ?? '') ?? '';
        },
      );
    }
    super.initState();
  }

  void onOtpSubmit() async {
    if (_formKey.currentState!.validate()) {
      LoadingOverlay.show(context);
      final result = await screenCubit.verifyOtp(parameters: {
        'phone_number': widget.parameters['phone_number'],
        'code': controller.text,
      });
      LoadingOverlay.hide();

      if (result) {
        showMessage(
          message: screenCubit.state.message ?? "",
          status: MessageStatus.success,
        );
        if (!mounted) return;
        Navigator.pop(context, {'result': result});
      } else {
        showMessage(
          message: screenCubit.state.message ?? "",
          status: MessageStatus.warning,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(
        title: '',
        isNotification: false,
      ),
      body: BlocBuilder<OtpCubit, OtpState>(
        bloc: screenCubit,
        builder: (BuildContext context, OtpState state) {
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
                onSubmitted: (value) => onOtpSubmit(),
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
                onCompleted: (pin) => onOtpSubmit(),
              ),
              ButtonWidget(
                title: 'confirm'.tr,
                onPressed: () => onOtpSubmit(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
