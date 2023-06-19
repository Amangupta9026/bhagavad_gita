import 'package:bhagavad_gita_flutter/local/prefs.dart';
import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/widget/alertdialogbox.dart';
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
      child: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryColor, lightPinkColor],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            //DrawerHeader
            Image.asset(
              'assets/images/drawer1.gif',
            ),
            const SizedBox(height: 12),
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
              dense: true,
              leading: Icon(
                Icons.favorite,
                color: Colors.grey[800]!.withOpacity(0.7),
              ),
              title: const Text(
                'Favorite',
                style: TextStyle(
                    fontSize: 16,
                    color: textColor,
                    fontWeight: FontWeight.w600),
              ),
              onTap: () {
                context.pushNamed(RouteNames.favorite);
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(
                Icons.language,
                color: Colors.grey[800]!.withOpacity(0.7),
              ),
              title: const Text('App Language',
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600)),
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
              dense: true,
              leading: Icon(
                Icons.support,
                color: Colors.grey[800]!.withOpacity(0.7),
              ),
              title: const Text('About Gita',
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600)),
              onTap: () {
                context.pushNamed(RouteNames.aboutGita);
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(
                Icons.help,
                color: Colors.grey[800]!.withOpacity(0.7),
              ),
              title: const Text('Support Us',
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600)),
              onTap: () {
                context.pushNamed(RouteNames.helpSupport);
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(
                Icons.share,
                color: Colors.grey[800]!.withOpacity(0.7),
              ),
              title: const Text('Share App',
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600)),
              onTap: () {
                Share.share(
                    subject: 'Bhagwavad Gita',
                    'hey! check out this amazing Bhagavad Gita app\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US');
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(
                Icons.apps,
                color: Colors.grey[800]!.withOpacity(0.7),
              ),
              title: const Text('More App',
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600)),
              onTap: () {
                context.pushNamed(RouteNames.moreApps);
              },
            ),
            ListTile(
              dense: true,
              leading: Icon(
                Icons.logout,
                color: Colors.grey[800]!.withOpacity(0.7),
              ),
              title: const Text('LogOut',
                  style: TextStyle(
                      fontSize: 16,
                      color: textColor,
                      fontWeight: FontWeight.w600)),
              onTap: () {
                Prefs.clear();
                toast('Logged Out Successfully');
                context.pushNamed(RouteNames.signInScreen);
              },
            ),
          ],
        ),
      ),
    ); //Drawe;
  }
}
