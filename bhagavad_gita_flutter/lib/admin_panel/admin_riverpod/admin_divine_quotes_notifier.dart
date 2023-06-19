// ignore_for_file: use_build_context_synchronously

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

  void onSubmit(BuildContext context) async {
    EasyLoading.show(status: 'loading...');
    var quotesSnapShot = await FirebaseFirestore.instance
        .collection('divineQuotes')
        .where('id', isEqualTo: 1)
        .get();
    var docID = quotesSnapShot.docs.first.id;
    FirebaseFirestore.instance.collection('divineQuotes').doc(docID).update({
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
