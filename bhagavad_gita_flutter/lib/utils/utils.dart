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
}
