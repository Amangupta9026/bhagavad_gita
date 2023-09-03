import 'dart:developer';
import 'dart:ui' as ui;

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/global_admin_list.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';

import '../../utils/file_collection.dart';
import '../../widget/gradient_text_view.dart';

class Choice {
  const Choice({this.title, this.icon});
  final String? title;
  final IconData? icon;
}

List<Choice> choices = <Choice>[
  const Choice(title: 'E-Books\nPioneer', icon: Icons.auto_stories),
  const Choice(title: 'Audio\nRhyme', icon: Icons.music_note),
  const Choice(title: 'Video\nCollection', icon: Icons.video_library),
  const Choice(title: 'Bhakti\nAarti', icon: Icons.music_note),
  const Choice(title: 'Mahabharat Story', icon: Icons.sports_kabaddi),
  const Choice(title: 'Ramayana Story', icon: Icons.volunteer_activism),
  const Choice(title: 'MahaDev Story', icon: Icons.diversity_1),
  const Choice(title: 'Gita\nUpdesh', icon: Icons.diversity_2),
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
      visible: choice?.title == 'Admin\nPanel'
          ? adminList.contains(FirebaseAuth.instance.currentUser?.phoneNumber)
          : true,
      child: Container(
        padding:
            const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 10),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.white38, primaryLightColor]),
            border: Border(
              right: BorderSide(width: 1.2, color: Colors.grey.shade500
                  // color: Colors.grey.shade300,
                  ),
              bottom: BorderSide(width: 1.2, color: Colors.grey.shade500),
            )),
        child: InkWell(
          onTap: () {
            log(FirebaseAuth.instance.currentUser?.phoneNumber.toString() ??
                "");
            // createRewardedAd();
            if (choice?.title == 'E-Books\nPioneer') {
              context.pushNamed(RouteNames.ebook);
            } else if (choice?.title == 'Audio\nRhyme') {
              context.pushNamed(RouteNames.audio);
            } else if (choice?.title == 'Video\nCollection') {
              context.pushNamed(RouteNames.video);
            } else if (choice?.title == 'Bhakti\nAarti') {
              context.pushNamed(RouteNames.aarti);
            } else if (choice?.title == 'Mahabharat Story') {
              context.pushNamed(RouteNames.mahabharat);
            } else if (choice?.title == 'Ramayana Story') {
              context.pushNamed(RouteNames.ramayana);
            } else if (choice?.title == 'MahaDev Story') {
              context.pushNamed(RouteNames.mahadev);
            } else if (choice?.title == 'Gita\nUpdesh') {
              context.pushNamed(RouteNames.gitaUpdesh);
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
                      child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (Rect bounds) {
                            return ui.Gradient.linear(
                              const Offset(24.0, 4.0),
                              const Offset(4.0, 19.0),
                              const <Color>[Colors.red, Colors.black],
                            );
                          },
                          child: Icon(choice?.icon, size: 30.0)),
                    )),
                    Center(
                      child: GradientTextView(
                        title: choice?.title ?? '',
                        textAlign: TextAlign.center,
                        textSize: 15,
                        selectionGradient: const [
                          Colors.black,
                          Colors.red,
                        ],
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
