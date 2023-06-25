import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import '../../../../router/routes_names.dart';
import '../../../../utils/file_collection.dart';
import '../../../../widget/app_bar_header.dart';
import '../../../../widget/shimmar_progress_widget.dart';

class ProvachanScreen extends StatelessWidget {
  const ProvachanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Aarti Book',
        ),
      ),
      floatingActionButton: SizedBox(
        height: 150,
        child: Image.asset('assets/images/flute1.png', height: 150),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [primaryLightColor, lightPinkColor],
          ),
        ),
        child: SafeArea(
            child: SingleChildScrollView(
                child: StreamBuilder(
          stream:
              FirebaseFirestore.instance.collection('aarti-Book').snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var aartibook = snapshot.data?.docs;
            if (!snapshot.hasData) {
              return const ShimmerProgressWidget();
            }
            return Column(
              children: [
                ListView.builder(
                    padding: const EdgeInsets.fromLTRB(10, 5, 10, 40),
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: aartibook?.length ?? 0,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        key: ValueKey(aartibook?[index]['bookTitle']),
                        padding: const EdgeInsets.fromLTRB(6.0, 8, 6, 8),
                        child: InkWell(
                          onTap: () {
                            context.pushNamed(RouteNames.aartibookDetail,
                                pathParameters: {
                                  'title': aartibook?[index]['bookTitle'],
                                  'description': aartibook?[index]
                                      ['description'],
                                  'image': aartibook?[index]['image'],
                                });
                          },
                          child: Container(
                            // height: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey[700]!),
                            ),
                            child: Column(children: [
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          ClipRRect(
                                            borderRadius:
                                                const BorderRadius.only(
                                                    bottomLeft:
                                                        Radius.circular(9),
                                                    topLeft:
                                                        Radius.circular(9)),
                                            child: CachedNetworkImage(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.190,
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                imageUrl: aartibook?[index]
                                                    ['image'],
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child: Image.asset(
                                                        'assets/images/board2.jpg',
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .height *
                                                            0.190,
                                                        width: double.infinity,
                                                        fit: BoxFit.cover,
                                                      ),
                                                    ),
                                                errorWidget: (context, url,
                                                        error) =>
                                                    Image.asset(
                                                      'assets/images/board2.jpg',
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.190,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Expanded(
                                      flex: 3,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 8),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                right: 25.0),
                                            child: Container(
                                              padding: const EdgeInsets.all(5),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                color: primaryLightColor,
                                              ),
                                              child: Text(
                                                aartibook?[index]
                                                        ['bookTitle'] ??
                                                    '',
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                              aartibook?[index]
                                                      ['description'] ??
                                                  '',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 15,
                                                color: textColor,
                                                fontWeight: FontWeight.w500,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ]),
                            ]),
                          ),
                        ),
                      );
                    }),
              ],
            );
          },
        ))),
      ),
    );
  }
}
