import 'package:bhagavad_gita_flutter/admin_panel/admin_routes.dart';
import 'package:bhagavad_gita_flutter/auth/sign_in/sign_in_screen.dart';
import 'package:bhagavad_gita_flutter/local/prefs.dart';
import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/screen/drawer/about_gita_screen.dart';
import 'package:bhagavad_gita_flutter/screen/drawer/help.dart';
import 'package:bhagavad_gita_flutter/screen/drawer/more_app.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/aarti/aarti_screen.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/divine_quotes/divine_quotes.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/ebook/ebook.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/ebook/ebook_detail_screen.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/video/video_screen.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_screen.dart';
import 'package:bhagavad_gita_flutter/screen/main_screen.dart';
import 'package:bhagavad_gita_flutter/splash_screen/splash_screen.dart';
import 'package:bhagavad_gita_flutter/widget/search_widget.dart';
import 'package:go_router/go_router.dart';

import '../auth/borading_slider/on_boarding.dart';
import '../local/pref_names.dart';
import '../screen/home_screen/home_page_category/audio/audio.dart';

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
  GoRoute(
    path: RouteNames.ebook,
    name: RouteNames.ebook,
    builder: (context, state) {
      return const EbookScreen();
    },
  ),
  GoRoute(
    path: RouteNames.audio,
    name: RouteNames.audio,
    builder: (context, state) {
      return const AudioScreen();
    },
  ),
  GoRoute(
    path: RouteNames.video,
    name: RouteNames.video,
    builder: (context, state) {
      return const VideoScreen();
    },
  ),
  GoRoute(
    path: RouteNames.aarti,
    name: RouteNames.aarti,
    builder: (context, state) {
      return const AartiScreen();
    },
  ),
  GoRoute(
    path: RouteNames.quotes,
    name: RouteNames.quotes,
    builder: (context, state) {
      return const DivineQuotes();
    },
  ),
  GoRoute(
    path: RouteNames.articles,
    name: RouteNames.articles,
    builder: (context, state) {
      return const DivineQuotes();
    },
  ),
  GoRoute(
    path: RouteNames.wallpaper,
    name: RouteNames.wallpaper,
    builder: (context, state) {
      return const DivineQuotes();
    },
  ),
  GoRoute(
    path: RouteNames.favorite,
    name: RouteNames.favorite,
    builder: (context, state) {
      return const DivineQuotes();
    },
  ),
  GoRoute(
    path: RouteNames.search,
    name: RouteNames.search,
    builder: (context, state) {
      return const SearchItemTextField();
    },
  ),
  GoRoute(
    path: RouteNames.ebookDetail,
    name: RouteNames.ebookDetail,
    builder: (context, state) {
      return const EbookDetailScreen();
    },
  ),
  GoRoute(
    path: RouteNames.aboutGita,
    name: RouteNames.aboutGita,
    builder: (context, state) {
      return const AboutGitaScreen();
    },
  ),
  GoRoute(
    path: RouteNames.moreApps,
    name: RouteNames.moreApps,
    builder: (context, state) {
      return const MoreApps();
    },
  ),


// Admin Routes
  ...adminRoutes,

]);
