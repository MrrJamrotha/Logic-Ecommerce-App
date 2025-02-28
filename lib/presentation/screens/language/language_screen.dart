import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/core/helper/loading_overlay.dart';
import 'package:logic_app/presentation/global/application/application_cubit.dart';
import 'package:logic_app/presentation/screens/language/language_cubit.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});
  static const routeName = 'language';
  static const routePath = '/language';

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  final _selectedLanguage = ValueNotifier<String>("");
  final screenCubit = LanguageCubit();
  @override
  void initState() {
    _initialLanguage();
    super.initState();
  }

  _initialLanguage() {
    var localeCode = context.read<ApplicationCubit>().state.localeCode;
    _selectedLanguage.value = localeCode ?? "en";
  }

  void _changeLanguage(String? langCode) async {
    try {
      if (langCode != null) {
        _selectedLanguage.value = langCode;
        LoadingOverlay.show(context);
        context.read<ApplicationCubit>().changeLocale(langCode);
        await screenCubit.changeLocale(langCode);
        LoadingOverlay.hide();
      }
    } catch (e) {
      LoadingOverlay.hide();
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'language'.tr),
      body: ValueListenableBuilder(
        valueListenable: _selectedLanguage,
        builder: (context, selectedLanguage, child) {
          return Column(
            children: [
              ListTile(
                onTap: () {
                  _changeLanguage('km');
                },
                leading: Image.asset(
                  khmerImg,
                  width: 50.scale,
                  height: 50.scale,
                ),
                title: TextWidget(text: 'khmer'.tr),
                trailing: Radio<String>.adaptive(
                  value: 'km',
                  groupValue: _selectedLanguage.value,
                  onChanged: _changeLanguage,
                ),
              ),
              ListTile(
                onTap: () {
                  _changeLanguage('en');
                },
                leading: Image.asset(
                  usaImg,
                  width: 50.scale,
                  height: 50.scale,
                ),
                title: TextWidget(text: 'english'.tr),
                trailing: Radio<String>.adaptive(
                  value: 'en',
                  groupValue: _selectedLanguage.value,
                  onChanged: _changeLanguage,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
