// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import 'package:bhagavad_gita_flutter/utils/colors.dart';
import 'package:bottom_bar_matu/utils/app_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';

import 'package:share_plus/share_plus.dart';

import 'post_container.dart';

class PostDetailScreen extends StatelessWidget {
  final String? url;
  final String? caption;
  final String? timeAgo;
  final String? postid;
  final String? phone;

  const PostDetailScreen({Key? key, this.url, this.caption, this.timeAgo, this.postid, this.phone})
      : super(key: key);

  void saveNetworkImage(String urlImage) async {
    try {
      log('$url');
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
    log(caption ?? '');
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
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
            if (url != ' ')
              IconButton(
                icon: const Icon(
                  Icons.download,
                  color: Colors.white,
                ),
                onPressed: () {
                  saveNetworkImage('$url.png');
                },
              ),
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
                        child:
                            // imageUrl!,
                            CachedNetworkImage(
                      imageUrl: url ?? '',
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: BoxFit.cover,
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
                ],
              ),
            ),
          ),
        ));
  }
}
