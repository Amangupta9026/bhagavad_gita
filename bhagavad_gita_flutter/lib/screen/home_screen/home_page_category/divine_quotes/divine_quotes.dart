import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          child: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('divineQuotes').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          var data = snapshot.data?.docs;
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              Opacity(
                opacity: 0.89,
                child: data?.isNotEmpty ?? false
                    ? Opacity(
                        opacity: 0.35,
                        child: CachedNetworkImage(
                            height: double.infinity,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            filterQuality: FilterQuality.low,
                            imageUrl: data?[0]['backGroundImage'],
                            placeholder: (context, url) => Center(
                                  child: Image.asset(
                                    'assets/images/board2.jpg',
                                    height: double.infinity,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                            errorWidget: (context, url, error) => Image.asset(
                                  'assets/images/board2.jpg',
                                  height: double.infinity,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                )),
                      )
                    : Image.asset('assets/images/bg4.jpg',
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover),
              ),
              Center(
                  child: Text(data?[0]['quotes'] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: textColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold))),
            ],
          );
        },
      )),
    );
  }
}
