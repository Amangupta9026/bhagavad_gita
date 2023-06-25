import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../router/routes_names.dart';

final aartiBookNotifierProvider =
    AsyncNotifierProvider<AdminEbookNotifier, AdminAartiBookMode>(() {
  return AdminEbookNotifier();
});

class AdminAartiBookMode {
  final TextEditingController aartiTitleController = TextEditingController();
  final TextEditingController aartiDescriptionController =
      TextEditingController();
  final TextEditingController aartiImageController = TextEditingController();
  AdminAartiBookMode();
}

class AdminEbookNotifier extends AsyncNotifier<AdminAartiBookMode> {
  final AdminAartiBookMode _adminAartiBookMode = AdminAartiBookMode();
  void clearTextFields() {
    _adminAartiBookMode.aartiTitleController.clear();
    _adminAartiBookMode.aartiDescriptionController.clear();
    _adminAartiBookMode.aartiImageController.clear();
  }

  void addAartiBook(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminAartiBookMode.aartiTitleController.text.isNotEmpty &&
        _adminAartiBookMode.aartiDescriptionController.text.isNotEmpty &&
        _adminAartiBookMode.aartiImageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('aarti-Book').add({
        "bookTitle": _adminAartiBookMode.aartiTitleController.text,
        "description": _adminAartiBookMode.aartiDescriptionController.text,
        "image": _adminAartiBookMode.aartiImageController.text,
        'isFaviorite': false,
        "servertime": FieldValue.serverTimestamp()
      });
      EasyLoading.dismiss();
      context.pushNamed(RouteNames.main);
      toast("Book Added Successfully");
      clearTextFields();
    } else {
      EasyLoading.dismiss();
      toast("Please fill all the fields");
    }
  }

  @override
  build() {
    return _adminAartiBookMode;
  }
}
