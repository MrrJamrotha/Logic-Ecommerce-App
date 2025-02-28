import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foxShop/core/constants/app_images.dart';
import 'package:foxShop/core/helper/helper.dart';
import 'package:foxShop/core/helper/loading_overlay.dart';
import 'package:foxShop/presentation/global/application/application_cubit.dart';
import 'package:foxShop/presentation/screens/cubit/currency_cubit.dart';
import 'package:foxShop/presentation/widgets/app_bar_widget.dart';
import 'package:foxShop/presentation/widgets/text_widget.dart';

class CurrencyScreen extends StatefulWidget {
  const CurrencyScreen({super.key});
  static const routeName = 'currency';
  static const routePath = '/currency';

  @override
  State<CurrencyScreen> createState() => _CurrencyScreenState();
}

class _CurrencyScreenState extends State<CurrencyScreen> {
  final _selectedCurrency = ValueNotifier("");
  final screenCubit = CurrencyCubit();
  @override
  void initState() {
    super.initState();
    screenCubit.loadInit();
    _initCurrencyCode();
  }

  _initCurrencyCode() {
    var currencyCode = context.read<ApplicationCubit>().state.currencyCode;
    _selectedCurrency.value = currencyCode ?? "USD";
  }

  void _changeCurrenct(String? currencyCode) async {
    try {
      LoadingOverlay.show(context);
      if (currencyCode != null) {
        _selectedCurrency.value = currencyCode;
        context.read<ApplicationCubit>().changeCurrencyCode(currencyCode);
        await screenCubit.changeCurrencyCode(currencyCode);
      }
      LoadingOverlay.hide();
    } catch (e) {
      LoadingOverlay.hide();
      throw Exception(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarWidget(title: 'currency'.tr),
      body: ValueListenableBuilder(
        valueListenable: _selectedCurrency,
        builder: (context, selectedCurrencyValue, child) {
          return Column(
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
                  groupValue: _selectedCurrency.value,
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
                  groupValue: _selectedCurrency.value,
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
                  groupValue: _selectedCurrency.value,
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
                  groupValue: _selectedCurrency.value,
                  onChanged: _changeCurrenct,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
