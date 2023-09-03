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
import '../auth/sign_in/sign_in_otp_screen.dart';
import '../local/pref_names.dart';

import '../screen/home_screen/home_page_category/aarti/aarti_view.dart';
import '../screen/home_screen/home_page_category/aarti_book/aarti_book_details.dart';
import '../screen/home_screen/home_page_category/audio/audio service/audio_home_page.dart';
import '../screen/home_screen/home_page_category/gita_updesh/gita_updesh.dart';
import '../screen/home_screen/home_page_category/gita_updesh/gita_updesh_video.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/mahabharat.dart';
import '../screen/home_screen/home_page_category/aarti_book/aarti_book_screen.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/mahabharat_video.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/ramayan/ramayan.dart';
import '../screen/home_screen/home_page_category/mahabharat_Ramayana/ramayan/ramayan_video.dart';
import '../screen/home_screen/home_page_category/mahadev/mahadev.dart';
import '../screen/home_screen/home_page_category/mahadev/mahadev_video.dart';
import '../screen/home_screen/home_page_category/video/video_view.dart';
import '../screen/home_screen/home_page_category/wallpaper/wallpaper_demo.dart';
import '../screen/home_screen/home_page_category/wallpaper/wallpaper_image.dart';
import '../screen/post/widgets/post_detail_screen.dart';
import '../utils/file_collection.dart';

bool isUserLogin = Prefs.getBool(PrefNames.isLogin) ?? false;

CustomTransitionPage buildPageWithDefaultTransition<T>({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
  Offset? begin,
}) {
  return CustomTransitionPage<T>(
    fullscreenDialog: true,
    transitionDuration: const Duration(seconds: 1),
    key: state.pageKey,
    child: child,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return SlideTransition(
        position: Tween<Offset>(
          begin: begin ?? const Offset(0.1, 0.1),
          end: Offset.zero,
        ).animate(animation),
        child: child,
      );
    },

    //   FadeTransition(opacity: animation, child: child),
  );
}

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
    path: '/otpScreen/:mobileNumber/:verificationId/:resendToken',
    name: RouteNames.otpScreen,
    builder: (context, state) {
      return OTPScreen(
          mobileNumber: state.pathParameters['mobileNumber'] ?? '',
          verificationId: state.pathParameters['verificationId'] ?? '',
          resendToken: state.pathParameters['resendToken']);
    },
  ),

  GoRoute(
    path: RouteNames.main,
    name: RouteNames.main,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: const MainScreen(),
    ),
  ),
  GoRoute(
    path: RouteNames.home,
    name: RouteNames.home,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: HomeScreen(),
    ),
    // builder: (context, state) {
    //   return HomeScreen();
    // },
  ),
  GoRoute(
    path: RouteNames.helpSupport,
    name: RouteNames.helpSupport,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: const HelpSupport(),
    ),
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
      }),
  GoRoute(
    path: RouteNames.ebook,
    name: RouteNames.ebook,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: const EbookScreen(),
    ),

    // builder: (context, state) {
    //   return const EbookScreen();
    // },
  ),
  GoRoute(
    path: RouteNames.audio,
    name: RouteNames.audio,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: const AudioHomePage(),
    ),
  ),

  GoRoute(
    path: RouteNames.video,
    name: RouteNames.video,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
      context: context,
      state: state,
      child: VideoScreen(),
    ),
  ),
  GoRoute(
    path: '/videoView/:title',
    name: RouteNames.videoView,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: VideoView(
          title: state.pathParameters['title'],
        )),

    // builder: (context, state) {
    //   return VideoView(
    //     title: state.pathParameters['title'],
    //   );
    // },
  ),
  GoRoute(
    path: RouteNames.aarti,
    name: RouteNames.aarti,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: AartiScreen()),
  ),
  GoRoute(
    path: '/aartiBookDetails/:title',
    name: RouteNames.aartiView,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: AartiView(
          title: state.pathParameters['title'],
        )),
  ),
  GoRoute(
    path: RouteNames.mahabharat,
    name: RouteNames.mahabharat,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: Mahabharat()),
  ),
  GoRoute(
    path: '/mahabharatVideo/:title',
    name: RouteNames.mahabharatVideo,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: MahabharatVideo(
          title: state.pathParameters['title'],
        )),
  ),
  GoRoute(
    path: RouteNames.ramayana,
    name: RouteNames.ramayana,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: Ramayana()),
  ),
  GoRoute(
    path: '/ramayanaVideo/:title',
    name: RouteNames.ramayanaVideo,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: RamayanaVideo(
          title: state.pathParameters['title'],
        )),
  ),

  GoRoute(
    path: RouteNames.mahadev,
    name: RouteNames.mahadev,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: MahaDev()),
  ),
  GoRoute(
    path: '/mahadevVideo/:title',
    name: RouteNames.mahadevVideo,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: MahaDevVideo(
          title: state.pathParameters['title'],
        )),
  ),

  GoRoute(
    path: RouteNames.gitaUpdesh,
    name: RouteNames.gitaUpdesh,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: GitaUpdesh()),
  ),

  GoRoute(
    path: '/gitaUpdesh/:title',
    name: RouteNames.gitaUpdeshVideo,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: GitaUpdeshVideo(
          title: state.pathParameters['title'],
        )),
  ),

  GoRoute(
    path: RouteNames.quotes,
    name: RouteNames.quotes,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: const DivineQuotes()),
  ),
  GoRoute(
    path: RouteNames.aartiBook,
    name: RouteNames.aartiBook,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: const ProvachanScreen()),
  ),
  GoRoute(
    path: '/aartibookDetail/:title/:description/:image',
    name: RouteNames.aartibookDetail,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: AartiBookDetailScreen(
          title: state.pathParameters['title'],
          description: state.pathParameters['description'],
          image: state.pathParameters['image'],
        )),
  ),

  GoRoute(
    path: RouteNames.wallpaper,
    name: RouteNames.wallpaper,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: const WallpaperDemo()),
  ),

  GoRoute(
    path: '/wallpaperImage/:url',
    name: RouteNames.wallpaperImage,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: WallpaperImage(
          //     imageUrl: imageUrl,
          url: state.pathParameters['url'],
        )),
  ),

  GoRoute(
    path: '/postDetailScreen/:url/:caption:/:timeAgo/:postid/:phone',
    name: RouteNames.postDetailScreen,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: PostDetailScreen(
          url: state.pathParameters['url'],
          caption: state.pathParameters['caption'],
          timeAgo: state.pathParameters['timeAgo'],
          postid: state.pathParameters['postid'],
          phone: state.pathParameters['phone'],
        )),
  ),

  GoRoute(
    path: RouteNames.favorite,
    name: RouteNames.favorite,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: const MyFavioriteScreen()),
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
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context,
        state: state,
        child: EbookDetailScreen(
          title: state.pathParameters['title'],
          description: state.pathParameters['description'] ?? '',
          image: state.pathParameters['image'],
        )),
  ),
  GoRoute(
    path: RouteNames.aboutGita,
    name: RouteNames.aboutGita,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: const AboutGitaScreen()),
  ),
  GoRoute(
    path: RouteNames.moreApps,
    name: RouteNames.moreApps,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: const MoreApps()),
  ),
  GoRoute(
    path: RouteNames.notification,
    name: RouteNames.notification,
    pageBuilder: (context, state) => buildPageWithDefaultTransition<void>(
        context: context, state: state, child: const NotificationScreen()),
  ),

// Admin Routes
  ...adminRoutes,
]);
