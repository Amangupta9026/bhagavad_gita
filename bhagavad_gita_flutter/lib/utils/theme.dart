import 'package:google_fonts/google_fonts.dart';

import 'file_collection.dart';

// Set Theme for app.

ThemeData themeData = ThemeData(
    useMaterial3: true,
    textTheme: GoogleFonts.lexendTextTheme(),
    fontFamily: GoogleFonts.lexend().fontFamily,
    colorSchemeSeed: primaryColor,
    appBarTheme: const AppBarTheme(
        surfaceTintColor: primaryColor,
        backgroundColor: primaryColor,
        titleTextStyle: TextStyle(),
        toolbarTextStyle: TextStyle(),
        iconTheme: IconThemeData(color: Colors.white)),
    scaffoldBackgroundColor: Colors.white,
    floatingActionButtonTheme:
        const FloatingActionButtonThemeData(foregroundColor: Colors.white),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      surfaceTintColor: primaryColor,
    )));
