import 'package:bhagavad_gita_flutter/auth/boarding_slider/on_boarding.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/home_screen.dart';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../in_app_update/in_app_update.dart';
import '../notification/push_notification/firebase_messaging.dart';
import '../riverpod/page_index_selector.dart';
import '../utils/file_collection.dart';
import 'ai_chat.dart';
import 'post/screens/post_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget page(index) {
    switch (index) {
      case 0:
        return HomeScreen();
      case 1:
        return const PostScreen();
      case 2:
        return const AiChatScreen();
      case 3:
        return const OnBoarding();
      default:
        return HomeScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    Messaging.showMessage();
    UpdateChecker.checkForUpdate();
    return Consumer(builder: (context, ref, child) {
      final refRead = ref.read(pageIndexNotifierProvider.notifier);
      final refWatch = ref.watch(pageIndexNotifierProvider);
      return Scaffold(
        bottomNavigationBar: BottomBarDoubleBullet(
          selectedIndex: refWatch.value!.indexValue,
          color: primaryColor,
          backgroundColor: Colors.white,
          items: [
            BottomBarItem(iconData: CupertinoIcons.home),
            BottomBarItem(
              iconData: MdiIcons.commentOutline,
            ),
            BottomBarItem(
              iconData: CupertinoIcons.chat_bubble_text,
            ),
            BottomBarItem(iconData: CupertinoIcons.person),
          ],
          onSelect: (index) {
            refRead.changeIndex(index);
          },
        ),
        body: page(refWatch.value!.indexValue),
      );
    });
  }
}
