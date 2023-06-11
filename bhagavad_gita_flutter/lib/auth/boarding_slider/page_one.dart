import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bhagavad_gita_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'info.dart';
import 'my_painter.dart';


class MyPageOne extends StatefulWidget {
  const MyPageOne({super.key});

  @override
  State createState() {
    return _MyPageOneState();
  }
}

class _MyPageOneState extends State<MyPageOne> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      bottomNavigationBar: Container(
          height: 50,
          decoration: AppUtils.decoration1(),
          child: Padding(
            padding: EdgeInsets.only(
                left: SizeConfig.blockSizeHorizontal * 14,
                right: SizeConfig.blockSizeHorizontal * 14),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: <Widget>[
                    CircleAvatar(
                      radius: SizeConfig.blockSizeHorizontal * 1.8,
                      backgroundColor: textColor,
                    ),
                    SizedBox(
                      width: SizeConfig.blockSizeHorizontal * 4,
                    ),
                    CircleAvatar(
                      radius: SizeConfig.blockSizeHorizontal * 1.4,
                      backgroundColor: const Color(0xffE0E0E0),
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
                InkWell(
                  onTap: () {
                    context.pushReplacementNamed(RouteNames.signInScreen);
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 0, 15, 0),
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
                  ),
                )
              ],
            ),
          )),
      body: SafeArea(
        child: SizedBox(
          child: Stack(
            children: <Widget>[
              Container(
                  height: double.infinity,
                  decoration: AppUtils.decoration1(),
                  child: const MyPainter(textColor)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/board2.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 14),
                    child: Text(
                      "Bhagwavad Gita",
                      style: TextStyle(
                        fontFamily: 'Sofia',
                        fontSize: SizeConfig.blockSizeHorizontal * 5.4,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.4,
                        color: textColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 20),
                  Padding(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockSizeHorizontal * 14,
                        right: SizeConfig.blockSizeHorizontal * 14),
                    child: Text(
                      '“Krishna says: "Arjuna, I am the taste of pure water and the radiance of the sun and moon. I am the sacred word and the sound heard in air, and the courage of human beings. I am the sweet fragrance in the earth and the radiance of fire; I am the life in every creature and the striving of the spiritual aspirant”',
                      style: TextStyle(
                        fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 0.4,
                        color: textColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
