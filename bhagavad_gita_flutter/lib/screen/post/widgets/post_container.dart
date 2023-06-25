import 'dart:developer';

import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../../../riverpod/post_feed_notifier.dart';
import '../../../riverpod/post_like_coment_notfier.dart';
import '../../../router/routes_names.dart';
import '../../../widget/alertdialogbox.dart';
import '../config/palette.dart';
import 'profile_avatar.dart';

class PostContainer extends StatelessWidget {
  const PostContainer({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        vertical: 5.0,
        horizontal: 0.0,
      ),
      elevation: 0.0,
      shape: null,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        color: Colors.white,
        child: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('posts')
              .orderBy('servertime', descending: true)
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            var postSnapshot = snapshot.data?.docs;
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
            return ListView.builder(
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 40),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                int postid = postSnapshot?[index]['id'] ?? '';
                String phone = postSnapshot?[index]['phone'] ?? '';
                //  log(postid.toString(), name: 'id');

                String timaAgo = timeago.format(
                  postSnapshot?[index]['servertime'] == null
                      ? DateTime.now()
                      : postSnapshot?[index]['servertime'].toDate(),
                );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        if (postSnapshot?[index]['post'] == "") {
                          context.pushNamed(RouteNames.postDetailScreen,
                              pathParameters: {
                                'url': postSnapshot?[index]['userImage'] ?? '',
                                'caption': ' ',
                                'timeAgo': timaAgo,
                                'postid': postid.toString(),
                                'phone': phone.toString()
                              });
                        } else if (postSnapshot?[index]['userImage'] == "") {
                          context.pushNamed(RouteNames.postDetailScreen,
                              pathParameters: {
                                'url': ' ',
                                'caption': postSnapshot?[index]['post'] ?? '',
                                'timeAgo': timaAgo,
                                'postid': postid.toString(),
                                'phone': phone.toString()
                              });
                        } else {
                          context.pushNamed(RouteNames.postDetailScreen,
                              pathParameters: {
                                'url': postSnapshot?[index]['userImage'] ?? '',
                                'caption': postSnapshot?[index]['post'] ?? '',
                                'timeAgo': timaAgo,
                                'postid': postid.toString(),
                                'phone': phone.toString()
                              });
                        }
                      },
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                PostHeader(
                                  name: postSnapshot?[index]['userName'] ?? '',
                                  profileUrl:
                                      'https://blogger.googleusercontent.com/img/a/AVvXsEhsdyvsG2PDIUCWAE1GnWSoU6HGgh07QiNH39BUZ4LgV_oxR9I78SY7DMb_7zu4nqUM3hQZEGBeyHixWVPVhR9T20NZHELVH2i5QMHj930YxMvCkNtnvkLz67Wh6CbjB1kIikyPNFK8rTUEEArWmlwOaYqCf7w3fb4lT3qwObAopT1dx7UK-3ZZOK6E=s16000',
                                  timeAgo: timaAgo,
                                  id: postid,
                                  phone: phone,
                                ),
                                const SizedBox(height: 5.0),
                                if (postSnapshot?[index]['post'] != "")
                                  Text(
                                    postSnapshot?[index]['post'] ?? '',
                                  ),
                                postSnapshot?[index]['userImage'] != ""
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.only(
                                            bottomLeft: Radius.circular(9),
                                            topLeft: Radius.circular(9)),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 15.0, bottom: 5),
                                          child: CachedNetworkImage(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.190,
                                              width: double.infinity,
                                              fit: BoxFit.cover,
                                              imageUrl: postSnapshot?[index]
                                                  ['userImage'],
                                              placeholder: (context, url) =>
                                                  Center(
                                                    child: Image.asset(
                                                      'assets/images/board2.jpg',
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.190,
                                                      width: double.infinity,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                    'assets/images/board2.jpg',
                                                    height:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                            0.190,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                  )),
                                        ),
                                      )
                                    : const SizedBox.shrink(),
                                const SizedBox(height: 20.0),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: PostStats(postid)),
                    const SizedBox(height: 20.0),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class PostHeader extends StatelessWidget {
  final String? name;
  final String? profileUrl;
  final String? timeAgo;
  final int? id;
  final String? phone;
  PostHeader({
    Key? key,
    this.name,
    this.profileUrl,
    this.timeAgo,
    this.id,
    this.phone,
  }) : super(key: key);

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _scaffoldKey,
      child: Row(
        children: [
          ProfileAvatar(imageUrl: profileUrl),
          const SizedBox(width: 8.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      timeAgo ?? '',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 12.0,
                      ),
                    ),
                    const SizedBox(width: 4.0),
                    Icon(
                      Icons.public,
                      color: Colors.grey[600],
                      size: 12.0,
                    )
                  ],
                ),
              ],
            ),
          ),
          Container(
            color: Colors.white,
            child: PopupMenuButton(
              icon: const Icon(
                Icons.more_horiz,
                color: Colors.grey,
              ),
              color: Colors.white,
              padding: const EdgeInsets.all(0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              itemBuilder: (context) => [
                // PopupMenuItem 1
                PopupMenuItem(
                  value: 1,
                  padding: const EdgeInsets.all(0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                    child: Column(
                      children: [
                        Consumer(
                          builder: (context, ref, child) {
                            final postRead =
                                ref.read(postUserNotifierProvider.notifier);
                            return InkWell(
                              onTap: () {
                                showMyDialog(
                                  context,
                                  "Delete this Post",
                                  'Are you sure you want to delete this post ?',
                                  () {
                                    postRead.navigateToPost(context);
                                    postRead.deleteData(
                                        context, id ?? 0, phone ?? "");
                                  },
                                  istwobutton: true,
                                  actiontap1: () {
                                    postRead.navigateToPost(context);
                                    postRead.navigateToPost(context);
                                  },
                                );
                              },
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(Icons.delete),
                                  SizedBox(width: 10),
                                  Text("Delete")
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            context.pop();
                            showMyDialog(
                              context,
                              "Report Post",
                              'Are you sure you want to report this post ?',
                              () {
                                context.pop();
                                toast("Reported Successfully");
                              },
                              istwobutton: true,
                              actiontap1: () {
                                context.pop();
                              },
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.report),
                              SizedBox(width: 10),
                              Text("Report")
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        InkWell(
                          onTap: () {
                            context.pop();
                            showMyDialog(
                              context,
                              "Notifications Off",
                              'Are you sure you want to notifications off for this user ?',
                              () {
                                context.pop();
                                toast("Notifications Off");
                              },
                              istwobutton: true,
                              actiontap1: () {
                                context.pop();
                              },
                            );
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.notifications_off),
                              SizedBox(
                                width: 10,
                              ),
                              Text("Notifications Off")
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],

              offset: const Offset(0, 40),

              elevation: 2,
              // on selected we show the dialog box
              onSelected: (value) {},
            ),
          ),
        ],
      ),
    );
  }
}

class PostStats extends ConsumerWidget {
  final int? postId;
  const PostStats(
    this.postId, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final refRead = ref.read(likeComentpostUserNotifierProvider.notifier);
    final refWatch = ref.watch(likeComentpostUserNotifierProvider);
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: const BoxDecoration(
                color: Palette.secondBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 4.0),
            Expanded(
              child: Text(
                '500 Likes',
                style: TextStyle(
                  color: Colors.grey[600],
                ),
              ),
            ),
            // Text(
            //   '10 Comments',
            //   style: TextStyle(
            //     color: Colors.grey[600],
            //   ),
            // ),
            // const SizedBox(width: 8.0),
            // Text(
            //   ' Shares',
            //   style: TextStyle(
            //     color: Colors.grey[600],
            //   ),
            // )
          ],
        ),
        const Divider(),
        Consumer(
          builder: (context, ref, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _PostButton(
                  icon: Icon(
                    MdiIcons.thumbUpOutline,
                    color: refWatch.value!.isLiked
                        ? Colors.grey[600]
                        : Palette.secondBlue,
                    size: 20.0,
                  ),
                  label: Text('Like',
                      style: TextStyle(
                        color: refWatch.value!.isLiked
                            ? Colors.grey[600]
                            : Palette.secondBlue,
                      )),
                  onTap: () {
                    refRead.isLike(postId ?? 0);

                    log(postId.toString());
                  },
                ),
                // _PostButton(
                //   icon: Icon(
                //     MdiIcons.commentOutline,
                //     color: Colors.grey[600],
                //     size: 20.0,
                //   ),
                //   label: 'Comment',
                //   onTap: () => print('Comment'),
                // ),
                _PostButton(
                  icon: Icon(
                    MdiIcons.shareOutline,
                    color: Colors.grey[600],
                    size: 25.0,
                  ),
                  label:
                      Text('Share', style: TextStyle(color: Colors.grey[600])),
                  onTap: () {
                    Share.share(
                        subject: 'Bhagwavad Gita',
                        'hey! check out this amazing Bhagavad Gita app\nhttps://play.google.com/store/apps/details?id=com.flashcoders.bhagavad_gita_ai&hl=en_IN&gl=US');
                  },
                )
              ],
            );
          },
        ),
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon? icon;
  final Widget? label;
  final Function? onTap;

  const _PostButton({
    Key? key,
    @required this.icon,
    @required this.label,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap as void Function()?,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon!,
                const SizedBox(width: 4.0),
                label ?? Container(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
