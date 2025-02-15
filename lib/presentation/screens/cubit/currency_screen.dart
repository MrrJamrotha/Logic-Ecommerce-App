import 'package:flutter/material.dart';
import 'package:logic_app/core/constants/app_images.dart';
import 'package:logic_app/core/helper/helper.dart';
import 'package:logic_app/presentation/widgets/app_bar_widget.dart';
import 'package:logic_app/presentation/widgets/text_widget.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});
  static const routeName = 'currency';
  static const routePath = '/currency';

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  String _selectedCurrency = 'USD';

  void _changeCurrenct(String? currencyCode) {
    if (currencyCode != null) {
      setState(() {
        _selectedCurrency = currencyCode;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'currency'.tr),
      body: Column(
        children: [
          ListTile(
            onTap: () {
              _changeCurrenct('KHR');
            },
            leading: Image.asset(
              khmerImg,
              width: 50.scale,
              height: 50.scale,
            ),
            title: TextWidget(text: 'KHR'),
            trailing: Radio.adaptive(
              value: 'KHR',
              groupValue: _selectedCurrency,
              onChanged: _changeCurrenct,
            ),
          ),
          ListTile(
            onTap: () {
              _changeCurrenct('USD');
            },
            leading: Image.asset(
              usaImg,
              width: 50.scale,
              height: 50.scale,
            ),
            title: TextWidget(text: 'USD'),
            trailing: Radio.adaptive(
              value: 'USD',
              groupValue: _selectedCurrency,
              onChanged: _changeCurrenct,
            ),
          ),
          ListTile(
            onTap: () {
              _changeCurrenct('JPY');
            },
            leading: Image.asset(
              javImg,
              width: 50.scale,
              height: 50.scale,
            ),
            title: TextWidget(text: 'JPY'),
            trailing: Radio.adaptive(
              value: 'JPY',
              groupValue: _selectedCurrency,
              onChanged: _changeCurrenct,
            ),
          ),
          ListTile(
            onTap: () {
              _changeCurrenct('CNY');
            },
            leading: Image.asset(
              china,
              width: 50.scale,
              height: 50.scale,
            ),
            title: TextWidget(text: 'CNY'),
            trailing: Radio.adaptive(
              value: 'CNY',
              groupValue: _selectedCurrency,
              onChanged: _changeCurrenct,
            ),
          ),
        ],
      ),
    );
  }
}
