import 'dart:developer';

import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final adminWallpaperNotifierProvider =
    NotifierProvider<AdminWallpaperNotifier, List<XFile>?>(() {
  return AdminWallpaperNotifier();
});

class AdminWallpaperNotifier extends Notifier<List<XFile>?> {
  @override
  List<XFile>? build() {
    return imageFileList;
  }

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? imageFileList = [];

  void selectImages() async {
    final List<XFile> selectedImages = await imagePicker.pickMultiImage();
    if (selectedImages.isNotEmpty) {
      imageFileList?.addAll(selectedImages);
    }
    log("Image List Length: ${imageFileList?.length}");
    state = [...imageFileList!];
  }
}
