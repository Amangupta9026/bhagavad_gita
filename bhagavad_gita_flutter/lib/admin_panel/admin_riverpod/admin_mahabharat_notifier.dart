// ignore_for_file: use_build_context_synchronously

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final playListNotifierProvider =
    AsyncNotifierProvider<AdminMahabharatNotifier, AdminMahabharatMode>(() {
  return AdminMahabharatNotifier();
});

class AdminMahabharatMode {
  final TextEditingController playListController = TextEditingController();
}

class AdminMahabharatNotifier extends AsyncNotifier<AdminMahabharatMode> {
  final AdminMahabharatMode _adminMahabharatMode = AdminMahabharatMode();
  @override
  build() {
    return _adminMahabharatMode;
  }

  void clearTextFields() {
    _adminMahabharatMode.playListController.clear();
  }

  void playListUrlAdd(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminMahabharatMode.playListController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('playListMahabharat').add({
        "playListUrl": _adminMahabharatMode.playListController.text,
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
