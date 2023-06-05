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
          backgroundColor: Colors.orange[800],
          leading: InkWell(
              autofocus: true, onTap: () {
            scaffoldStateKey.currentState?.openDrawer();
              }, child: const Icon(Icons.menu)),
          centerTitle: true,
          title: const Column(
            children: [
              Text('|| Shri Hari ||'),
              SizedBox(height: 5),
              Text('Bhagavad Gita'),
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
          ]),
      body: const Center(
        child: Text('Home Screen'),
      ),
    );
  }
}
