// ignore_for_file: use_build_context_synchronously

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final adminRamayanNotifierProvider =
    AsyncNotifierProvider<AdminRamayanaNotifier, AdminRamayanaMode>(() {
  return AdminRamayanaNotifier();
});

class AdminRamayanaMode {
  final TextEditingController playListController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
}

class AdminRamayanaNotifier extends AsyncNotifier<AdminRamayanaMode> {
  final AdminRamayanaMode _adminRamayanaMode = AdminRamayanaMode();
  @override
  build() {
    return _adminRamayanaMode;
  }

  void clearTextFields() {
    _adminRamayanaMode.playListController.clear();
  }

  void playListUrlAdd(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminRamayanaMode.playListController.text.isNotEmpty &&
        _adminRamayanaMode.titleController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('playListRamayana').add({
        "playListUrl": _adminRamayanaMode.playListController.text,
        "title": _adminRamayanaMode.titleController.text,
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
