import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/utils/utils.dart';
import 'package:go_router/go_router.dart';

import '../../router/routes_names.dart';
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
      bottomNavigationBar: Container(
        height: 50,
        decoration: AppUtils.decoration1(),
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.blockSizeHorizontal * 14,
              right: SizeConfig.blockSizeHorizontal * 14),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: [
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
                  ),
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
                    )),
              )
            ],
          ),
        ),
      ),
      body: SafeArea(
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
                    'assets/images/board6.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // height: MediaQuery.of(context).size.height / 3.6,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockSizeHorizontal * 14),
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
                const SizedBox(height: 20),
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
