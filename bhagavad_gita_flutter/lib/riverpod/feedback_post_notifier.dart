// ignore_for_file: use_build_context_synchronously

import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../router/routes_names.dart';

final feedbackNotifierProvider =
    AsyncNotifierProvider<FeedBackNotifier, FeedBackMode>(() {
  return FeedBackNotifier();
});

class FeedBackMode {
  final TextEditingController subjectController = TextEditingController();
  final TextEditingController messageController =
      TextEditingController();
}

class FeedBackNotifier extends AsyncNotifier<FeedBackMode> {
  final FeedBackMode _feedbackMode = FeedBackMode();
  void clearTextFields() {
    _feedbackMode.subjectController.clear();
    _feedbackMode.messageController.clear();
  
  }

  void feedbackpost(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    if (_feedbackMode.subjectController.text.isNotEmpty &&
        _feedbackMode.messageController.text.isNotEmpty) {
    await FirebaseFirestore.instance.collection('feedback').add({
        "phone": FirebaseAuth.instance.currentUser?.phoneNumber ?? '',
        "subject": _feedbackMode.subjectController.text,
        "message": _feedbackMode.messageController.text, 
        "servertime": FieldValue.serverTimestamp()
      });
      EasyLoading.showSuccess('Message Sent Successfully');
      context.pushNamed(RouteNames.main);
      clearTextFields();
    } else {
      EasyLoading.dismiss();
    
    }
  }

  @override
  build() {
    return _feedbackMode;
  }
}
