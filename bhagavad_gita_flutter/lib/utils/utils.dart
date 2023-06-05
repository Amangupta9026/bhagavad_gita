
import 'file_collection.dart';

class AppUtils {
  // static Future<void> handleNotificationPermission(
  //     Permission permission) async {
  //   final status = await permission.request();
  //   log(status.toString(), name: 'AppUtils');
  // }

  // Gradient decoration
  static Decoration decoration1() {
    return const BoxDecoration(
      gradient: LinearGradient(
        colors: [colorGradient1, colorGradient2],
        begin: Alignment.topLeft,
        end: Alignment.topRight,
      ),
    );
  }

  
}
