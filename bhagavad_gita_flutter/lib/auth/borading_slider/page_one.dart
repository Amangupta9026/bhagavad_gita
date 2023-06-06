import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/utils/utils.dart';
import 'package:go_router/go_router.dart';

import 'Info.dart';
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
      backgroundColor: textColor,
      body: Stack(
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
                        context.pushReplacementNamed(RouteNames.signInScreen);
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
                  'assets/images/board1.jpg',
                  fit: BoxFit.contain,
                  width: SizeConfig.screenWidth,
                  height: SizeConfig.blockSizeVertical! * 40,
                ),
              ),
              SizedBox(
                height: SizeConfig.blockSizeVertical! * 4,
              ),
              Padding(
                padding:
                    EdgeInsets.only(left: SizeConfig.blockSizeHorizontal * 14),
                child: Text(
                  "Lesson of Bhagwavad Gita",
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
                  'The Bhagwavad Gita gives the lesson of harmony of all the other yoga systems with the ultimate goal – surrender to Krishna, known as Bhakti Yoga. Also, we have imbibed the deep knowledge by this Book and the last portion of this book is knows as (Upanishads). The intellectual power we acquired and the knowledge includes in the Upanishads is not only the highest state of human intelligence but also gives us a glimpse of how a man can experience beyond his limits of intellect',
                  style: TextStyle(
                    fontFamily: 'Sofia',
                    fontSize: SizeConfig.blockSizeHorizontal * 3.8,
                    fontWeight: FontWeight.w400,
                    letterSpacing: 0.4,
                    color: textColor,
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
                      radius: SizeConfig.blockSizeHorizontal * 1.4,
                      backgroundColor: const Color(0xffE0E0E0),
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
                      radius: SizeConfig.blockSizeHorizontal * 1.8,
                      backgroundColor: const Color(0xffB0BEC5),
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
