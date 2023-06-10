import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';

import 'admin_panel_homepage.dart/gridview_adapter.dart';

class AdminPanel extends StatelessWidget {
  const AdminPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Admin Panel',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(children: [
          GridView.count(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              children: List.generate(adminpanelchoices.length, (index) {
                return Center(
                  child: AdminPanelSelectCard(choice: adminpanelchoices[index]),
                );
              }))
        ]),
      )),
    );
  }
}
