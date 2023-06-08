import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';

import '../../../../utils/file_collection.dart';

class DivineQuotes extends StatelessWidget {
  const DivineQuotes({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Quotes of the Day',
        ),
      ),
      body: SafeArea(
          child: Stack(
        children: [
          Opacity(
            opacity: 0.89,
            child: Image.asset('assets/images/bg4.jpg',
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover),
          ),
          const Center(
              child: Text(
                  'दूसरों की परेशानी का आनंद ना लें,\nकहीं भगवान आपको वह गिफ्ट ना कर दें,\nक्योंकि भगवान वही देता हैं जिसमें\nआपको आनंद मिलता हैं।',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold))),
        ],
      )),
    );
  }
}
