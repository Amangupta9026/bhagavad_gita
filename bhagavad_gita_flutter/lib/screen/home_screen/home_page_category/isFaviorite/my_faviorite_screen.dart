import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';

class MyFavioriteScreen extends StatelessWidget {
  const MyFavioriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarHeader(
            text: 'My Faviorite',
          ),
        ),
        body: SafeArea(
            child: SingleChildScrollView(
          child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('isFaviorite')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                var isFaviorite = snapshot.data?.docs;
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
                return Column(
                  children: [
                    ListView.builder(
                        padding: const EdgeInsets.fromLTRB(10, 20, 10, 40),
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: isFaviorite?.length ?? 0,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.fromLTRB(6.0, 8, 6, 8),
                            child: InkWell(
                              onTap: () {
                                context.pushNamed(RouteNames.ebookDetail,
                                    pathParameters: {
                                      'title': isFaviorite?[index]['bookTitle'],
                                      'description': isFaviorite?[index]
                                          ['description'],
                                      'image': isFaviorite?[index]['image'],
                                    });
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.grey[500]!),
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
                                                            Radius.circular(9),
                                                        topLeft:
                                                            Radius.circular(9)),
                                                child: CachedNetworkImage(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.17,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    imageUrl:
                                                        isFaviorite?[index]
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
                                                                0.17,
                                                            width:
                                                                double.infinity,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        ),
                                                    errorWidget: (context, url,
                                                            error) =>
                                                        Image.asset(
                                                          'assets/images/board2.jpg',
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.17,
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
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  color: primaryLightColor,
                                                ),
                                                child: Text(
                                                  isFaviorite?[index]
                                                          ['bookTitle'] ??
                                                      '',
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              Text(
                                                  isFaviorite?[index]
                                                          ['description'] ??
                                                      '',
                                                  maxLines: 4,
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
              }),
        )));
  }
}
