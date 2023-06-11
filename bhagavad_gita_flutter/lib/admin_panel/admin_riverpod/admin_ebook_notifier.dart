import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final eBookNotifierProvider = AsyncNotifierProvider<AdminEbookNotifier, AdminEbookMode>(() {
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

  void addBook() {
    if (_adminEbookMode.bookTitleController.text.isNotEmpty &&
        _adminEbookMode.bookDescriptionController.text.isNotEmpty &&
        _adminEbookMode.bookImageController.text.isNotEmpty) {
      // books.add({
      //   "title": bookTitleController.text,
      //   "description": bookDescriptionController.text,
      //   "image": bookImageController.text,
      // });
      clearTextFields();
    } else {
      toast("Please fill all the fields");
    }
  }

  @override
  build() {
    return _adminEbookMode;
  }
}
