import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/io_client.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/constants/app_global_key.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/locale/locale_delegate.dart';
import 'package:logic_app/core/service/database_service.dart';
import 'package:logic_app/core/service/onesignal_service.dart';
import 'package:logic_app/core/theme/app_theme.dart';
import 'package:logic_app/presentation/routes/router.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:logic_app/presentation/screens/setting/setting_state.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector();
  await dotenv.load(fileName: ".env");
  OnesignalService().initPlatformState();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
  );
  di.get<DatabaseService>().database;
  HttpOverrides.global = MyHttpOverrides();
  runApp(MultiBlocProvider(providers: [
    BlocProvider(create: (context) => SettingCubit()),
  ], child: LogicApp()));
}

class LogicApp extends StatefulWidget {
  const LogicApp({super.key});

  @override
  State<LogicApp> createState() => _LogicAppState();
}

class _LogicAppState extends State<LogicApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        return MaterialApp.router(
          scaffoldMessengerKey: scaffoldMessengerKey,
          localizationsDelegates: [
            LocaleDelegate(),
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('en', 'US'),
            const Locale('km', 'KH'),
          ],
          locale: Locale('en', 'US'),
          routerConfig: router,
          theme: AppTheme.darkTheme,
          themeMode: state.lightMode ? ThemeMode.light : ThemeMode.dark,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
