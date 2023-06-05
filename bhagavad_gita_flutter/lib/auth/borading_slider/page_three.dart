import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bhagavad_gita_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'Info.dart';
import 'my_painter.dart';

class MyPageThree extends StatefulWidget {
  const MyPageThree({super.key});

  @override
  State createState() {
    return _MyPageThreeState();
  }
}

class _MyPageThreeState extends State<MyPageThree> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: textColor,
      body: SizedBox(
        child: Stack(
          children: <Widget>[
            Container(
                height: double.infinity,
                decoration: AppUtils.decoration1(),
                child: const MyPainter(textColor)),
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
                        '',
                        style: TextStyle(
                            fontFamily: 'Header',
                            fontSize: SizeConfig.blockSizeHorizontal * 5.2,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1.2,
                            color: const Color(0xff757575)),
                      ),
                      InkWell(
                        onTap: () {
                          context.pushReplacementNamed(RouteNames.main);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            fontFamily: 'Sofia',
                            fontSize: SizeConfig.blockSizeHorizontal * 4.4,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.4,
                            color: textColor,
                          ),
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
                    'assets/images/board3.jpg',
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
                    "Life Lessons",
                    style: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: SizeConfig.blockSizeHorizontal * 5.4,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14),
                  child: Text(
                    "The Voice of the Lord",
                    style: TextStyle(
                      fontFamily: 'Sofia',
                      fontSize: SizeConfig.blockSizeHorizontal * 5.4,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.4,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.blockSizeVertical! * 2),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14,
                      right: SizeConfig.blockSizeHorizontal * 14),
                  child: Text(
                    'The world is perishable and whoever comes to this world surely has to go one day. The soul can never be destroyed. Always remember you are a soul, not a body. Death is just the passing of the soul from the material world to the spirit realm.',
                    style: TextStyle(
                      fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: textColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: SizeConfig.blockSizeVertical! * 13,
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14,
                      right: SizeConfig.blockSizeHorizontal * 14),
                  child: Row(
                    children: <Widget>[
                      CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 1.4,
                        backgroundColor: const Color(0xffE0E0E0),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 1.8,
                        backgroundColor: const Color(0xffB0BEC5),
                      ),
                      SizedBox(
                        width: SizeConfig.blockSizeHorizontal * 4,
                      ),
                      CircleAvatar(
                        radius: SizeConfig.blockSizeHorizontal * 1.4,
                        backgroundColor: const Color(0xffE0E0E0),
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
