import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

import '../../../../local/pref_names.dart';
import '../../../../widget/gradient_text_view.dart';

class MyFavioriteScreen extends StatefulWidget {
  const MyFavioriteScreen({super.key});

  @override
  State<MyFavioriteScreen> createState() => _MyFavioriteScreenState();
}

class _MyFavioriteScreenState extends State<MyFavioriteScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: AppBarHeader(
            text: 'My Favorite',
            isBackButton: false,
          ),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              stops: [0.4, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.white, primaryColor],
            ),
          ),
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              children: [
                if (FavList.isEmpty) ...{
                  Column(
                    children: [
                      Lottie.asset(
                        'assets/no-data-found.json',
                        controller: _controller,
                        onLoaded: (composition) {
                          _controller
                            ..duration = composition.duration
                            ..forward();
                        },
                      ),
                      const GradientTextView(
                        title: 'No favorite book found yet!',
                        textAlign: TextAlign.center,
                        textSize: 18,
                        selectionGradient: [
                          Colors.black,
                          Colors.red,
                        ],
                      ),
                    ],
                  ),
                },
                const SizedBox(height: 10),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: FavList.length,
                    itemBuilder: (context, index) {
                      final String title = FavList[index];
                      return StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection('e-books')
                              .where('bookTitle', isEqualTo: title)
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            var isFaviorite = snapshot.data?.docs;
                            if (!snapshot.hasData) {
                              return const Align(
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(height: 60),
                                    CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  ],
                                ),
                              );
                            }
                            return Column(
                              children: [
                                ListView.builder(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 15, 10, 0),
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: isFaviorite?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            6.0, 0, 6, 8),
                                        child: InkWell(
                                          onTap: () {
                                            context.pushNamed(
                                                RouteNames.ebookDetail,
                                                pathParameters: {
                                                  'title': isFaviorite?[index]
                                                      ['bookTitle'],
                                                  'description':
                                                      isFaviorite?[index]
                                                          ['description'],
                                                  'image': isFaviorite?[index]
                                                      ['image'],
                                                });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              border: Border.all(
                                                  color: Colors.grey[500]!),
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          ClipRRect(
                                                            borderRadius: const BorderRadius
                                                                    .only(
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        9),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        9)),
                                                            child:
                                                                CachedNetworkImage(
                                                                    height:
                                                                        MediaQuery.of(context)
                                                                                .size
                                                                                .height *
                                                                            0.17,
                                                                    width: double
                                                                        .infinity,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: isFaviorite?[
                                                                            index]
                                                                        [
                                                                        'image'],
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Center(
                                                                              child: Image.asset(
                                                                                'assets/images/board2.jpg',
                                                                                height: MediaQuery.of(context).size.height * 0.17,
                                                                                width: double.infinity,
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image.asset(
                                                                          'assets/images/board2.jpg',
                                                                          height:
                                                                              MediaQuery.of(context).size.height * 0.17,
                                                                          width:
                                                                              double.infinity,
                                                                          fit: BoxFit
                                                                              .cover,
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
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          const SizedBox(
                                                              height: 8),
                                                          Container(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(5),
                                                            decoration:
                                                                BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color:
                                                                  primaryLightColor,
                                                            ),
                                                            child: Text(
                                                              isFaviorite?[
                                                                          index]
                                                                      [
                                                                      'bookTitle'] ??
                                                                  '',
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 14,
                                                                color: Colors
                                                                    .white,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                              ),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              height: 8),
                                                          Text(
                                                              isFaviorite?[
                                                                          index]
                                                                      [
                                                                      'description'] ??
                                                                  '',
                                                              maxLines: 4,
                                                              style:
                                                                  const TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    textColor,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
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
                          });
                    }),
              ],
            ),
          )),
        ));
  }
}
