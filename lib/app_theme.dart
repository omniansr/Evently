import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const  primary = Color(0xFF0E3A99);
  static const darkPrimary = Color(0xFF457AED);
  static const black = Color(0xFF1C1C1C);
  static const darkBlack =Color(0xFF000F30);
  static const offwhite = Color(0xFFF4F7FF);
  static const white = Color(0xFFFFFFFF);
  static const lightgray = Color(0xFFD6D6D6);
  static const gray = Color(0xFF686868);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: darkBlack

  );

  static ThemeData darkTheme = ThemeData(
      primaryColor: darkPrimary,
      scaffoldBackgroundColor: white,

  );
}