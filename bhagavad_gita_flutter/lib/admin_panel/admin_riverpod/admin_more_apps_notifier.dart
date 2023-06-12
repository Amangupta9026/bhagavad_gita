// ignore_for_file: use_build_context_synchronously

import 'package:bhagavad_gita_flutter/router/routes_names.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final moreAppsNotifierProvider =
    AsyncNotifierProvider<AdminMoreAppsNotifier, AdminMoreAppsMode>(() {
  return AdminMoreAppsNotifier();
});

class AdminMoreAppsMode {
  final TextEditingController appNameController = TextEditingController();
  final TextEditingController appImageController = TextEditingController();
  final TextEditingController appLinkController = TextEditingController();
  AdminMoreAppsMode();
}

class AdminMoreAppsNotifier extends AsyncNotifier<AdminMoreAppsMode> {
  final AdminMoreAppsMode _adminMoreAppsMode = AdminMoreAppsMode();

  void clearTextFields() {
    _adminMoreAppsMode.appNameController.clear();
    _adminMoreAppsMode.appImageController.clear();
    _adminMoreAppsMode.appLinkController.clear();
  }

  void onSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    if (_adminMoreAppsMode.appNameController.text.isNotEmpty &&
        _adminMoreAppsMode.appImageController.text.isNotEmpty &&
        _adminMoreAppsMode.appLinkController.text.isNotEmpty) {
      await FirebaseFirestore.instance.collection('moreApps').add({
        'appName': _adminMoreAppsMode.appNameController.text,
        'appImage': _adminMoreAppsMode.appImageController.text,
        'appLink': _adminMoreAppsMode.appLinkController.text,
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
    return _adminMoreAppsMode;
  }
}
