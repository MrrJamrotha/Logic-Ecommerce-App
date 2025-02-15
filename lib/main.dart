import 'dart:convert';
import 'dart:io';

import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
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
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  //setup (DI depenecy injection)
  setupInjector();

  //initialize environment
  await dotenv.load(fileName: ".env");

  //initialize locale delegate
  final byteskey = sha256
      .convert(utf8.encode(dotenv.env['PASSWORD_HYDRATED'].toString()))
      .bytes;

  //initialize hydrated bloc
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorageDirectory.web
        : HydratedStorageDirectory((await getTemporaryDirectory()).path),
    encryptionCipher: HydratedAesCipher(byteskey),
  );

  //initialize database sql
  di.get<DatabaseService>().database;

  HttpOverrides.global = MyHttpOverrides();

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
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

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
            Locale("af"),
            Locale("am"),
            Locale("ar"),
            Locale("az"),
            Locale("be"),
            Locale("bg"),
            Locale("bn"),
            Locale("bs"),
            Locale("ca"),
            Locale("cs"),
            Locale("da"),
            Locale("de"),
            Locale("el"),
            Locale("en", 'US'),
            Locale("es"),
            Locale("et"),
            Locale("fa"),
            Locale("fi"),
            Locale("fr"),
            Locale("gl"),
            Locale("ha"),
            Locale("he"),
            Locale("hi"),
            Locale("hr"),
            Locale("hu"),
            Locale("hy"),
            Locale("id"),
            Locale("is"),
            Locale("it"),
            Locale("ja"),
            Locale("ka"),
            Locale("kk"),
            Locale("km", 'KH'),
            Locale("ko"),
            Locale("ku"),
            Locale("ky"),
            Locale("lt"),
            Locale("lv"),
            Locale("mk"),
            Locale("ml"),
            Locale("mn"),
            Locale("ms"),
            Locale("nb"),
            Locale("nl"),
            Locale("nn"),
            Locale("no"),
            Locale("pl"),
            Locale("ps"),
            Locale("pt"),
            Locale("ro"),
            Locale("ru"),
            Locale("sd"),
            Locale("sk"),
            Locale("sl"),
            Locale("so"),
            Locale("sq"),
            Locale("sr"),
            Locale("sv"),
            Locale("ta"),
            Locale("tg"),
            Locale("th"),
            Locale("tk"),
            Locale("tr"),
            Locale("tt"),
            Locale("uk"),
            Locale("ug"),
            Locale("ur"),
            Locale("uz"),
            Locale("vi"),
            Locale("zh")
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
