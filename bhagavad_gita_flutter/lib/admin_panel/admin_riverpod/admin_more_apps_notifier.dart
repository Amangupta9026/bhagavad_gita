// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final moreAppsNotifierProvider =
    AsyncNotifierProvider<AdminMoreAppsNotifier, AdminMoreAppsMode>(() {
  return AdminMoreAppsNotifier();
});

class AdminMoreAppsMode {
  final TextEditingController appNameController = TextEditingController();
  final TextEditingController appLinkController = TextEditingController();
  File? getImage;
  AdminMoreAppsMode();
}

class AdminMoreAppsNotifier extends AsyncNotifier<AdminMoreAppsMode> {
  final AdminMoreAppsMode _adminMoreAppsMode = AdminMoreAppsMode();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      _adminMoreAppsMode.getImage = imageTemp;

      // state = AsyncData(_adminMoreAppsMode.getImage! as AdminMoreAppsMode);
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
  }

  void removeImage() {
    _adminMoreAppsMode.getImage;
    //  state = _adminMoreAppsMode.getImage as AsyncValue<AdminMoreAppsMode>;
  }

  void sendFileImage() async {
    var moreAppsSnapShot = await FirebaseFirestore.instance
        .collection('moreApps')
        .where('appName', isEqualTo: _adminMoreAppsMode.appNameController.text)
        .get();
    var docId = moreAppsSnapShot.docs.first.id;

    final ref = FirebaseStorage.instance
        .ref()
        .child('moreApps')
        .child(_adminMoreAppsMode.appNameController.text);

    await ref.putFile(_adminMoreAppsMode.getImage!);
    final url = await ref.getDownloadURL();
    log(name: 'url', url);
    await FirebaseFirestore.instance.collection('moreApps').doc(docId).update({
      'appImage': url,
    });
  }

  void clearTextFields() {
    _adminMoreAppsMode.appNameController.clear();
    _adminMoreAppsMode.appLinkController.clear();
  }

  void onSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    if (_adminMoreAppsMode.appNameController.text.isNotEmpty &&
        _adminMoreAppsMode.getImage != null &&
        _adminMoreAppsMode.appLinkController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('moreApps').add({
        'appName': _adminMoreAppsMode.appNameController.text,
        'appLink': _adminMoreAppsMode.appLinkController.text,
        'servertime': FieldValue.serverTimestamp(),
      });
      sendFileImage();
      EasyLoading.dismiss();
      context.pushNamed(RouteNames.main);
      clearTextFields();
      toast("App Added Successfully");
    } else {
      EasyLoading.dismiss();
      toast("Please fill all the fields");
    }
  }

  @override
  build() {
    return _adminMoreAppsMode;
  }
}
