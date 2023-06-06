import 'package:bhagavad_gita_flutter/auth/sign_in/sign_in_screen.dart';
import 'package:bhagavad_gita_flutter/local/prefs.dart';
import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/screen/drawer/help.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_screen.dart';
import 'package:bhagavad_gita_flutter/screen/main_screen.dart';
import 'package:bhagavad_gita_flutter/splash_screen/splash_screen.dart';
import 'package:go_router/go_router.dart';

import '../auth/borading_slider/on_boarding.dart';
import '../local/pref_names.dart';

bool isUserLogin = Prefs.getBool(PrefNames.isLogin) ?? false;

String getInitialRoute() {
  switch (isUserLogin) {
    case false:
      return RouteNames.splashScreen;
    default:
      return RouteNames.splashScreen;
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
  GoRoute(
    path: RouteNames.helpSupport,
    name: RouteNames.helpSupport,
    builder: (context, state) {
      return const HelpSupport();
    },
  ),
  GoRoute(
    path: RouteNames.splashScreen,
    name: RouteNames.splashScreen,
    builder: (context, state) {
      return const SplashScreen();
    },
  ),
   GoRoute(
    path: RouteNames.signInScreen,
    name: RouteNames.signInScreen,
    builder: (context, state) {
      return const SigninScreen();
    },
  ),
]);
