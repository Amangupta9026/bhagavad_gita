import 'package:bhagavad_gita_flutter/admin_panel/admin_routes.dart';
import 'package:bhagavad_gita_flutter/auth/sign_in/sign_in_screen.dart';
import 'package:bhagavad_gita_flutter/local/prefs.dart';
import 'package:bhagavad_gita_flutter/notification/notification.dart';
import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/screen/drawer/about_gita_screen.dart';
import 'package:bhagavad_gita_flutter/screen/drawer/help.dart';
import 'package:bhagavad_gita_flutter/screen/drawer/more_app.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/aarti/aarti_screen.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/divine_quotes/divine_quotes.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/ebook/ebook.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/ebook/ebook_detail_screen.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/isFaviorite/my_faviorite_screen.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/video/video_screen.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_screen.dart';
import 'package:bhagavad_gita_flutter/screen/main_screen.dart';
import 'package:bhagavad_gita_flutter/splash_screen/splash_screen.dart';
import 'package:bhagavad_gita_flutter/widget/search_widget.dart';
import 'package:go_router/go_router.dart';

import '../auth/boarding_slider/on_boarding.dart';
import '../local/pref_names.dart';

import '../screen/home_screen/home_page_category/aarti/aarti_view.dart';
import '../screen/home_screen/home_page_category/aarti_book/aarti_book_details.dart';
import '../screen/home_screen/home_page_category/audio/audio service/audio_home_page.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/mahabharat.dart';
import '../screen/home_screen/home_page_category/aarti_book/aarti_book_screen.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/mahabharat_video.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/ramayan/ramayan.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/ramayan/ramayan_video.dart';
import '../screen/home_screen/home_page_category/video/video_view.dart';
import '../screen/home_screen/home_page_category/wallpaper/wallpaper.dart';
import '../screen/home_screen/home_page_category/wallpaper/wallpaper_image.dart';
import '../screen/post/widgets/post_detail_screen.dart';

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
      return const AudioHomePage();
      //AudioScreen();
    },
  ),

  GoRoute(
    path: RouteNames.video,
    name: RouteNames.video,
    builder: (context, state) {
      return VideoScreen();
    },
  ),
  GoRoute(
    path: '/videoView/:title',
    name: RouteNames.videoView,
    builder: (context, state) {
      return VideoView(
        title: state.pathParameters['title'],
      );
    },
  ),
  GoRoute(
    path: RouteNames.aarti,
    name: RouteNames.aarti,
    builder: (context, state) {
      return AartiScreen();
    },
  ),
  GoRoute(
    path: '/aartiBookDetails/:title',
    name: RouteNames.aartiView,
    builder: (context, state) {
      return AartiView(
        title: state.pathParameters['title'],
      );
    },
  ),
  GoRoute(
    path: RouteNames.mahabharat,
    name: RouteNames.mahabharat,
    builder: (context, state) {
      return Mahabharat();
    },
  ),
  GoRoute(
    path: '/mahabharatVideo/:title',
    name: RouteNames.mahabharatVideo,
    builder: (context, state) {
      return MahabharatVideo(
        title: state.pathParameters['title'],
      );
    },
  ),
  GoRoute(
    path: RouteNames.ramayana,
    name: RouteNames.ramayana,
    builder: (context, state) {
      return Ramayana();
    },
  ),
  GoRoute(
    path: '/ramayanaVideo/:title',
    name: RouteNames.ramayanaVideo,
    builder: (context, state) {
      return RamayanaVideo(
        title: state.pathParameters['title'],
      );
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
    path: RouteNames.aartiBook,
    name: RouteNames.aartiBook,
    builder: (context, state) {
      return const ProvachanScreen();
    },
  ),
  GoRoute(
    path: '/aartibookDetail/:title/:description/:image',
    name: RouteNames.aartibookDetail,
    builder: (context, state) {
      return AartiBookDetailScreen(
        title: state.pathParameters['title'],
        description: state.pathParameters['description'],
        image: state.pathParameters['image'],
      );
    },
  ),

  GoRoute(
    path: RouteNames.wallpaper,
    name: RouteNames.wallpaper,
    builder: (context, state) {
      return const WallpaperScreen();
    },
  ),

  GoRoute(
    path: '/wallpaperImage/:url',
    name: RouteNames.wallpaperImage,
    builder: (context, state) {
      // final imageUrl = state.extra as Widget?;

      return WallpaperImage(
        //     imageUrl: imageUrl,
        url: state.pathParameters['url'],
      );
    },
  ),

  GoRoute(
    path: '/postDetailScreen/:url/:caption:/:timeAgo/:postid/:phone',
    name: RouteNames.postDetailScreen,
    builder: (context, state) {
      // final imageUrl = state.extra as Widget?;

      return PostDetailScreen(
        //     imageUrl: imageUrl,
        url: state.pathParameters['url'],
        caption: state.pathParameters['caption'],
        timeAgo: state.pathParameters['timeAgo'],
        postid: state.pathParameters['postid'],
        phone: state.pathParameters['phone'],
      );
    },
  ),

  GoRoute(
    path: RouteNames.favorite,
    name: RouteNames.favorite,
    builder: (context, state) {
      return const MyFavioriteScreen();
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
    path: '/ebookDetail/:title/:description/:image',
    name: RouteNames.ebookDetail,
    builder: (context, state) {
      return EbookDetailScreen(
        title: state.pathParameters['title'],
        description: state.pathParameters['description'] ?? '',
        image: state.pathParameters['image'],
      );
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
   GoRoute(
    path: RouteNames.notification,
    name: RouteNames.notification,
    builder: (context, state) {
      return const NotificationScreen();
    },
  ),

// Admin Routes
  ...adminRoutes,
]);
