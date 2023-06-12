import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../router/routes_names.dart';
import '../../utils/file_collection.dart';
import '../../widget/toast_widget.dart';

final divineQuotesNotifierProvider =
    AsyncNotifierProvider<AdminDivineQuotesNotifier, AdminDivineQuotesMode>(() {
  return AdminDivineQuotesNotifier();
});

class AdminDivineQuotesMode {
  final TextEditingController quotesController = TextEditingController();
  final TextEditingController backgroundImageController =
      TextEditingController();
}

class AdminDivineQuotesNotifier extends AsyncNotifier<AdminDivineQuotesMode> {
  final AdminDivineQuotesMode _adminDivineQuotesMode = AdminDivineQuotesMode();

  void clearTextFields() {
    _adminDivineQuotesMode.quotesController.clear();
    _adminDivineQuotesMode.backgroundImageController.clear();
  }

  void onSubmit(BuildContext context) {
    EasyLoading.show(status: 'loading...');
    FirebaseFirestore.instance.collection('divineQuotes').add({
      'quotes': _adminDivineQuotesMode.quotesController.text,
      'backGroundImage': _adminDivineQuotesMode.backgroundImageController.text,
      'servertime': FieldValue.serverTimestamp(),
    });
    EasyLoading.dismiss();
    context.pushNamed(RouteNames.main);
    clearTextFields();
    toast("App Added Successfully");
  }

  @override
  build() {
    return _adminDivineQuotesMode;
  }
}
