import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final likeComentpostUserNotifierProvider =
    AsyncNotifierProvider<PostNotifer, LikeComentPostMode>(() {
  return PostNotifer();
});

class LikeComentPostMode {
  bool isLiked = false;
}

class PostNotifer extends AsyncNotifier<LikeComentPostMode> {
  final LikeComentPostMode _likeComentpostMode = LikeComentPostMode();

  void isLike(int postID) async {
    var postSnapShot = await FirebaseFirestore.instance
        .collection('posts')
        .where('id', isEqualTo: postID)
        .get();
    var docId = postSnapShot.docs.first.id;

    // await FirebaseFirestore.instance.collection('posts').doc(docId).update({
    //   'like': 'like',
    // });

    if (postID == postID) {
      _likeComentpostMode.isLiked = !_likeComentpostMode.isLiked;
      state = AsyncData(_likeComentpostMode);
    }
  }

  // void addPost() {

  //   if (_likeComentpostMode.textPostController.text.isNotEmpty ||
  //       _likeComentpostMode.getImage != null) {
  //     FirebaseFirestore.instance.collection('posts').add({
  //       "post": _likeComentpostMode.textPostController.text,
  //       "userName": "Anonymous",
  //       "userImage": "",
  //       "servertime": FieldValue.serverTimestamp()
  //     });

  //     toast("Post Added");
  //     //  clearimage();
  //     clearTextFields();
  //   } else {

  //     toast("Please fill the field");
  //   }
  // }

  @override
  build() {
    return _likeComentpostMode;
  }
}
