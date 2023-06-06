
import 'package:fluttertoast/fluttertoast.dart';

import '../utils/file_collection.dart';

void toast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    backgroundColor: null,
    textColor: textColor,
    fontSize: 16.0,
  );
}