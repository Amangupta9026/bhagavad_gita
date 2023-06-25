import 'package:bhagavad_gita_flutter/admin_panel/admin_screen/admin_aarti.dart';
import 'package:bhagavad_gita_flutter/admin_panel/admin_screen/admin_divine_quotes.dart';
import 'package:bhagavad_gita_flutter/admin_panel/admin_screen/admin_more_apps.dart';
import 'package:bhagavad_gita_flutter/admin_panel/admin_screen/admin_panel.dart';
import 'package:bhagavad_gita_flutter/admin_panel/admin_screen/admin_video.dart';
import 'package:bhagavad_gita_flutter/admin_panel/admin_screen/admin_wallpaper.dart';
import 'package:go_router/go_router.dart';

import '../router/routes_names.dart';
import 'admin_screen/admin_ebook.dart';
import 'admin_screen/admin_panel_homepage.dart/admin_aarti_book.dart';
import 'admin_screen/admin_panel_homepage.dart/admin_mahabharat.dart';
import 'admin_screen/admin_panel_homepage.dart/admin_ramayan.dart';

final List<RouteBase> adminRoutes = [
  GoRoute(
    path: RouteNames.adminPanel,
    name: RouteNames.adminPanel,
    builder: (context, state) {
      return const AdminPanel();
    },
  ),

  GoRoute(
    path: RouteNames.adminEbook,
    name: RouteNames.adminEbook,
    builder: (context, state) {
      return const AdminEbook();
    },
  ),
  GoRoute(
    path: RouteNames.adminAudio,
    name: RouteNames.adminAudio,
    builder: (context, state) {
      return const AdminAarti();
    },
  ),
  GoRoute(
    path: RouteNames.adminVideo,
    name: RouteNames.adminVideo,
    builder: (context, state) {
      return const AdminVideo();
    },
  ),
  GoRoute(
    path: RouteNames.adminAarti,
    name: RouteNames.adminAarti,
    builder: (context, state) {
      return const AdminAarti();
    },
  ),

  GoRoute(
    path: RouteNames.adminMahabharat,
    name: RouteNames.adminMahabharat,
    builder: (context, state) {
      return const AdminMahabharat();
    },
  ),
  GoRoute(
    path: RouteNames.adminRamayana,
    name: RouteNames.adminRamayana,
    builder: (context, state) {
      return const AdminRamayan();
    },
  ),

  GoRoute(
    path: RouteNames.adminQuotes,
    name: RouteNames.adminQuotes,
    builder: (context, state) {
      return const AdminQuotes();
    },
  ),

  GoRoute(
    path: RouteNames.adminAartiBook,
    name: RouteNames.adminAartiBook,
    builder: (context, state) {
      return const AdminAartiBook();
    },
  ),
  GoRoute(
    path: RouteNames.adminWallpaper,
    name: RouteNames.adminWallpaper,
    builder: (context, state) {
      return const AdminWallpaper();
    },
  ),

  GoRoute(
    path: RouteNames.adminMoreApps,
    name: RouteNames.adminMoreApps,
    builder: (context, state) {
      return const AdminMoreApps();
    },
  ),

  // GoRoute(
  //   path: RouteNames.sendNotificationFromAdmin,
  //   name: RouteNames.sendNotificationFromAdmin,
  //   builder: (context, state) {
  //     return const SendNotificationFromAdmin();
  //   },
  // ),
];
