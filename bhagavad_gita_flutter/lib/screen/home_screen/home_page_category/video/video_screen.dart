// ignore_for_file: use_build_context_synchronously
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutterflow_paginate_firestore/paginate_firestore.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

import '../../../../riverpod/video_notifier.dart';
import '../../../../router/routes_names.dart';
import '../../../../utils/colors.dart';
import '../../../../widget/app_bar_header.dart';

class VideoScreen extends StatelessWidget {
  final yt = YoutubeExplode();
  VideoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: AppBarHeader(
          text: 'Video',
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
            child: Scrollbar(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 0),
            child: PaginateFirestore(
              itemBuilderType:
                  PaginateBuilderType.listView, //Change types accordingly

              // orderBy is compulsory to enable pagination
              query: FirebaseFirestore.instance
                  .collection('allVideo')
                  .orderBy('servertime', descending: true),

              itemsPerPage: 5,
              // to fetch real-time data
              // isLive: true,
              allowImplicitScrolling: true,
              bottomLoader: const Center(
                child: CircularProgressIndicator(),
              ),
             

              itemBuilder: (context, documentSnapshots, index) {
                final data = documentSnapshots[index].data() as Map?;

                return Consumer(builder: (context, ref, child) {
                  final refRead = ref.read(videoNotifierProvider.notifier);
                  String title = data?['videoTitle'];
                  //   log(title.length.toString());
                  return InkWell(
                    onTap: () async {
                      EasyLoading.show(status: 'Loading...');

                      List<Video> videos = [];

                      var docSnapShot = await FirebaseFirestore.instance
                          .collection("allVideo")
                          .where('videoTitle', isEqualTo: title)
                          .get();

                      var docID = docSnapShot.docs.first.id;

                      final data = await FirebaseFirestore.instance
                          .collection("allVideo")
                          .doc(docID)
                          .get();

                      final String? playListUrl = data.data()?["videoUrl"];
                      if (playListUrl == null) return;
                      await for (var video
                          in yt.playlists.getVideos(Uri.parse(playListUrl))) {
                        videos.add(video);
                      }

                      refRead.setVideos(videos);

                      context.pushNamed(RouteNames.videoView, pathParameters: {
                        'title': title,
                      });
                      EasyLoading.dismiss();
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 10, bottom: 10, right: 10, top: 15),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.13,
                        width: MediaQuery.of(context).size.width * 0.3,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.only(
                                        bottomLeft: Radius.circular(14),
                                        topLeft: Radius.circular(14)),
                                    child: CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.13,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        fit: BoxFit.fitHeight,
                                        imageUrl: data?['videoImage'],
                                        placeholder: (context, url) => Center(
                                              child: Image.asset(
                                                'assets/images/board2.jpg',
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.08,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.2,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            Image.asset(
                                              'assets/images/board2.jpg',
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.08,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.2,
                                              fit: BoxFit.fill,
                                            )),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: Text(
                                      title,
                                      style: const TextStyle(
                                          fontSize: 16,
                                          color: textColor,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  const Icon(Icons.play_circle_outline_rounded,
                                      size: 40, color: Colors.black),
                                  const SizedBox(width: 10),
                                ]),
                          ],
                        ),
                      ),
                    ),
                  );
                });
              },
            ),
          ),
        )),
      ),
    );
  }
}
