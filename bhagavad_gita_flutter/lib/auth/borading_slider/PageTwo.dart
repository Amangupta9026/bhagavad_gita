import 'package:flutter/material.dart';

import 'Info.dart';
import 'MyPainter.dart';

class MyPageTwo extends StatefulWidget {
  @override
  State createState() {
    return _MyPageTwoState();
  }
}

class _MyPageTwoState extends State<MyPageTwo> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(color: Color(0xFFCEE8FF)),
            Container(
              child: MyPainter(Colors.white),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 6,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 6.4,
                      right: SizeConfig.blockSizeHorizontal * 6.4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        ' ',
                        style: TextStyle(
                            fontFamily: 'Header',
                            fontSize: SizeConfig.blockSizeHorizontal * 5.2,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            color: Color(0xff757575)),
                      ),
                      Text(
                        'Skip',
                        style: TextStyle(
                          fontFamily: 'Sofia',
                          fontSize: SizeConfig.blockSizeHorizontal * 4.4,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.4,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical,
                ),
                Center(
                  child: Image.asset(
                    'assets/images/board2.jpg',
                    fit: BoxFit.contain,
                    width: SizeConfig.screenWidth,
                    height: SizeConfig.blockSizeVertical! * 44,
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 4,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14),
                  child: Text(
                    "JOINT WORK",
                    style: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: SizeConfig.blockSizeHorizontal * 5.4,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14),
                  child: Text(
                    "PLATFORM",
                    style: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: SizeConfig.blockSizeHorizontal * 10.4,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14,
                      right: SizeConfig.blockSizeHorizontal * 14),
                  child: Text(
                    "Then, as you begin to further flesh out your speech, you will use supporting materials, like examples, statistics, testimony or a narrative, that back your claims.",
                    style: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 10,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14,
                      right: SizeConfig.blockSizeHorizontal * 14),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 1.8,
                        backgroundColor: Colors.white,
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 1.4,
                        backgroundColor: Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 1.4,
                        backgroundColor: Color(0xffE0E0E0),
                      )
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
