import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:logic_app/core/di/injection.dart';
import 'package:logic_app/core/theme/app_theme.dart';
import 'package:logic_app/presentation/routes/router.dart';
import 'package:logic_app/presentation/screens/setting/setting_cubit.dart';
import 'package:logic_app/presentation/screens/setting/setting_state.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  setup();
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory(
      (await getTemporaryDirectory()).path,
    ),
  );
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
          routerConfig: router,
          theme: AppTheme.darkTheme,
          themeMode: state.lightMode ? ThemeMode.light : ThemeMode.dark,
          darkTheme: AppTheme.darkTheme,
        );
      },
    );
  }
}
