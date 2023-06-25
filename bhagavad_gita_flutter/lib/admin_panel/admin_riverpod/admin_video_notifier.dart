import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../router/routes_names.dart';
import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final videoNotifierProvider =
    AsyncNotifierProvider<AdminVideoNotifier, AdminVideoMode>(() {
  return AdminVideoNotifier();
});

class AdminVideoMode {
  final TextEditingController videoTitleController = TextEditingController();
  final TextEditingController videoImageController = TextEditingController();
  final TextEditingController videoUrlController = TextEditingController();
}

class AdminVideoNotifier extends AsyncNotifier<AdminVideoMode> {
  final AdminVideoMode _adminVideoMode = AdminVideoMode();

  void clearTextFields() {
    _adminVideoMode.videoTitleController.clear();
    _adminVideoMode.videoImageController.clear();
    _adminVideoMode.videoUrlController.clear();
  }

  void onSubmit(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminVideoMode.videoTitleController.text.isNotEmpty &&
        _adminVideoMode.videoImageController.text.isNotEmpty &&
        _adminVideoMode.videoUrlController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('allVideo').add({
        'videoTitle': _adminVideoMode.videoTitleController.text,
        'videoImage': _adminVideoMode.videoImageController.text,
        'videoUrl': _adminVideoMode.videoUrlController.text,
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
    return _adminVideoMode;
  }
}
