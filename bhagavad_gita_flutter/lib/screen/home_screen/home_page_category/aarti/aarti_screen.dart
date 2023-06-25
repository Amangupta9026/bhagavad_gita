// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/app_bar_header.dart';
import 'package:bhagavad_gita_flutter/widget/search_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class AartiScreen extends StatelessWidget {
  final yt = YoutubeExplode();
  AartiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Aarti',
        ),
      ),
      body: SafeArea(
          child: SingleChildScrollView(
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('video')
              .orderBy('servertime', descending: false)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            final data = snapshot.data?.docs;

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
            return Padding(
              padding: const EdgeInsets.only(left: 2.0, right: 2, bottom: 60),
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(8.0, 8, 8, 15),
                  child: InkWell(
                      onTap: () => context.pushNamed(RouteNames.ebook),
                      child: const SearchItemTextField()),
                ),
                Consumer(
                  builder: (context, ref, child) {
                   // final refRead = ref.read(aartiNotifierProvider.notifier);
                    return ListView.builder(
                        itemCount: data?.length ?? 0,
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemBuilder: (BuildContext context, int index) {
                          String title = data?[index]['videoTitle'];

                          return Card(
                            elevation: 12,
                            child: Container(
                              color: Colors.white,
                              padding: const EdgeInsets.only(
                                  left: 7, right: 7, top: 15.0, bottom: 15),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        title,
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                            color: primaryColor),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.only(
                                            left: 4.0, right: 4),
                                        decoration: BoxDecoration(
                                          color: primaryLightColor,
                                          borderRadius:
                                              BorderRadius.circular(4),
                                          border:
                                              Border.all(color: primaryColor),
                                        ),
                                        child: const Text(
                                          'Listen all 10 Aarti',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.19,
                                    child: ListView.builder(
                                        itemCount: data?.length ?? 0,
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder:
                                            (BuildContext context, int index2) {
                                          log('Hanumaan Chalisha ${data?[index]['Hanumaan Chalisha']}');

                                          // final String categoryData =
                                          //     data?[index]['Hanumaan Chalisha']
                                          //         [index2];

                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10.0),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () async {
                                                    log("Hanumaan Chalisha $index2");
                                                    //    log('Hanumaan Chalisha $categoryData');

                                                    // EasyLoading.show(
                                                    //     status: 'Loading...');

                                                    // List<Video> categoryVideos =
                                                    //     [];

                                                    // final String playListUrl =
                                                    //     categoryData;
                                                    // if (playListUrl == null) {
                                                    //   return;
                                                    // }
                                                    // await for (var video in yt
                                                    //     .playlists
                                                    //     .getVideos(Uri.parse(
                                                    //         playListUrl))) {
                                                    //   categoryVideos.add(video);
                                                    // }

                                                    // refRead.setVideos(
                                                    //     categoryVideos);

                                                    // context.pushNamed(
                                                    //     RouteNames.aartiView,
                                                    //     pathParameters: {
                                                    //       'title': title,
                                                    //     });
                                                    // EasyLoading.dismiss();
                                                  },
                                                  child: Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                            0.4,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      border: Border.all(
                                                          color: Colors.grey),
                                                    ),
                                                    child: Column(children: [
                                                      Stack(
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
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    imageUrl: data?[
                                                                            index]
                                                                        [
                                                                        'videoImage'],
                                                                    placeholder:
                                                                        (context,
                                                                                url) =>
                                                                            Center(
                                                                              child: Image.asset(
                                                                                'assets/images/board2.jpg',
                                                                                fit: BoxFit.cover,
                                                                              ),
                                                                            ),
                                                                    errorWidget: (context,
                                                                            url,
                                                                            error) =>
                                                                        Image
                                                                            .asset(
                                                                          'assets/images/board2.jpg',
                                                                          fit: BoxFit
                                                                              .cover,
                                                                        )),
                                                          ),
                                                          const Positioned(
                                                            left: 0,
                                                            right: 0,
                                                            top: 0,
                                                            bottom: 0,
                                                            child: Center(
                                                              child: Icon(
                                                                  Icons
                                                                      .play_arrow,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 40),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(height: 8),
                                                      Center(
                                                        child: Text(
                                                          title,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: const TextStyle(
                                                              color: textColor,
                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600),
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                ],
                              ),
                            ),
                          );
                        });
                  },
                )
              ]),
            );
          },
        ),
      )),
    );
  }
}
