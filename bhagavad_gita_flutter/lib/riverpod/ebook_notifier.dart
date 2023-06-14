import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../widget/toast_widget.dart';

final eBookUserNotifierProvider =
    AsyncNotifierProvider<EbookNotifier, EbookMode>(() {
  return EbookNotifier();
});

class EbookMode {
  bool isFaviorite = false;
}

class EbookNotifier extends AsyncNotifier<EbookMode> {
  final EbookMode _ebookMode = EbookMode();

  void changeFaviorite(String title, String description, String image) {
    _ebookMode.isFaviorite = !_ebookMode.isFaviorite;
    if (_ebookMode.isFaviorite) {
      updateIsFavioriteValue(title, description, image);
      sendIsFaviorite(title, description, image);

      toast("Added to Faviorite");
    } else {
      updateIsFavioriteValueFalse(description);
      sendIsFavioriteFalse(description);
      toast("Removed from Faviorite");
    }
    state = AsyncData(_ebookMode);
  }

  void sendIsFaviorite(String title, String description, String image) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('isFaviorite')
        .where('description', isEqualTo: description)
        .get();
    var docId = isFaviorite.docs.first.id;
    if (docId.isEmpty) {
      FirebaseFirestore.instance.collection('isFaviorite').add({
        "bookTitle": title,
        "description": description,
        "image": image,
        'isFaviorite': true,
        "servertime": FieldValue.serverTimestamp()
      });
    } else {
      FirebaseFirestore.instance.collection('isFaviorite').doc(docId).update(
          {'isFaviorite': true, "servertime": FieldValue.serverTimestamp()});
    }
  }

  // for update isFaviorite value False

  void sendIsFavioriteFalse(String description) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('isFaviorite')
        .where('description', isEqualTo: description)
        .get();
    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('isFaviorite').doc(docId).update(
        {'isFaviorite': false, "servertime": FieldValue.serverTimestamp()});
  }

  void updateIsFavioriteValue(
      String title, String description, String image) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('e-books')
        .where('description', isEqualTo: description)
        .get();
    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('e-books').doc(docId).update(
        {'isFaviorite': true, "servertime": FieldValue.serverTimestamp()});

    // sendIsFaviorite(title, description, image);
  }

  void updateIsFavioriteValueFalse(String description) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('e-books')
        .where('description', isEqualTo: description)
        .get();

    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('e-books').doc(docId).update(
        {'isFaviorite': false, "servertime": FieldValue.serverTimestamp()});
  }

  @override
  build() {
    return _ebookMode;
  }
}
