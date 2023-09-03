import 'package:bhagavad_gita_flutter/local/prefs.dart';

class PrefNames {
  static const String isDarkMode = 'isDarkMode';
  static const String isLogin = 'isLogin';
  static const String isFaviorite = 'isFaviorite';
}

List<String> FavList = Prefs.getStringList(PrefNames.isFaviorite) ?? [] ;

