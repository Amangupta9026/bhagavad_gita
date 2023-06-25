import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../widget/toast_widget.dart';

final aartiBookUserNotifierProvider =
    AsyncNotifierProvider<AartibookNotifier, AartibookMode>(() {
  return AartibookNotifier();
});

class AartibookMode {
  bool isFaviorite = false;
  FlutterTts flutterTts = FlutterTts();
  double volume = 1.0;
  double pitch = 0.4;
  double speechRate = 0.5;
  String langCode = "hi-IN";
}

class AartibookNotifier extends AsyncNotifier<AartibookMode> {
  final AartibookMode _aartiBookMode = AartibookMode();

  void changeFaviorite(String title, String description, String image) {
    _aartiBookMode.isFaviorite = !_aartiBookMode.isFaviorite;
    if (_aartiBookMode.isFaviorite) {
      updateIsFavioriteValue(title, description, image);
      sendIsFaviorite(title, description, image);

      toast("Added to Favourite");
    } else {
      updateIsFavioriteValueFalse(title);
      sendIsFavioriteFalse(title);
      toast("Removed from Favourite");
    }
    state = AsyncData(_aartiBookMode);
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
        .collection('aarti-Book')
        .where('bookTitle', isEqualTo: title)
        .get();
    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('aarti-Book').doc(docId).update(
        {'isFaviorite': true, "servertime": FieldValue.serverTimestamp()});

    // sendIsFaviorite(title, description, image);
  }

  void updateIsFavioriteValueFalse(String title) async {
    var isFaviorite = await FirebaseFirestore.instance
        .collection('aarti-Book')
        .where('bookTitle', isEqualTo: title)
        .get();

    var docId = isFaviorite.docs.first.id;

    FirebaseFirestore.instance.collection('aarti-Book').doc(docId).update(
        {'isFaviorite': false, "servertime": FieldValue.serverTimestamp()});
  }

  // Text to Speech

  Future<void> speak(String title) async {
    initSetting();
    await _aartiBookMode.flutterTts.speak(title);
    state = AsyncData(_aartiBookMode);
  }

  Future<void> stop() async {
    await _aartiBookMode.flutterTts.stop();
    state = AsyncData(_aartiBookMode);
  }

  void initSetting() async {
    await _aartiBookMode.flutterTts.setVolume(_aartiBookMode.volume);
    await _aartiBookMode.flutterTts.setPitch(_aartiBookMode.pitch);
    await _aartiBookMode.flutterTts.setSpeechRate(_aartiBookMode.speechRate);
    await _aartiBookMode.flutterTts.setLanguage(_aartiBookMode.langCode);
  }

  @override
  build() {
    return _aartiBookMode;
  }
}
