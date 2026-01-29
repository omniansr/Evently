import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const  primary = Color(0xFF0E3A99);
  static const darkPrimary = Color(0xFF457AED);
  static const black = Color(0xFF1C1C1C);
  static const darkBlack =Color(0xFF000F30);
  static const offwhite = Color(0xFFF4F7FF);
  static const white = Color(0xFFFFFFFF);
  static const lightoffwhite = Color(0xFFD6D6D6);
  static const gray = Color(0xFF686868);
  static const lightgrey = Color(0xFFF0F0F0);


  static ThemeData darkTheme = ThemeData(
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBlack,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headlineSmall: TextStyle(
          fontWeight: .w500,
          fontSize: 18,
          color: darkPrimary
      ),
      titleLarge:TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: white,
      ),
      titleMedium:TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: lightoffwhite
      ),
      titleSmall:TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: darkPrimary
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: darkPrimary,
        foregroundColor: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: darkBlack,
        selectedItemColor: darkPrimary,
        unselectedItemColor: gray,
      )


  );

  static ThemeData lightTheme = ThemeData(
      primaryColor: primary,
      scaffoldBackgroundColor: offwhite,
    brightness: Brightness.light,

    textTheme: TextTheme(
        headlineSmall: TextStyle(
          fontWeight: .w500,
              fontSize: 18,
          color: primary
        ),
        titleLarge:TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: black,
        ),
        titleMedium:TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: gray
        ),
        titleSmall:TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primary
        ),
      ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: primary,
        foregroundColor: white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: white,
        selectedItemColor: primary,
      unselectedItemColor: gray,


    )



  );
}