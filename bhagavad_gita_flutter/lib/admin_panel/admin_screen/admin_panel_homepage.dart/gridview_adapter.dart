import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/file_collection.dart';

class AdminPanelChoice {
  const AdminPanelChoice({this.title, this.icon});
  final String? title;
  final IconData? icon;
}

const List<AdminPanelChoice> adminpanelchoices = <AdminPanelChoice>[
  AdminPanelChoice(title: 'E-Books', icon: Icons.copy),
  AdminPanelChoice(title: 'Audio', icon: Icons.music_note),
  AdminPanelChoice(title: 'Video', icon: Icons.video_call),
  AdminPanelChoice(title: 'Aarti', icon: Icons.music_note),
  AdminPanelChoice(title: 'Divine Quotes', icon: Icons.note),
  AdminPanelChoice(title: 'Articles', icon: Icons.article),
  AdminPanelChoice(title: 'Wallpaper', icon: Icons.wallpaper),
  AdminPanelChoice(title: 'More Apps', icon: Icons.apps),
];

class AdminPanelSelectCard extends StatelessWidget {
  const AdminPanelSelectCard({Key? key, this.choice}) : super(key: key);
  final AdminPanelChoice? choice;

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
          if (choice?.title == 'E-Books') {
            context.pushNamed(RouteNames.adminEbook);
          } else if (choice?.title == 'Audio') {
            context.pushNamed(RouteNames.adminAudio);
          } else if (choice?.title == 'Video') {
            context.pushNamed(RouteNames.adminVideo);
          } else if (choice?.title == 'Aarti') {
            context.pushNamed(RouteNames.adminAarti);
          } else if (choice?.title == 'Divine Quotes') {
            context.pushNamed(RouteNames.adminQuotes);
          } else if (choice?.title == 'Articles') {
            context.pushNamed(RouteNames.adminArticles);
          } else if (choice?.title == 'Wallpaper') {
            context.pushNamed(RouteNames.adminWallpaper);
          } else if (choice?.title == 'More Apps') {
            context.pushNamed(RouteNames.adminMoreApps);
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
