import 'dart:async';
import 'dart:io';

import 'package:audio_service/audio_service.dart';
import 'package:bhagavad_gita_flutter/firebase_options.dart';
import 'package:bhagavad_gita_flutter/riverpod/darktheme_notifier.dart';
import 'package:bhagavad_gita_flutter/router/app_route.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/audio/audio%20service/audioplayer.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/audio/audio%20service/audio_service.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_page_category/audio/config.dart';
import 'package:bhagavad_gita_flutter/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:path_provider/path_provider.dart';



import 'local/prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Hive.initFlutter();

  await openHiveBox('settings');
  await openHiveBox('downloads');
  await openHiveBox('Favorite Songs');
  await openHiveBox('ytlinkcache', limit: true);

  //   if (Platform.isAndroid) {
  //   setOptimalDisplayMode();
  // }

  await startService();
  await Prefs.init();
  runApp(const ProviderScope(child: MyApp()));
}

Future<void> openHiveBox(String boxName, {bool limit = false}) async {
  final box = await Hive.openBox(boxName).onError((error, stackTrace) async {
   // Logger.root.severe('Failed to open $boxName Box', error, stackTrace);
    final Directory dir = await getApplicationDocumentsDirectory();
    final String dirPath = dir.path;
    File dbFile = File('$dirPath/$boxName.hive');
    File lockFile = File('$dirPath/$boxName.lock');
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      dbFile = File('$dirPath/BlackHole/$boxName.hive');
      lockFile = File('$dirPath/BlackHole/$boxName.lock');
    }
    await dbFile.delete();
    await lockFile.delete();
    await Hive.openBox(boxName);
    throw 'Failed to open $boxName Box\nError: $error';
  });
  // clear box if it grows large
  if (limit && box.length > 500) {
    box.clear();
  }
}

// Future<void> setOptimalDisplayMode() async {
//   await FlutterDisplayMode.setHighRefreshRate();
  
// }

Future<void> startService() async {
//  await initializeLogging();
  MetadataGod.initialize();
  final AudioPlayerHandler audioHandler = await AudioService.init(
    builder: () => AudioPlayerHandlerImpl(),
    config: AudioServiceConfig(
     androidNotificationChannelId: 'com.shadow.blackhole.channel.audio',
      androidNotificationChannelName: 'Bhagwavad Gita',
     androidNotificationIcon: 'drawable/ic_stat_music_note',
      androidShowNotificationBadge: true,
      androidStopForegroundOnPause: false,
      // Hive.box('settings').get('stopServiceOnPause', defaultValue: true) as bool,
      notificationColor: Colors.grey[900],
    ),
  );
 GetIt.I.registerSingleton<AudioPlayerHandler>(audioHandler);
 GetIt.I.registerSingleton<MyTheme>(MyTheme());
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

@override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Bhagwavad Gita',
        darkTheme: ThemeData.light(),
        themeMode: ref.watch(themeNotifierProvider).value,
        theme: themeData,
        routerConfig: appRoute,
        builder: EasyLoading.init(),
      );
    });
  }
}
