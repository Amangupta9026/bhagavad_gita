import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../router/routes_names.dart';

final eBookNotifierProvider =
    AsyncNotifierProvider<AdminEbookNotifier, AdminEbookMode>(() {
  return AdminEbookNotifier();
});

class AdminEbookMode {
  final TextEditingController bookTitleController = TextEditingController();
  final TextEditingController bookDescriptionController =
      TextEditingController();
  final TextEditingController bookImageController = TextEditingController();
  AdminEbookMode();
}

class AdminEbookNotifier extends AsyncNotifier<AdminEbookMode> {
  final AdminEbookMode _adminEbookMode = AdminEbookMode();
  void clearTextFields() {
    _adminEbookMode.bookTitleController.clear();
    _adminEbookMode.bookDescriptionController.clear();
    _adminEbookMode.bookImageController.clear();
  }

  void addBook(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminEbookMode.bookTitleController.text.isNotEmpty &&
        _adminEbookMode.bookDescriptionController.text.isNotEmpty &&
        _adminEbookMode.bookImageController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('e-books').add({
        "bookTitle": _adminEbookMode.bookTitleController.text,
        "description": _adminEbookMode.bookDescriptionController.text,
        "image": _adminEbookMode.bookImageController.text,
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
    return _adminEbookMode;
  }
}
