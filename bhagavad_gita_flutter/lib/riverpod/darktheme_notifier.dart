import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/file_collection.dart';

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeMode> {
  ThemeMode? themeMode = ThemeMode.light;

  void changeTheme() {
    if (themeMode == ThemeMode.light) {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.light;
    }
    state = themeMode!;
  }

  @override
  build() {
    return themeMode!;
  }
}
