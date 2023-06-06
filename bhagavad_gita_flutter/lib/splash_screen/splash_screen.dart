import 'dart:async';
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
    Timer(const Duration(seconds: 2), () {
      context.pushReplacementNamed(RouteNames.onBoarding);
    });

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
      
               Image.asset('assets/images/splash_video.gif',
                  height: double.infinity,
                  fit: BoxFit.cover),           
            ],
          ),
        ),
       
      ),
    );
  }
}
