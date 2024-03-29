import 'package:bhagavad_gita_flutter/utils/utils.dart';

import '../../utils/file_collection.dart';
import '../widget/app_bar_header.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Notification',
        ),
      ),
      body: Container(
        decoration: AppUtils.decoration1(),
        height: double.infinity,
        width: double.infinity,
        child: const SafeArea(
            child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(15.0),
              child: Column(children: [
                Text('No Notification',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w400,
                    ))
              ]),
            ),
          ),
        )),
      ),
    );
  }
}
