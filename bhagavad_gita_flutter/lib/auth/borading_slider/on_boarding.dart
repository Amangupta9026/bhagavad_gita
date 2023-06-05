import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'PageOne.dart';
import 'PageThree.dart';
import 'PageTwo.dart';

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
    Container(
      child: MyPageOne(),
    ),
    Container(child: MyPageTwo()),
    Container(
      child: MyPageThree(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: LiquidSwipe(
          pages: pages,
          fullTransitionValue: 500,
          enableLoop: true,
          positionSlideIcon: 0.744,
          waveType: WaveType.liquidReveal,
          slideIconWidget: Icon(
            Icons.arrow_back_ios,
            size: 18,
            color: Color(0xff546E7A),
          ),
          initialPage: 1,
        ),
      ),
    );
  }

  pageChangeCallback(int page) {
    print(page);
  }

  updateTypeCallback(UpdateType updateType) {
    print(updateType);
  }
}
