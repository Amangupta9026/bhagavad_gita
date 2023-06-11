import 'dart:developer';

import 'package:bhagavad_gita_flutter/local/prefs.dart';
import 'package:bhagavad_gita_flutter/riverpod/darktheme_notifier.dart';
import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/widget/alertdialogbox.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  bool isSwitched = false;
  var textValue = 'Switch is OFF';

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          //DrawerHeader
          Image.asset(
            'assets/images/board2.jpg',
          ),
          const SizedBox(height: 12),
          Consumer(builder: (context, ref, child) {
            final refRead = ref.read(themeNotifierProvider.notifier);
            return ListTile(
              leading: const Icon(Icons.dark_mode),
              title: const Text('Dark Mode'),
              onTap: () {
                refRead.changeTheme();
              },
              trailing: Transform.scale(
                  scale: 0.8,
                  child: Switch(
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    onChanged: (value) {
                      refRead.changeTheme();
                    },
                    value:
                        ref.watch(themeNotifierProvider).value ==
                            ThemeMode.light,
                    activeColor: primaryColor,
                    activeTrackColor: Colors.orange[400],
                    inactiveThumbColor: Colors.grey,
                    inactiveTrackColor: Colors.grey.shade300,
                  )),
            );
          }),
          ListTile(
            leading: const Icon(Icons.bookmark),
            title: const Text('Bookmarks'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.language),
            title: const Text('App Language'),
            onTap: () {
              showMyDialog(
                context,
                'Please select your preference language',
                'Choose your App Language you want to use in this app to read Bhagwavad Gita.\n\nYou can change your preference language anytime from settings. ',
                () {},
                istwobutton: true,
                actionButtonText1: 'English',
                actiontap1: () {},
                actionButtonText2: 'Hindi',
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: const Text('About Gita'),
            onTap: () {
              context.pushNamed(RouteNames.aboutGita);
            },
          ),
          ListTile(
            leading: const Icon(Icons.support),
            title: const Text('Support Us'),
            onTap: () {
              context.pushNamed(RouteNames.helpSupport);
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share App'),
            onTap: () {
              Share.share(
                  subject: 'Bhagwavad Gita',
                  'hey! check out this amazing Bhagwavad Gita app\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US');
            },
          ),
          ListTile(
            leading: const Icon(Icons.apps),
            title: const Text('More App'),
            onTap: () {
              context.pushNamed(RouteNames.moreApps);
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('LogOut'),
            onTap: () {
              Prefs.clear();
              toast('Logged Out Successfully');
              context.pushNamed(RouteNames.signInScreen);
            },
          ),
        ],
      ),
    ); //Drawe;
  }
}
