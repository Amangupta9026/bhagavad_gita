import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/file_collection.dart';

final themeNotifierProvider =
    AsyncNotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends AsyncNotifier<ThemeMode> {
  final ThemeMode _themeMode = ThemeMode.light;

  void changeTheme() {
    if (state.value == ThemeMode.light) {
      state = const AsyncData(ThemeMode.dark);
    } else {
      state = const AsyncData(ThemeMode.light);
    }
  }

  @override
  ThemeMode build() {
    return _themeMode;
  }
}
