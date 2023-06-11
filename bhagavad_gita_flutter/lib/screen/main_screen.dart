import 'package:bhagavad_gita_flutter/auth/boarding_slider/on_boarding.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_screen.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/cupertino.dart';
import '../notification/push_notification/firebase_messaging.dart';
import '../utils/file_collection.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget page(index) {
    switch (index) {
      case 0:
        return  HomeScreen();
      case 1:
        return  HomeScreen();
      case 2:
        return const OnBoarding();
      case 3:
        return const OnBoarding();
      default:
        return const OnBoarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    Messaging.showMessage();
   // UpdateChecker.checkForUpdate();
    return Scaffold(
      bottomNavigationBar: BottomBarDoubleBullet(
        selectedIndex: 0,
        color: primaryColor,
        backgroundColor: Colors.white,
        items: [
          BottomBarItem(iconData: CupertinoIcons.home),
          BottomBarItem(
            iconData: CupertinoIcons.play_circle,
          ),
          BottomBarItem(
            iconData: CupertinoIcons.chat_bubble_text,
          ),
          BottomBarItem(iconData: CupertinoIcons.person),
        ],
        onSelect: (index) {
          // ref.changeIndex(index);
        },
      ),
      body: page(0),
    );
  }
}
