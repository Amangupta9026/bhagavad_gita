import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class MoreApps extends StatelessWidget {
  const MoreApps({super.key});

  Future<void> appPlayStoreLauncher(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            context.pop();
            context.pop();
          },
          icon: const Icon(Icons.arrow_back),
        ),
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
          'More Apps',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: SafeArea(
          child: GridView.count(
              physics: const ClampingScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(4, (index) {
                return InkWell(
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
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(15.0, 10, 0, 0),
                    child: Card(
                      elevation: 10,
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.grey.shade400,
                            width: 1.5,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              flex: 3,
                              child: Image.asset(
                                'assets/images/board3.jpg',
                                fit: BoxFit.cover,
                                width: double.infinity,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Expanded(
                              flex: 2,
                              child: Center(
                                child: Text(
                                  'QWise Learning - Learn From Best',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }))),
    );
  }
}
