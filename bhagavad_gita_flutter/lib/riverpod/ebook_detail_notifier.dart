import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../widget/toast_widget.dart';

final eBookUserNotifierProvider =
    AsyncNotifierProvider<EbookNotifier, EbookMode>(() {
  return EbookNotifier();
});

class EbookMode {
  bool isFaviorite = false;
  FlutterTts flutterTts = FlutterTts();
  double volume = 1.0;
  double pitch = 0.4;
  double speechRate = 0.5;
  String langCode = "hi-IN";
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
      updateIsFavioriteValueFalse(title);
      sendIsFavioriteFalse(title);
      toast("Removed from Faviorite");
    }
    state = AsyncData(_ebookMode);
  }

  void sendIsFaviorite(String title, String description, String image) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('isFaviorite')
        .where('bookTitle', isEqualTo: title)
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

  void sendIsFavioriteFalse(String title) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('isFaviorite')
        .where('bookTitle', isEqualTo: title)
        .get();
    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('isFaviorite').doc(docId).update(
        {'isFaviorite': false, "servertime": FieldValue.serverTimestamp()});
  }

  void updateIsFavioriteValue(
      String title, String description, String image) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('e-books')
        .where('bookTitle', isEqualTo: title)
        .get();
    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('e-books').doc(docId).update(
        {'isFaviorite': true, "servertime": FieldValue.serverTimestamp()});

    // sendIsFaviorite(title, description, image);
  }

  void updateIsFavioriteValueFalse(String title) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('e-books')
        .where('bookTitle', isEqualTo: title)
        .get();

    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('e-books').doc(docId).update(
        {'isFaviorite': false, "servertime": FieldValue.serverTimestamp()});
  }

  // Text to Speech

  Future<void> speak(String title) async {
    initSetting();
    await _ebookMode.flutterTts.speak(title);
    state = AsyncData(_ebookMode);
  }

  void initSetting() async {
    await _ebookMode.flutterTts.setVolume(_ebookMode.volume);
    await _ebookMode.flutterTts.setPitch(_ebookMode.pitch);
    await _ebookMode.flutterTts.setSpeechRate(_ebookMode.speechRate);
    await _ebookMode.flutterTts.setLanguage(_ebookMode.langCode);
  }

  @override
  build() {
    return _ebookMode;
  }
}
