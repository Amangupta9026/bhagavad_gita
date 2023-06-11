import 'dart:developer';

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
    state =  AsyncData([..._imageFileList])   ;
  }

  void removeImage(int index) {
    _imageFileList.removeAt(index);
    state = AsyncData([..._imageFileList])   ;
  }
}
