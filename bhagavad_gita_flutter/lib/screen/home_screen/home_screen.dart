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
              'Bhagavad Gita',
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
        // bottom: PreferredSize(
        //   preferredSize: const Size.fromHeight(50),
        //   child: SizedBox(
        //     height: 50,
        //     child: ListView.builder(
        //       scrollDirection: Axis.horizontal,
        //       itemCount: 5,
        //       itemBuilder: (context, index) {
        //         return InkWell(
        //           onTap: () {},
        //           child: Container(
        //             margin: const EdgeInsets.all(5),
        //             padding: const EdgeInsets.all(5),
        //             decoration: BoxDecoration(
        //               borderRadius: BorderRadius.circular(10),
        //               color: Colors.orange[800],
        //             ),
        //             child: Center(
        //               child: Text(
        //                 '${index + 1}',
        //                 style: const TextStyle(
        //                   color: Colors.white,
        //                   fontSize: 20,
        //                   fontWeight: FontWeight.bold,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         );
        //       },
        //     ),
        //   ),
        // ),
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
