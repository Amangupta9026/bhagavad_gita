// ignore_for_file: use_build_context_synchronously

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final adminGitaUpdeshNotifierProvider =
    AsyncNotifierProvider<AdminGitaUpdeshNotifier, AdminGitaUpdeshMode>(() {
  return AdminGitaUpdeshNotifier();
});

class AdminGitaUpdeshMode {
  final TextEditingController playListController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
}

class AdminGitaUpdeshNotifier extends AsyncNotifier<AdminGitaUpdeshMode> {
  final AdminGitaUpdeshMode _adminMahadevMode = AdminGitaUpdeshMode();
  @override
  build() {
    return _adminMahadevMode;
  }

  void clearTextFields() {
    _adminMahadevMode.playListController.clear();
  }

  void playListUrlAdd(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminMahadevMode.playListController.text.isNotEmpty &&
        _adminMahadevMode.titleController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('gitaUpdesh').add({
        "playListUrl": _adminMahadevMode.playListController.text,
        "title": _adminMahadevMode.titleController.text,
        "imageUrl": "",
        "servertime": FieldValue.serverTimestamp()
      });
      EasyLoading.dismiss();
      context.pushNamed(RouteNames.main);
      toast("PlayList Added Successfully");
      clearTextFields();
    } else {
      toast("Please fill all the fields");
    }
  }
}
