import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: StreamBuilder(
            stream:
                FirebaseFirestore.instance.collection('moreApps').snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              var moreAppsData = snapshot.data?.docs;
              if (!snapshot.hasData) {
                return const Align(
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 60),
                      CircularProgressIndicator(),
                    ],
                  ),
                );
              }

              return GridView.count(
                  physics: const ClampingScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  children: List.generate(moreAppsData?.length ?? 0, (index) {
                    return InkWell(
                      onTap: () {
                        appPlayStoreLauncher(Uri(
                          scheme: 'https',
                          host: 'play.google.com',
                          path: 'store/apps/details',
                          queryParameters: {
                            'id': '${moreAppsData?[index]['appLink']}',
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
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        moreAppsData?[index]['appImage'] ?? '',
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Image.asset('assets/images/board4.jpg'),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Expanded(
                                  flex: 2,
                                  child: Center(
                                    child: Text(
                                      moreAppsData?[index]['appName'] ?? '',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
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
                  }));
            }),
      ),
    );
  }
}
