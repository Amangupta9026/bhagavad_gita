// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final adminWallpaperNotifierProvider =
    AsyncNotifierProvider<AdminWallpaperNotifier, AdminWallpaperMode>(() {
  return AdminWallpaperNotifier();
});

class AdminWallpaperMode {
  File? getImage;
}

class AdminWallpaperNotifier extends AsyncNotifier<AdminWallpaperMode> {
  final AdminWallpaperMode _adminWallpaperMode = AdminWallpaperMode();
  @override
  build() {
    return _adminWallpaperMode;
  }

  Future selectImages() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      _adminWallpaperMode.getImage = imageTemp;

      // state = AsyncData(_adminMoreAppsMode.getImage! as AdminMoreAppsMode);
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
    state = AsyncData(_adminWallpaperMode);
  }

  void removeImage() {
    _adminWallpaperMode.getImage = null;
    state = AsyncData(_adminWallpaperMode);
  }

  Future<void> wallpaperSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    await FirebaseFirestore.instance.collection('wallpaper').add({
      'id': _adminWallpaperMode.getImage!.path,
      'server_time': FieldValue.serverTimestamp(),
    });

    sendFileImage();

    EasyLoading.dismiss();

    context.pushNamed(RouteNames.adminWallpaper);
    toast("Wallpaper Added Successfully");
  }

  void sendFileImage() async {
    //var
    var wallpaperSnapShot = await FirebaseFirestore.instance
        .collection('wallpaper')
        .where('id', isEqualTo: _adminWallpaperMode.getImage!.path)
        .get();
    var docId = wallpaperSnapShot.docs.first.id;

    final ref = FirebaseStorage.instance.ref().child('wallpaper').child(docId);
    // List<String> imageUrls = [];
    // for (int i = 0; i < _adminWallpaperMode._imageFileList.length; i++) {
    //   final imageUrl =
    //       await ref.child(i.toString()).putFile(File(_adminWallpaperMode._imageFileList[i].path));
    //   imageUrls.add(imageUrl.toString());
    //   final getUrl = await imageUrl.ref.getDownloadURL();
    //   imageUrls.add(getUrl);
    //   log('urlget $imageUrls');

    //  final url = await ref.getDownloadURL();
    // await FirebaseFirestore.instance
    //     .collection('wallpaper')
    //     .doc(wallpaperId.toString())
    //     .update({
    //   'url': getUrl,
    // });

    await ref.putFile(_adminWallpaperMode.getImage!);

    final url = await ref.getDownloadURL();
    log(name: 'url', url);
    await FirebaseFirestore.instance.collection('wallpaper').doc(docId).update({
      'url': url,
    });
  }
}
