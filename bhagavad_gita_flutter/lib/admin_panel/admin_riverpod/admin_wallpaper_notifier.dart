// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final adminWallpaperNotifierProvider =
    AsyncNotifierProvider<AdminWallpaperNotifier, List<XFile>>(() {
  return AdminWallpaperNotifier();
});

class AdminWallpaperNotifier extends AsyncNotifier<List<XFile>> {
  @override
  List<XFile> build() {
    return _imageFileList;
  }

  final ImagePicker _imagePicker = ImagePicker();
  final List<XFile> _imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await _imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      _imageFileList.addAll(selectedImages);
    }
    log("Image List Length: ${_imageFileList.length}");
    state = AsyncData([..._imageFileList]);
  }

  void removeImage(int index) {
    _imageFileList.removeAt(index);
    state = AsyncData([..._imageFileList]);
  }

  Future<void> wallpaperSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    try {
      final wallpaperSnapShot = await FirebaseFirestore.instance
          .collection('wallpaper')
          .orderBy("id", descending: true)
          .limit(1)
          .get();
      int wallpaperId = 1;
      if (wallpaperSnapShot.docs.isNotEmpty) {
        wallpaperId =
            (int.tryParse(wallpaperSnapShot.docs.first.data()['id']) ?? -1) + 1;
      }
      await FirebaseFirestore.instance.collection('wallpaper').add({
        'id': wallpaperId.toString(),
        'server_time': FieldValue.serverTimestamp(),
      });
      if (_imageFileList.isNotEmpty) {
        sendFileImage(wallpaperId);
      }
      context.pushNamed(RouteNames.main);
      toast("Wallpaper Added Successfully");
    } catch (e) {
      log("$e");
    }
    EasyLoading.dismiss();
  }

  void sendFileImage(int wallpaperId) async {
    final ref = FirebaseStorage.instance
        .ref()
        .child('wallpaper')
        .child(wallpaperId.toString());
    for (int i = 0; i < _imageFileList.length; i++) {
      await ref.child(i.toString()).putFile(File(_imageFileList[i].path));

      // final url = await ref.getDownloadURL();
      // await FirebaseFirestore.instance
      //     .collection('wallpaper')
      //     .doc(wallpaperId.toString())
      //     .update({
      //   'url': url,
      // });
    }

    //  await ref. putFile(File(_imageFileList.first.path));

    //   final url = await ref.getDownloadURL();

    //   await FirebaseFirestore.instance
    //       .collection('wallpaper')
    //       // .doc(wallpaperId.toString())
    //       .add({
    //     'url': url,
    //   });
  }
}
