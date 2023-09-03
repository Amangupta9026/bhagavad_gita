// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/file_collection.dart';

final postUserNotifierProvider =
    AsyncNotifierProvider<PostNotifer, PostMode>(() {
  return PostNotifer();
});

class PostMode {
  final TextEditingController textPostController = TextEditingController();
  final TextEditingController textCommentController = TextEditingController();
  File? getImage;
}

class PostNotifer extends AsyncNotifier<PostMode> {
  final PostMode _postMode = PostMode();

  void clearTextFields() {
    _postMode.textPostController.clear();
  }

  Future<void> addPost(int id) async {
    EasyLoading.show(status: 'loading...');
    if (_postMode.textPostController.text.isNotEmpty ||
        _postMode.getImage != null) {
      await FirebaseFirestore.instance.collection('posts').add({
        "id": id,
        "phone": FirebaseAuth.instance.currentUser!.phoneNumber,
        "post": _postMode.textPostController.text,
        "userName": "Anonymous",
        "userImage": "",
        "servertime": FieldValue.serverTimestamp()
      });
      sendFileImage(id);
      EasyLoading.dismiss();
      toast("Post Added");
      //  clearimage();
      clearTextFields();
    } else {
      EasyLoading.dismiss();
      toast("Please fill the field");
    }
  }

  clearimage() {
    _postMode.getImage = null;
    log('image cleared');
  }

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      _postMode.getImage = imageTemp;

      // state = AsyncData(_adminMoreAppsMode.getImage! as AdminMoreAppsMode);
    } on PlatformException catch (e) {
      log('Failed to pick image: $e');
    }
    state = AsyncData(_postMode);
  }

  void sendFileImage(int id) async {
    var postSnapShot = await FirebaseFirestore.instance
        .collection('posts')
        .where('id', isEqualTo: id)
        .get();
    var docId = postSnapShot.docs.first.id;

    final ref = FirebaseStorage.instance
        .ref()
        .child('posts')
        .child(id.toString()); // ref shortcut

    await ref.putFile(_postMode.getImage!);
    final url = await ref.getDownloadURL();
    log(name: 'url', url);
    await FirebaseFirestore.instance.collection('posts').doc(docId).update({
      'userImage': url,
    });
    removeImage();
  }

  void removeImage() {
    _postMode.getImage = null;
    state = AsyncData(_postMode);
    log('image removed');
    //  state = _adminMoreAppsMode.getImage as AsyncValue<AdminMoreAppsMode>;
  }

  void deleteData(BuildContext context, id, String phone) async {
    var postSnapShot = await FirebaseFirestore.instance
        .collection('posts')
        .where('id', isEqualTo: id)
        .get();
    var docId = postSnapShot.docs.first.id;
    log('docId: $docId');
    if (id == id && phone == FirebaseAuth.instance.currentUser!.phoneNumber) {
      await FirebaseFirestore.instance.collection('posts').doc(docId).delete();

      toast("Deleted Successfully");
    } else {
      toast("You can delete only your post");
    }
    state = AsyncData(_postMode);
    navigateToPost(context);
  }

  // // Post coments
  // void addComment(int id) async {
  //   EasyLoading.show(status: 'loading...');
  //   if (_postMode.textCommentController.text.isNotEmpty) {
  //     await FirebaseFirestore.instance.collection('comments').add({
  //       "id": id,
  //       "phone": FirebaseAuth.instance.currentUser!.phoneNumber,
  //       "comment": _postMode.textCommentController.text,
  //       "userName": "Anonymous",
  //       "userImage": "",
  //       "servertime": FieldValue.serverTimestamp()
  //     });
  // EasyLoading.dismiss();
  // toast("Comment Added");
  // clearTextFields();
  //   } else {
  //     EasyLoading.dismiss();
  //     toast("Please fill the field");
  //   }
  // }

  // // Get Post Document Id
  // Future getPostDocumentId(int id) async {
  //   var postSnapShot = await FirebaseFirestore.instance
  //       .collection('posts')
  //       .where('id', isEqualTo: id)
  //       .get();
  //   var docId = postSnapShot.docs.first.id;
  //   log('docId: $docId');
  //   log('id: $id');
  //   return docId;
  // }

  void navigateToPost(BuildContext context) {
    Navigator.pop(context);
  }

  @override
  build() {
    return _postMode;
  }
}
