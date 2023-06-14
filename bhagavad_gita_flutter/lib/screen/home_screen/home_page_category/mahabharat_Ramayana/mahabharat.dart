// ignore_for_file: use_build_context_synchronously

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

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
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15.0, 30, 15, 40),
          child: Column(
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: InkWell(
                        onTap: () async {
                        
                  List<Video> videos = [];
                  final data = await FirebaseFirestore.instance
                      .collection("playListMahabharat").doc().get();
                      
                  final String? playListUrl = data.data()?["playListUrl"];
                  if (playListUrl == null) return;
                  await for (var video
                      in yt.playlists.getVideos(Uri.parse(playListUrl))) {
                    videos.add(video);
                  }

            //      context.read<CourseVideoNotifier>().setVideos(videos);

                  // context.push(
                  //   RouteNames.courseView);
               
                        },
                        child: Card(
                          elevation: 15,
                          margin: EdgeInsets.zero,
                          child: Container(
                            padding: EdgeInsets.zero,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    ClipRRect(
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                      child: Image.asset(
                                        'assets/images/board5.jpg',
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        height: 160,
                                        alignment: Alignment.topCenter,
                                      ),
                                    ),
                                    Positioned.fill(
                                      bottom: -20,
                                      right: 10,
                                      child: Align(
                                        alignment: Alignment.bottomRight,
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor: darkBlueColor,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                      side: BorderSide(
                                                color: Colors.white,
                                              ))),
                                          onPressed: () {},
                                          child: const Text("Play"),
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
                                      const Text("Mahabharat",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: textColor,
                                              fontWeight: FontWeight.w600)),
                                      Row(
                                        children: [
                                          RatingBar.builder(
                                            ignoreGestures: true,
                                            initialRating: 5.0,
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemSize: 16,
                                            itemPadding:
                                                const EdgeInsets.symmetric(
                                                    horizontal: 1.0),
                                            itemBuilder: (context, _) =>
                                                const Icon(
                                              Icons.star,
                                              color: yellowColor,
                                              size: 3,
                                            ),
                                            onRatingUpdate: (rating) {},
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
                  }),
            ],
          ),
        ),
      )),
    );
  }
}
