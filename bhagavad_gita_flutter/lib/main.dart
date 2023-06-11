import 'package:bhagavad_gita_flutter/firebase_options.dart';
import 'package:bhagavad_gita_flutter/riverpod/darktheme_notifier.dart';
import 'package:bhagavad_gita_flutter/router/app_route.dart';
import 'package:bhagavad_gita_flutter/utils/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'local/prefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await Prefs.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
