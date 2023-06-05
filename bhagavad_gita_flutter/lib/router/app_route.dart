import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_screen.dart';
import 'package:bhagavad_gita_flutter/screen/main_screen.dart';
import 'package:go_router/go_router.dart';

import '../auth/borading_slider/on_boarding.dart';

bool isUserLogin = true;
//Prefs.getBool(PrefNames.isLogin) ?? false;

String getInitialRoute() {
  switch (isUserLogin) {
    case false:
      return RouteNames.onBoarding;
    default:
      return RouteNames.onBoarding;
  }
}

final appRoute = GoRouter(initialLocation: getInitialRoute(), routes: [
  GoRoute(
    path: RouteNames.onBoarding,
    name: RouteNames.onBoarding,
    builder: (context, state) {
      return const OnBoarding();
    },
  ),
  GoRoute(
    path: RouteNames.main,
    name: RouteNames.main,
    builder: (context, state) {
      return const MainScreen();
    },
  ),
  GoRoute(
    path: RouteNames.home,
    name: RouteNames.home,
    builder: (context, state) {
      return HomeScreen();
    },
  ),
]);
