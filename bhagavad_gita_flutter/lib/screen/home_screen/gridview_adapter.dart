import 'dart:developer';

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/global_admin_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../utils/file_collection.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String? title;
  final IconData? icon;
//  final bool isEnable = adminList.contains(FirebaseAuth.instance.currentUser?.phoneNumber);
}

List<Choice> choices = <Choice>[
  const Choice(title: 'E-Books\nPioneer', icon: Icons.auto_stories),
  const Choice(title: 'Audio\nRhyme', icon: Icons.music_note),
  const Choice(title: 'Video\nCollecion', icon: Icons.video_library),
  const Choice(title: 'Bhakti\nAarti', icon: Icons.music_note),
  const Choice(title: 'Mahabharat\nStory', icon: Icons.sports_kabaddi),
  const Choice(title: 'Ramayana\nStory', icon: Icons.volunteer_activism),
  const Choice(title: 'Divine\nQuotes', icon: Icons.stars),
  const Choice(title: 'Aarti\nBook', icon: Icons.menu_book),
  const Choice(title: 'Divine\nWallpaper', icon: Icons.photo_library),
  const Choice(title: 'Admin\nPanel', icon: Icons.admin_panel_settings),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, this.choice}) : super(key: key);
  final Choice? choice;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: choice?.title == 'Admin Panel'
          ? adminList.contains(FirebaseAuth.instance.currentUser?.phoneNumber)
          : true,
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: const BoxDecoration(
            border: Border(
          right: BorderSide(
            width: 1.2,
            color: Colors.white,
            // color: Colors.grey.shade300,
          ),
          bottom: BorderSide(
            width: 1.2,
            color: Colors.white,
          ),
        )),
        child: InkWell(
          onTap: () {
            log(FirebaseAuth.instance.currentUser?.phoneNumber.toString() ??
                "");
            if (choice?.title == 'E-Books\nPioneer') {
              context.pushNamed(RouteNames.ebook);
            } else if (choice?.title == 'Audio\nRhyme') {
              context.pushNamed(RouteNames.audio);
            } else if (choice?.title == 'Video\nCollecion') {
              context.pushNamed(RouteNames.video);
            } else if (choice?.title == 'Bhakti\nAarti') {
              context.pushNamed(RouteNames.aarti);
            } else if (choice?.title == 'Mahabharat\nStory') {
              context.pushNamed(RouteNames.mahabharat);
            } else if (choice?.title == 'Ramayana\nStory') {
              context.pushNamed(RouteNames.ramayana);
            } else if (choice?.title == 'Divine\nQuotes') {
              context.pushNamed(RouteNames.quotes);
            } else if (choice?.title == 'Aarti\nBook') {
              context.pushNamed(RouteNames.aartiBook);
            } else if (choice?.title == 'Divine\nWallpaper') {
              context.pushNamed(RouteNames.wallpaper);
            } else if (adminList
                    .contains(FirebaseAuth.instance.currentUser?.phoneNumber) &&
                choice?.title == 'Admin\nPanel') {
              context.pushNamed(RouteNames.adminPanel);
            } else {}
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Center(
                          child: Icon(choice?.icon,
                              size: 30.0, color: Colors.black),
                        )),
                    Center(
                      child: Text(choice?.title ?? '',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              color: textColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15)),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
