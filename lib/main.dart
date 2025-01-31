import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/constants/app_global_key.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/locale/locale_delegate.dart';
import 'package:logic_app/core/service/database_service.dart';
import 'package:logic_app/core/service/onesignal_service.dart';
import 'package:logic_app/core/theme/app_theme.dart';
import 'package:logic_app/presentation/global/application/application_cubit.dart';
import 'package:logic_app/presentation/global/application/application_state.dart';
import 'package:logic_app/presentation/routes/router.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupInjector();
  await dotenv.load(fileName: ".env");

  final byteskey = sha256
      .convert(utf8.encode(dotenv.env['PASSWORD_HYDRATED'].toString()))
      .bytes;

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    encryptionCipher: HydratedAesCipher(byteskey),
  );
  di.get<DatabaseService>().database;
  HttpOverrides.global = MyHttpOverrides();
  // HydratedBloc.storage = di.get<SecureStorageService>();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ApplicationCubit()..loadInitialData(),
        ),
        BlocProvider(create: (context) => SettingCubit()),
      ],
      child: LogicApp(),
    ),
  );
}

class LogicApp extends StatefulWidget {
  const LogicApp({super.key});

  @override
  State<LogicApp> createState() => _LogicAppState();
}

class _LogicAppState extends State<LogicApp> {
  @override
  Widget build(BuildContext context) {
    final router = MainRouter.createRouter(context);
    OnesignalService(router: router).initPlatformState();
    return BlocBuilder<ApplicationCubit, ApplicationState>(
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
          debugShowCheckedModeBanner: false,
          routerConfig: MainRouter.createRouter(context),
          theme: AppTheme.darkTheme,
          themeMode: state.isDarkModeTheme ? ThemeMode.dark : ThemeMode.light,
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
