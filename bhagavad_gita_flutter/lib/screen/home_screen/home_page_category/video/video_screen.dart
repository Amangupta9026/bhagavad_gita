// ignore_for_file: use_build_context_synchronously

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
            child: Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 0, 0, 60),
          child: Column(
            children: [
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('allVideo')
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
                  return
                      // Container(
                      //   color: backgroundColor,
                      //   child: const Padding(
                      //     padding: EdgeInsets.fromLTRB(8.0, 8, 8, 15),
                      //     child:
                      //         InkWell(onTap: null, child: SearchItemTextField()),
                      //   ),
                      // ),
                      Consumer(builder: (context, ref, child) {
                    final refRead = ref.read(videoNotifierProvider.notifier);
                    return ListView.builder(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: data?.length ?? 0,
                        itemBuilder: (context, int index) {
                          String title = data?[index]['videoTitle'];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 30.0),
                            child: InkWell(
                              onTap: () async {
                                EasyLoading.show(status: 'Loading...');

                                List<Video> videos = [];

                                var docSnapShot = await FirebaseFirestore
                                    .instance
                                    .collection("allVideo")
                                    .where('videoTitle', isEqualTo: title)
                                    .get();

                                var docID = docSnapShot.docs.first.id;

                                final data = await FirebaseFirestore.instance
                                    .collection("allVideo")
                                    .doc(docID)
                                    .get();

                                final String? playListUrl =
                                    data.data()?["videoUrl"];
                                if (playListUrl == null) return;
                                await for (var video in yt.playlists
                                    .getVideos(Uri.parse(playListUrl))) {
                                  videos.add(video);
                                }

                                refRead.setVideos(videos);

                                context.pushNamed(RouteNames.videoView,
                                    pathParameters: {
                                      'title': title,
                                    });
                                EasyLoading.dismiss();
                              },
                              child: Column(
                                children: [
                                  Row(children: [
                                    CachedNetworkImage(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                0.08,
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.2,
                                        fit: BoxFit.fill,
                                        imageUrl: data?[index]['videoImage'],
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
                                    const SizedBox(width: 10),
                                    Flexible(
                                      flex: 2,
                                      child: Text(
                                        title,
                                        style: const TextStyle(
                                            fontSize: 16,
                                            color: textColor,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                    const Icon(
                                        Icons.play_circle_outline_rounded,
                                        size: 40,
                                        color: Colors.black)
                                  ]),
                                  const Divider(
                                    height: 25,
                                    color: Colors.grey,
                                  )
                                ],
                              ),
                            ),
                          );
                        });
                  });
                },
              ),
            ],
          ),
        )),
      ),
    );
  }
}
