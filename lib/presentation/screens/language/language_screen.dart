import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/helper/helper.dart';
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
  String _selectedLanguage = 'en'; // Default language

  void _changeLanguage(String? langCode) {
    if (langCode != null) {
      setState(() {
        _selectedLanguage = langCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'language'.tr),
      body: Column(
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
            trailing: Radio.adaptive(
              value: 'km',
              groupValue: _selectedLanguage,
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
            trailing: Radio.adaptive(
              value: 'en',
              groupValue: _selectedLanguage,
              onChanged: _changeLanguage,
            ),
          ),
        ],
      ),
    );
  }
}
