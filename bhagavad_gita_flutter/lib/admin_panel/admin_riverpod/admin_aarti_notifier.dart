import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../router/routes_names.dart';
import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final aartiAdminNotifierProvider =
    AsyncNotifierProvider<AdminVideoNotifier, AdminAartiMode>(() {
  return AdminVideoNotifier();
});

class AdminAartiMode {
  final TextEditingController aartiTitleController = TextEditingController();
  final TextEditingController aartiImageController = TextEditingController();
  final TextEditingController aartiUrlController = TextEditingController();
}

class AdminVideoNotifier extends AsyncNotifier<AdminAartiMode> {
  final AdminAartiMode _adminAartiMode = AdminAartiMode();

  void clearTextFields() {
    _adminAartiMode.aartiTitleController.clear();
    _adminAartiMode.aartiImageController.clear();
    _adminAartiMode.aartiUrlController.clear();
  }

  void onSubmit(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminAartiMode.aartiTitleController.text.isNotEmpty &&
        _adminAartiMode.aartiImageController.text.isNotEmpty &&
        _adminAartiMode.aartiUrlController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('video').add({
        'videoTitle': _adminAartiMode.aartiTitleController.text,
        'videoImage': _adminAartiMode.aartiImageController.text,
        'videoUrl': _adminAartiMode.aartiUrlController.text,
        'servertime': FieldValue.serverTimestamp(),
      });
      EasyLoading.dismiss();
      context.pushNamed(RouteNames.main);
      clearTextFields();
      toast("App Added Successfully");
    } else {
      EasyLoading.dismiss();
      toast("Please fill all the fields");
    }
  }

  @override
  build() {
    return _adminAartiMode;
  }
}
