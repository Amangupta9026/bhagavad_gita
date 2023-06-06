import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../utils/file_collection.dart';

final themeNotifierProvider = NotifierProvider<ThemeNotifier, ThemeMode>(() {
  return ThemeNotifier();
});

class ThemeNotifier extends Notifier<ThemeMode> {
  ThemeMode? themeMode = ThemeMode.dark;

  void changeTheme() {
    if (themeMode == ThemeMode.dark) {
      state = ThemeMode.light;
    } else {
      state = ThemeMode.dark;
    }
    state = themeMode!;
  }

  // void toggleSwitch(bool value) {
  //   if (isSwitched == false) {
  //     setState(() {
  //       isSwitched = true;
  //       textValue = 'Switch Button is ON';
  //     });
  //     log('Switch Button is ON');
  //   } else {
  //     setState(() {
  //       isSwitched = false;
  //       textValue = 'Switch Button is OFF';
  //     });
  //     log('Switch Button is OFF');
  //   }

  // }

  @override
  build() {
    return themeMode!;
  }
}
