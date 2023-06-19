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

const List<Choice> choices = <Choice>[
  Choice(title: 'E-Books', icon: Icons.copy),
  Choice(title: 'Audio', icon: Icons.music_note),
  Choice(title: 'Video', icon: Icons.video_call),
  Choice(title: 'Aarti', icon: Icons.music_note),
  Choice(title: 'Mahabharat Story', icon: Icons.diamond),
  Choice(title: 'Ramayana Story', icon: Icons.video_library),
  Choice(title: 'Divine Quotes', icon: Icons.note),
  Choice(title: 'Articles', icon: Icons.article),
  Choice(title: 'Wallpaper', icon: Icons.wallpaper),
  Choice(title: 'Admin Panel', icon: Icons.admin_panel_settings),
];

class SelectCard extends StatelessWidget {
  const SelectCard({Key? key, this.choice}) : super(key: key);
  final Choice? choice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
      decoration: BoxDecoration(
          border: Border(
        right: BorderSide(
          width: 1.2,
          color: Colors.grey.shade300,
        ),
        bottom: BorderSide(
          width: 1.2,
          color: Colors.grey.shade300,
        ),
      )),
      child: InkWell(
        onTap: () {
          log(FirebaseAuth.instance.currentUser?.phoneNumber.toString() ?? "");
          if (choice?.title == 'E-Books') {
            context.pushNamed(RouteNames.ebook);
          } else if (choice?.title == 'Audio') {
            context.pushNamed(RouteNames.audio);
          } else if (choice?.title == 'Video') {
            context.pushNamed(RouteNames.video);
          } else if (choice?.title == 'Aarti') {
            context.pushNamed(RouteNames.aarti);
          } else if (choice?.title == 'Mahabharat Story') {
            context.pushNamed(RouteNames.mahabharat);
          } else if (choice?.title == 'Ramayana Story') {
            context.pushNamed(RouteNames.ramayana);
          } else if (choice?.title == 'Divine Quotes') {
            context.pushNamed(RouteNames.quotes);
          } else if (choice?.title == 'Articles') {
            context.pushNamed(RouteNames.articles);
          } else if (choice?.title == 'Wallpaper') {
            context.pushNamed(RouteNames.wallpaper);
          } else if (adminList
                  .contains(FirebaseAuth.instance.currentUser?.phoneNumber) &&
              choice?.title == 'Admin Panel') {
            context.pushNamed(RouteNames.adminPanel);
          } else {}
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                      child:
                          Icon(choice?.icon, size: 40.0, color: primaryColor)),
                  Text(choice?.title ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15)),
                ]),
          ),
        ),
      ),
    );
  }
}
