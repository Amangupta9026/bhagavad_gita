import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/file_collection.dart';
import '../widget/toast_widget.dart';

final likeComentpostUserNotifierProvider =
    AsyncNotifierProvider<PostNotifer, LikeComentPostMode>(() {
  return PostNotifer();
});

class LikeComentPostMode {
  bool isLiked = false;
  final TextEditingController textCommentController = TextEditingController();
  bool isCommentBox = false;
  int? postData;
}

class PostNotifer extends AsyncNotifier<LikeComentPostMode> {
  final LikeComentPostMode _likeComentpostMode = LikeComentPostMode();

  void isCommentBox(int postID) async {
    var postSnapShot = await FirebaseFirestore.instance
        .collection('posts')
        .where('id', isEqualTo: postID)
        .get();
    _likeComentpostMode.postData = postSnapShot.docs.first['id'];
    if (_likeComentpostMode.postData == postID) {
      _likeComentpostMode.isCommentBox = !_likeComentpostMode.isCommentBox;
    }
    state = AsyncData(_likeComentpostMode);
  }

  void isLike(int postID) async {
    var postSnapShot = await FirebaseFirestore.instance
        .collection('posts')
        .where('id', isEqualTo: postID)
        .get();
    var docId = postSnapShot.docs.first.id;

    if (postSnapShot.docs.first.data().containsKey('like') &&
        (postSnapShot.docs.first['like'] as List)
            .contains(FirebaseAuth.instance.currentUser!.phoneNumber)) {
      final List<dynamic> data =
          postSnapShot.docs.first.data().containsKey('like')
              ? (postSnapShot.docs.first['like'] as List<dynamic>)
              : [];
      data.remove(FirebaseAuth.instance.currentUser!.phoneNumber ?? '');

      await FirebaseFirestore.instance.collection('posts').doc(docId).update({
        'like': data,
      });
    } else {
      final List<dynamic> data =
          postSnapShot.docs.first.data().containsKey('like')
              ? (postSnapShot.docs.first['like'] as List<dynamic>)
              : [];
      data.add(FirebaseAuth.instance.currentUser!.phoneNumber ?? '');

      await FirebaseFirestore.instance.collection('posts').doc(docId).update({
        'like': data,
      });
    }
  }

  void addComments(int postID) async {
    var postSnapShot = await FirebaseFirestore.instance
        .collection('posts')
        .where('id', isEqualTo: postID)
        .get();
    var docId = postSnapShot.docs.first.id;

    if (_likeComentpostMode.textCommentController.text.isNotEmpty) {
      List yourItemList = [];

      final List<dynamic> dataNumber =
          postSnapShot.docs.first.data().containsKey('comments')
              ? (postSnapShot.docs.first['comments'] as List<dynamic>)
              : [];

      dataNumber.add(FirebaseAuth.instance.currentUser!.phoneNumber ?? '');
      yourItemList.add({
        'comment': _likeComentpostMode.textCommentController.text,
        'phone': FirebaseAuth.instance.currentUser!.phoneNumber ?? '',
      });

      // Send array format use FieldValue.arrayUnion(yourItemList),
      await FirebaseFirestore.instance.collection('posts').doc(docId).update({
        'comments': FieldValue.arrayUnion(yourItemList),
      });

      toast("Comment Added");
      clearTextFields();
    } else {
      toast("Please type comment");
    }
  }

  void clearTextFields() {
    _likeComentpostMode.textCommentController.clear();
  }

  // Get Post Document Id
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

  @override
  build() {
    return _likeComentpostMode;
  }
}
