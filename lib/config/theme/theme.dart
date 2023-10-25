import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DefaultColor {
  static const primary = Color(0XFF4A4B4D);
  static const primaryOpacity = Color(0X334A4B4D);
  static const secondary = Color(0xFF242333);
  static const purple = Color(0xFF714DF1);
  static const white = Color(0xFFE3E4E7);
}

final darkTheme = ThemeData(
  appBarTheme:
      const AppBarTheme(backgroundColor: DefaultColor.secondary, elevation: 0),
  textTheme: GoogleFonts.poppinsTextTheme().apply(
    bodyColor: DefaultColor.white,
    displayColor: DefaultColor.white,
  ),
);
