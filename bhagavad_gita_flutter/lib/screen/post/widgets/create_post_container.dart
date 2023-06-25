import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../riverpod/post_feed_notifier.dart';
import '../../../utils/colors.dart';
import 'profile_avatar.dart';

class CreatePostContainer extends StatelessWidget {
  const CreatePostContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 0.0),
        elevation: 0.0,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
          color: Colors.white,
          child: Column(
            children: [
              Consumer(
                builder: (context, ref, child) {
                  final postWatch = ref.watch(postUserNotifierProvider);
                  final postRead = ref.read(postUserNotifierProvider.notifier);
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const ProfileAvatar(
                        imageUrl:
                            'https://blogger.googleusercontent.com/img/a/AVvXsEhsdyvsG2PDIUCWAE1GnWSoU6HGgh07QiNH39BUZ4LgV_oxR9I78SY7DMb_7zu4nqUM3hQZEGBeyHixWVPVhR9T20NZHELVH2i5QMHj930YxMvCkNtnvkLz67Wh6CbjB1kIikyPNFK8rTUEEArWmlwOaYqCf7w3fb4lT3qwObAopT1dx7UK-3ZZOK6E=s16000',
                      ),
                      const SizedBox(width: 8.0),
                      Expanded(
                        child: TextField(
                          maxLines: 2,
                          controller: postWatch.value?.textPostController,
                          decoration: const InputDecoration.collapsed(
                            hintText: 'What\'s on your mind?',
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          postRead.pickImage();
                        },
                        child: const Column(children: [
                          Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 30,
                          ),
                          Text('Photo',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w500,
                              )),
                        ]),
                      )
                    ],
                  );
                },
              ),
              const Divider(thickness: 0.5),
              const SizedBox(height: 10.0),

              // last doc id

              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .orderBy('id', descending: true)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  var postData = snapshot.data?.docs;
                  int lastPostDocId = postData?.length ?? 0;
                  // Last post doc id
                  // log('lastPostDocId: $lastPostDocId');

                  return Consumer(builder: (context, ref, child) {
                    final postRead =
                        ref.read(postUserNotifierProvider.notifier);
                    final postWatch = ref.watch(postUserNotifierProvider);
                    return SizedBox(
                      height: 40.0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              postRead.addPost(lastPostDocId + 1);
                              
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: const LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  stops: [0.2, 0.6],
                                  colors: [primaryColor, colorGradient2],
                                ),
                              ),
                              child: TextButton(
                                onPressed: () {
                                  postRead.addPost(lastPostDocId + 1);
                                  postRead.removeImage();
                                },
                                child: const Row(
                                  children: [
                                    Icon(
                                      Icons.security_rounded,
                                      color: textColor,
                                      size: 24,
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      'Post',
                                      style: TextStyle(
                                        color: textColor,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          if (postWatch.value?.getImage != null)
                            InkWell(
                              onTap: () {
                                postRead.removeImage();
                              },
                              child: Stack(
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text('Photo Added',
                                          textAlign: TextAlign.center),
                                    ),
                                    // Image.file(
                                    //   File(postWatch.value?.path ?? ""),
                                    //   fit: BoxFit.cover,
                                    //   width: double.infinity,
                                    // ),
                                  ),
                                  Positioned.fill(
                                    top: -4,
                                    right: -4,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Container(
                                        width: 20,
                                        height: 20,
                                        decoration: const BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: primaryColor,
                                        ),
                                        child: InkWell(
                                          onTap: () {
                                            postRead.removeImage();
                                          },
                                          child: const Center(
                                            child: Icon(
                                              Icons.close,
                                              color: Colors.white,
                                              size: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    );
                  });
                },
              ),
              const SizedBox(height: 5.0),
            ],
          ),
        ),
      ),
    );
  }
}
