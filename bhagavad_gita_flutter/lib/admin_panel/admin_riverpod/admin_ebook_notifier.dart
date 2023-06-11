import 'package:bhagavad_gita_flutter/utils/file_collection.dart';
import 'package:bhagavad_gita_flutter/widget/toast_widget.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final eBookNotifierProvider = NotifierProvider<AdminEbookNotifier, dynamic>(() {
  return AdminEbookNotifier();
});


class AdminEbookNotifier extends Notifier {
  TextEditingController bookTitleController = TextEditingController();
  TextEditingController bookDescriptionController = TextEditingController();
  TextEditingController bookImageController = TextEditingController();

  void clearTextFields() {
    bookTitleController.clear();
    bookDescriptionController.clear();
    bookImageController.clear();
  }

  void addBook() {
    if (bookTitleController.text.isNotEmpty &&
        bookDescriptionController.text.isNotEmpty &&
        bookImageController.text.isNotEmpty) {
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
    return;
  }
}
