import 'package:bhagavad_gita_flutter/screen/home_screen/banner.dart';
import 'package:bhagavad_gita_flutter/screen/home_screen/gridview_adapter.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';

import '../drawer/drawer.dart';

class HomeScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldStateKey = GlobalKey<ScaffoldState>();
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldStateKey,
      drawer: const DrawerScreen(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: InkWell(
            autofocus: true,
            onTap: () {
              scaffoldStateKey.currentState?.openDrawer();
            },
            child: const Icon(Icons.menu)),
        centerTitle: true,
        title: const Column(
          children: [
            Text(
              '|| Shri Hari ||',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              'Bhagwavad Gita',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        actions: [
          InkWell(
            autofocus: true,
            onTap: () {},
            child: const Icon(Icons.search),
          ),
          const SizedBox(width: 7),
          InkWell(
            autofocus: true,
            onTap: () {},
            child: const Icon(Icons.bookmark_border),
          ),
          const SizedBox(width: 7),
          InkWell(
            autofocus: true,
            onTap: () {},
            child: const Icon(Icons.notifications_none),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            HomeBanner(),
            GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                children: List.generate(choices.length, (index) {
                  return Center(
                    child: SelectCard(choice: choices[index]),
                  );
                }))
          ],
        ),
      )),
    );
  }
}
