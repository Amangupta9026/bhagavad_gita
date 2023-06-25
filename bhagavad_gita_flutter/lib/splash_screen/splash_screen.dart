import 'dart:async';
import 'package:bhagavad_gita_flutter/local/pref_names.dart';
import 'package:bhagavad_gita_flutter/local/prefs.dart';
import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:video_player/video_player.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  VideoPlayerController? controller;
  bool visible = false;

  @override
  void initState() {
    isLogin();

    // controller = VideoPlayerController.asset("assets/images/splash_video.gif");
    // controller?.initialize().then((_) {
    //   controller?.setLooping(true);
    //   Timer(const Duration(milliseconds: 10), () {
    //     setState(() {
    //       controller?.play();
    //       visible = true;
    //     });
    //   });
    // });
    super.initState();
  }

  void isLogin() {
    Timer(const Duration(seconds: 2), () {
      if (Prefs.getBool(PrefNames.isLogin) ?? false) {
        context.pushReplacementNamed(RouteNames.main);
      } else {
        context.pushReplacementNamed(RouteNames.onBoarding);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
    controller = null;
  }

  @override
  Widget build(BuildContext context) {
    // getVideoBackground() {
    //   return AnimatedOpacity(
    //     opacity: visible ? 1.0 : 0.0,
    //     duration: const Duration(milliseconds: 10),
    //     child: VideoPlayer(controller ??
    //         VideoPlayerController.asset("assets/images/splash_video.gif")),
    //   );
    // }

    return Material(
      child: Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              // getVideoBackground(),

              Image.asset('assets/images/drawer1.gif',
                  height: double.infinity, fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}
