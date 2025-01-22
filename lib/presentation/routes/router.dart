import 'package:go_router/go_router.dart';
import 'package:logic_app/presentation/screens/main_screen.dart';

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: MainScreen.routePath,
    builder: (context, state) {
      return MainScreen();
    },
    routes: [
      //item detail
    ],
  ),
]);
