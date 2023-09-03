// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:share_plus/share_plus.dart';

import '../../../riverpod/post_like_coment_notfier.dart';
import 'post_container.dart';

class PostDetailScreen extends StatelessWidget {
  final String? url;
  final String? caption;
  final String? timeAgo;
  final String? postid;
  final String? phone;

  const PostDetailScreen(
      {Key? key, this.url, this.caption, this.timeAgo, this.postid, this.phone})
      : super(key: key);

  void saveNetworkImage(String urlImage) async {
    try {
      EasyLoading.show(status: 'downloading...');
      String path = urlImage;
      GallerySaver.saveImage(path).then((bool? success) {
        if (success != null && success) {
          EasyLoading.dismiss();
          if (success) {
            EasyLoading.showSuccess('Downloaded Successfully');
          }
        }
      });
    } catch (e) {
      log('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              padding: const EdgeInsets.all(0),
              icon: const Icon(
                Icons.share,
                color: Colors.white,
              ),
              onPressed: () {
                Share.share(
                    subject: 'Bhagwavad Gita',
                    'hey! check out this amazing Bhagwavad Gita app\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US');
              },
            ),

            Visibility(
              visible: caption != ' ',
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.copy,
                      color: Colors.white,
                    ),
                  ],
                ),
                onPressed: () {
                  Clipboard.setData(ClipboardData(text: caption ?? ''));
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Copied to clipboard'),
                    ),
                  );
                },
              ),
            ),
            // if (url != ' ')
            Visibility(
              visible: url != ' ',
              child: IconButton(
                padding: const EdgeInsets.all(0),
                icon: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.download,
                      color: Colors.white,
                    ),
                  ],
                ),
                onPressed: () {
                  saveNetworkImage('$url.png');
                },
              ),
            ),
            const SizedBox(width: 10),
          ],
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10.0, 15, 10, 15),
              child: Column(
                children: [
                  PostHeader(
                    name: 'Anonymous',
                    profileUrl:
                        'https://blogger.googleusercontent.com/img/a/AVvXsEhsdyvsG2PDIUCWAE1GnWSoU6HGgh07QiNH39BUZ4LgV_oxR9I78SY7DMb_7zu4nqUM3hQZEGBeyHixWVPVhR9T20NZHELVH2i5QMHj930YxMvCkNtnvkLz67Wh6CbjB1kIikyPNFK8rTUEEArWmlwOaYqCf7w3fb4lT3qwObAopT1dx7UK-3ZZOK6E=s16000',
                    timeAgo: timeAgo,
                    id: postid.toInt(),
                    phone: phone,
                  ),
                  const SizedBox(height: 20),
                  if (caption != " ")
                    Column(
                      children: [
                        Text(
                          caption ?? '',
                          style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              color: textColor),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  if (url != ' ')
                    InteractiveViewer(
                        child: CachedNetworkImage(
                      imageUrl: url ?? '',
                      width: MediaQuery.of(context).size.width,
                      //  height: MediaQuery.of(context).size.height / 2,
                      fit: BoxFit.fill,
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/board4.jpg",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                      placeholder: (context, url) => Image.asset(
                        "assets/images/board4.jpg",
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    )),
                  const SizedBox(height: 20),
                  PostStats(postid.toInt(), false),
                  const SizedBox(height: 20),
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('posts')
                          .where('id', isEqualTo: postid.toInt())
                          .snapshots(),
                      builder: (context,
                          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                              snapshot) {
                        var commentSnapshot = snapshot.data?.docs;

                        if (!snapshot.hasData) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Column(
                          children: [
                            ListView.builder(
                                itemCount: (commentSnapshot?.first
                                            .data()
                                            .containsKey('comments') ??
                                        false)
                                    ? (commentSnapshot?.first
                                        .data()['comments']
                                        .length)
                                    : 0,

                                // commentSnapshot?.first
                                //         .data()['comments']
                                //         .length ??
                                //     0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(0),
                                itemBuilder:
                                    (BuildContext context, int index2) {
                                  var data = (commentSnapshot?.first
                                              .data()
                                              .containsKey('comments') ??
                                          false)
                                      ? (commentSnapshot?.first
                                          .data()['comments'][index2])
                                      : 0;

                                  return Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 15.0),
                                    child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Colors.white,
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Column(
                                              children: [
                                                CircleAvatar(
                                                  radius: 24.0,
                                                  backgroundImage:
                                                      CachedNetworkImageProvider(
                                                          'https://blogger.googleusercontent.com/img/a/AVvXsEhsdyvsG2PDIUCWAE1GnWSoU6HGgh07QiNH39BUZ4LgV_oxR9I78SY7DMb_7zu4nqUM3hQZEGBeyHixWVPVhR9T20NZHELVH2i5QMHj930YxMvCkNtnvkLz67Wh6CbjB1kIikyPNFK8rTUEEArWmlwOaYqCf7w3fb4lT3qwObAopT1dx7UK-3ZZOK6E=s16000'),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(width: 6),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  color: Colors.grey[200],
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          12.0, 6, 12, 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      const Text(
                                                        'Anonymous',
                                                        style: TextStyle(
                                                            fontSize: 17,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: textColor),
                                                      ),
                                                      const SizedBox(height: 4),
                                                      Text(
                                                        (commentSnapshot?.first
                                                                    .data()
                                                                    .containsKey(
                                                                        'comments') ??
                                                                false)
                                                            ? (data?[
                                                                    'comment'] ??
                                                                '')
                                                            : '',
                                                        style: const TextStyle(
                                                            fontSize: 15,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            color: textColor),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        )),
                                  );
                                }),
                            const SizedBox(height: 10),
                            Consumer(builder: (context, ref, child) {
                              final userComent = ref.read(
                                  likeComentpostUserNotifierProvider.notifier);
                              final userComentWatch =
                                  ref.watch(likeComentpostUserNotifierProvider);

                              return Column(children: [
                                TextFormField(
                                  controller: userComentWatch
                                      .value?.textCommentController,
                                  maxLines: 2,
                                  decoration: InputDecoration(
                                    hintText: 'Add a comment',
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    fillColor: primaryColor,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                          color: primaryColor, width: 2.0),
                                    ),
                                    suffixIcon: IconButton(
                                      icon: const Icon(
                                        Icons.send,
                                        color: primaryColor,
                                      ),
                                      onPressed: () {
                                        userComent.addComments(postid.toInt());
                                      },
                                    ),
                                  ),
                                ),
                              ]);
                            }),
                            const SizedBox(height: 10),
                          ],
                        );
                      }),
                ],
              ),
            ),
          ),
        ));
  }
}
