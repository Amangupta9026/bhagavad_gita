import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bhagavad_gita_flutter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'info.dart';
import 'my_painter.dart';

class MyPageTwo extends StatefulWidget {
  const MyPageTwo({super.key});

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
                    radius: SizeConfig.blockSizeHorizontal * 1.4,
                    backgroundColor: const Color(0xffE0E0E0),
                  ),
                  SizedBox(
                    width: SizeConfig.blockSizeHorizontal * 4,
                  ),
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
        ),
      ),
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
                      'assets/images/board3.png',
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30),
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
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
