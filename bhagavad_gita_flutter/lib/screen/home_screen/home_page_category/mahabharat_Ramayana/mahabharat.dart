// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../riverpod/mahabharat_notifier.dart';
import '../../../../widget/app_bar_header.dart';

class Mahabharat extends StatelessWidget {
  final yt = YoutubeExplode();

  Mahabharat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Mahabharat',
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
        )),
        child: SafeArea(
            child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
            child: Column(
              children: [
                StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection('playListMahabharat')
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

                    return Consumer(
                      builder: (context, ref, child) {
                        final refRead =
                            ref.read(mahabharatNotifierProvider.notifier);
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data?.length ?? 0,
                            itemBuilder: (context, index) {
                              String title = data?[index]['title'];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 30.0),
                                child: InkWell(
                                  onTap: () async {
                                    EasyLoading.show(status: 'Loading...');
                                    log('mahabharat video clicked');
                                    List<Video> videos = [];

                                    var docSnapShot =
                                        await FirebaseFirestore.instance
                                            .collection("playListMahabharat")
                                            .where('title', isEqualTo: title
                                             
                                                )
                                            .get();

                                    var docID = docSnapShot.docs.first.id;

                                    final data = await FirebaseFirestore
                                        .instance
                                        .collection("playListMahabharat")
                                        .doc(docID)
                                        .get();

                                    final String? playListUrl =
                                        data.data()?["playListUrl"];
                                    if (playListUrl == null) return;
                                    await for (var video in yt.playlists
                                        .getVideos(Uri.parse(playListUrl))) {
                                      videos.add(video);
                                    }

                                    refRead.setVideos(videos);

                                    context.pushNamed(
                                        RouteNames.mahabharatVideo,
                                        pathParameters: {
                                          'title': title,
                                        });
                                    EasyLoading.dismiss();
                                  },
                                  child: Card(
                                    elevation: 5,
                                    margin: EdgeInsets.zero,
                                    child: Container(
                                      padding: EdgeInsets.zero,
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(12),
                                                  topRight: Radius.circular(12),
                                                ),
                                                child: CachedNetworkImage(
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.190,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    imageUrl: data?[index]
                                                        ['imageUrl'],
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
                                                              0.190,
                                                          width:
                                                              double.infinity,
                                                          fit: BoxFit.cover,
                                                        )),
                                              ),
                                              Positioned.fill(
                                                bottom: -20,
                                                right: 10,
                                                child: Align(
                                                  alignment:
                                                      Alignment.bottomRight,
                                                  child: Container(
                                                    height: 40,
                                                    width: 80,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                primaryColor),
                                                    child: const Center(
                                                      child: Text("Play",
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold)),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 16,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(title,
                                                    style: const TextStyle(
                                                        fontSize: 18,
                                                        color: textColor,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                Row(
                                                  children: [
                                                    RatingBar.builder(
                                                      ignoreGestures: true,
                                                      initialRating: 5.0,
                                                      minRating: 1,
                                                      direction:
                                                          Axis.horizontal,
                                                      allowHalfRating: true,
                                                      itemCount: 5,
                                                      itemSize: 16,
                                                      itemPadding:
                                                          const EdgeInsets
                                                                  .symmetric(
                                                              horizontal: 1.0),
                                                      itemBuilder:
                                                          (context, _) =>
                                                              const Icon(
                                                        Icons.star,
                                                        color: yellowColor,
                                                        size: 3,
                                                      ),
                                                      onRatingUpdate:
                                                          (rating) {},
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        )),
      ),
    );
  }
}
