// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class WallpaperImage extends StatelessWidget {
  // final Widget? imageUrl;
  final String? url;
  const WallpaperImage({Key? key, this.url}) : super(key: key);

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
    //  PermissionUtil.requestAll();
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
          child: Center(
            child: SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: InteractiveViewer(
                  child:
                      // imageUrl!,
                      CachedNetworkImage(
                imageUrl: url ?? '',
                width: double.infinity,
                height: double.infinity,
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
            ),
          ),
        ));
  }
}
