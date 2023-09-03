import 'package:permission_handler/permission_handler.dart';

import 'file_collection.dart';

class AppUtils {
  // Gradient decoration
  static Decoration decoration1() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [primaryLightColor, lightPinkColor],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ),
    );
  }

  static Future<void> handleNotification(Permission permission) async {
    final status = await permission.request();
    debugPrint(status.toString());
  }
}
