import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router/routes_names.dart';
import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final audioNotifierProvider =
    AsyncNotifierProvider<AdminAudioNotifier, AdminAudioMode>(() {
  return AdminAudioNotifier();
});

class AdminAudioMode {
  final TextEditingController audioTitleController = TextEditingController();
  final TextEditingController audioImageController = TextEditingController();
  final TextEditingController audioUrlController = TextEditingController();
}

class AdminAudioNotifier extends AsyncNotifier<AdminAudioMode> {
  final AdminAudioMode _adminAudioMode = AdminAudioMode();

  void clearTextFields() {
    _adminAudioMode.audioTitleController.clear();
    _adminAudioMode.audioImageController.clear();
    _adminAudioMode.audioUrlController.clear();
  }

  void onSubmit(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    if (_adminAudioMode.audioTitleController.text.isNotEmpty &&
        _adminAudioMode.audioImageController.text.isNotEmpty &&
        _adminAudioMode.audioUrlController.text.isNotEmpty) {
      FirebaseFirestore.instance.collection('audio').add({
        'audioTitle': _adminAudioMode.audioTitleController.text,
        'audioImage': _adminAudioMode.audioImageController.text,
        'audioUrl': _adminAudioMode.audioUrlController.text,
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
    return _adminAudioMode;
  }
}
