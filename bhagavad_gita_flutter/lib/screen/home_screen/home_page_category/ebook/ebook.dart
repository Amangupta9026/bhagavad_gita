import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

import '../../../../widget/shimmar_progress_widget.dart';

class EbookScreen extends StatelessWidget {
  const EbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarHeader(
            text: 'E-Books',
          ),
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
                stream: FirebaseFirestore.instance
                    .collection('e-books')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  var ebooks = snapshot.data?.docs;
                  if (!snapshot.hasData) {
                    return const ShimmerProgressWidget();
                  }
                  return Column(
                    children: [
                      ListView.builder(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 40),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: ebooks?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              key: ValueKey(ebooks?[index]['bookTitle']),
                              padding: const EdgeInsets.fromLTRB(6.0, 8, 6, 8),
                              child: InkWell(
                                onTap: () {
                                  context.pushNamed(RouteNames.ebookDetail,
                                      pathParameters: {
                                        'title': ebooks?[index]['bookTitle'],
                                        'description': ebooks?[index]
                                            ['description'],
                                        'image': ebooks?[index]['image'],
                                      });
                                },
                                child: Container(
                                  // height: 150,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.grey[700]!),
                                  ),
                                  child: Column(children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
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
                                                              Radius.circular(
                                                                  9),
                                                          topLeft:
                                                              Radius.circular(
                                                                  9)),
                                                  child: CachedNetworkImage(
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.190,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                      imageUrl: ebooks?[index]
                                                          ['image'],
                                                      placeholder: (context,
                                                              url) =>
                                                          Center(
                                                            child: Image.asset(
                                                              'assets/images/board2.jpg',
                                                              height: MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .height *
                                                                  0.190,
                                                              width: double
                                                                  .infinity,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                      errorWidget: (context,
                                                              url, error) =>
                                                          Image.asset(
                                                            'assets/images/board2.jpg',
                                                            height: MediaQuery.of(
                                                                        context)
                                                                    .size
                                                                    .height *
                                                                0.190,
                                                            width:
                                                                double.infinity,
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0),
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(5),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                      color: primaryLightColor,
                                                    ),
                                                    child: Text(
                                                      ebooks?[index]
                                                              ['bookTitle'] ??
                                                          '',
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                        color: Colors.white,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                const SizedBox(height: 8),
                                                Text(
                                                    ebooks?[index]
                                                            ['description'] ??
                                                        '',
                                                    maxLines: 3,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                      color: textColor,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                }),
          )),
        ));
  }
}
