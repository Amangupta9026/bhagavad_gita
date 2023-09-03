import 'package:bhagavad_gita_flutter/local/prefs.dart';
import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/widget/alertdialogbox.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  Future<void> appPlayStoreLauncher(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, lightPinkColor],
          ),
        ),
        child: ListView(padding: const EdgeInsets.all(0), children: [
          //DrawerHeader
          Image.asset(
            'assets/images/drawer1.gif',
            height: MediaQuery.of(context).size.height * 0.3,
            width: double.infinity,
            fit: BoxFit.cover,
          ),

          // Consumer(builder: (context, ref, child) {
          //   final refRead = ref.read(themeNotifierProvider.notifier);
          //   return ListTile(
          //     dense: true,
          //     leading: const Icon(Icons.dark_mode),
          //     title: const Text('Dark Mode'),
          //     onTap: () {
          //       refRead.changeTheme();
          //     },
          //     trailing: Transform.scale(
          //         scale: 0.8,
          //         child: Switch(
          //           materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //           onChanged: (value) {
          //             refRead.changeTheme();
          //           },
          //           value: ref.watch(themeNotifierProvider).value ==
          //               ThemeMode.light,
          //           activeColor: primaryColor,
          //           activeTrackColor: Colors.orange[400],
          //           inactiveThumbColor: Colors.grey,
          //           inactiveTrackColor: Colors.grey.shade300,
          //         )),
          //   );
          // }),

          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(20, 15, 0, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
              minVerticalPadding: 0.0,
              leading: Icon(
                MdiIcons.handHeart,
                color: Colors.black,
              ),
              title: const Text('About Gita',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                context.pushNamed(RouteNames.aboutGita);
              }),
          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
              minVerticalPadding: 0.0,
              leading: Icon(
                MdiIcons.faceAgent,
                color: Colors.black,
              ),
              title: const Text('Feedback',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                context.pushNamed(RouteNames.helpSupport);
              }),
          // ListTile(
          //     contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
          //     visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
          //     minVerticalPadding: 0.0,
          //     leading: const Icon(
          //       Icons.share,
          //       color: Colors.black,
          //     ),
          //     title: const Text('Share App',
          //         style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          //     onTap: () {
          //       Share.share(
          //           subject: 'Bhagwavad Gita',
          //           'hey! check out this amazing Bhagavad Gita app\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US');
          //     }),

          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
              minVerticalPadding: 0.0,
              leading: Icon(
                MdiIcons.heart,
                color: Colors.black,
              ),
              title: const Text('Rate Us',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                appPlayStoreLauncher(Uri(
                  scheme: 'https',
                  host: 'play.google.com',
                  path: 'store/apps/details',
                  queryParameters: {
                    'id': 'com.flashcoders.bhagavad_gita_ai',
                    'hl': 'en_IN',
                    'gl': 'US',
                  },
                ));
              }),

          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
              minVerticalPadding: 0.0,
              leading: Icon(
                MdiIcons.apps,
                color: Colors.black,
              ),
              title: const Text('More App',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                context.pushNamed(RouteNames.moreApps);
              }),
          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
              minVerticalPadding: 0.0,
              leading: Icon(
                MdiIcons.web,
                color: Colors.black,
              ),
              title: const Text('App Language',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                showMyDialog(
                  context,
                  'Please select your preference language',
                  'Choose your App Language you want to use in this app to read Bhagwavad Gita.\n\nYou can change your preference language anytime from settings. ',
                  () {
                    context.pop();
                    toast('This feature is coming soon');
                  },
                  istwobutton: true,
                  actionButtonText1: 'English',
                  actiontap1: () {
                    context.pop();
                    toast('This feature is coming soon');
                  },
                  actionButtonText2: 'Hindi',
                );
              }),
          ListTile(
              contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
              visualDensity: const VisualDensity(horizontal: 0, vertical: 0),
              minVerticalPadding: 0.0,
              leading: const Icon(
                Icons.logout,
                color: Colors.black,
              ),
              title: const Text('LogOut',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              onTap: () {
                Prefs.clear();
                toast('Logged Out Successfully');
                context.pushNamed(RouteNames.signInScreen);
              }),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset('assets/images/flute1.png', height: 120),
            ],
          ),
          // const SizedBox(height: 20),
        ]),
      ),
    );
  }
}
