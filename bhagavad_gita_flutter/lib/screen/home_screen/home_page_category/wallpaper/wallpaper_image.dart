// ignore_for_file: use_build_context_synchronously, unused_local_variable

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:share_plus/share_plus.dart';

class WallpaperImage extends StatelessWidget {

  final String? imageUrl;
  const WallpaperImage({Key? key, this.imageUrl}) : super(key: key);

  save() async {
    EasyLoading.show(status: 'downloading...');
    var response = await Dio().get(
        'https://m.media-amazon.com/images/I/71eKV2BYQrL._AC_UF894,1000_QL80_.jpg',
        options: Options(responseType: ResponseType.bytes));
    final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(response.data),
        quality: 100,
        name: "Bhagwavad Gita");
    EasyLoading.dismiss();
    if (result['isSuccess']) {
      EasyLoading.showSuccess('Downloaded Successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: () async {
                log(imageUrl ?? '');
                await save();
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
                child: Image.network(imageUrl!),
              ),
            ),
          ),
        ));
  }
}
