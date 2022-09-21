import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:google_fonts/google_fonts.dart';

import 'constants.dart';

ThemeData getTheme() {
  return ThemeData(
    textTheme: TextTheme(
      headline1: TextStyle(
        color: darkBrown,
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline2: TextStyle(
        color: darkBrown,
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline3: const TextStyle(color: darkBrown),
      headline4: const TextStyle(color: darkBrown),
      headline5: TextStyle(
        color: darkBrown,
        fontFamily: GoogleFonts.lacquer().fontFamily,
      ),
      headline6: const TextStyle(color: darkBrown),
      caption: const TextStyle(color: darkBrown),
      bodyText1: const TextStyle(color: darkBrown),
      subtitle1: const TextStyle(color: darkBrown),
      subtitle2: const TextStyle(color: darkBrown),
      bodyText2: const TextStyle(color: darkBrown),
      overline: const TextStyle(color: darkBrown),
      button: const TextStyle(color: darkBrown),
    ),
    scaffoldBackgroundColor: Colors.white,
    fontFamily: GoogleFonts.lato().fontFamily,
    appBarTheme: AppBarTheme(
      iconTheme: const IconThemeData(color: Colors.brown),
      color: Colors.white,
      elevation: 0.0,
      centerTitle: true,
      toolbarTextStyle: const TextTheme(
        headline6: TextStyle(
          color: Colors.brown,
        ),
      ).bodyText2,
      titleTextStyle: const TextTheme(
        headline6: TextStyle(
          color: Colors.brown,
        ),
      ).headline6,
    ),
  );
}
