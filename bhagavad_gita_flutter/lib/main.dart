import 'package:bhagavad_gita_client/bhagavad_gita_client.dart';
import 'package:bhagavad_gita_flutter/router/app_route.dart';
import 'package:bhagavad_gita_flutter/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_flutter/serverpod_flutter.dart';


var client = Client('http://localhost:8080/')
  ..connectivityMonitor = FlutterConnectivityMonitor();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await Prefs.init();
  

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'QWise',
      theme: themeData,
      routerConfig: appRoute,
      // builder: EasyLoading.init(),
    );
  }
}
