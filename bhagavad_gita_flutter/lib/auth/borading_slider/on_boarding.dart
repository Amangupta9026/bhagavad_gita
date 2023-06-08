import 'dart:developer';

import 'package:bhagavad_gita_flutter/auth/borading_slider/page_three.dart';
import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'page_two.dart';
import 'page_one.dart';

// ignore: must_be_immutable
class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  int page = 0;
  UpdateType? updateType;

  final pages = [
    const SizedBox(child: MyPageOne()),
    const SizedBox(child: MyPageOne()),
    const SizedBox(child: MyPageTwo()),
    const SizedBox(child: MyPageThree()),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          fullTransitionValue: 900,
          enableLoop: true,
          positionSlideIcon: 0.650,
          waveType: WaveType.liquidReveal,
          slideIconWidget: const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: Color(0xff546E7A),
            ),
          ),
          initialPage: 1,
        ),
      ),
    );
  }

  pageChangeCallback(int page) {
    log(page.toString());
  }

  updateTypeCallback(UpdateType updateType) {
    log(updateType.toString());
  }
}
