import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static const  primary = Color(0xFF0E3A99);
  static const darkPrimary = Color(0xFF457AED);
  static const black = Color(0xFF1C1C1C);
  static const darkBlack =Color(0xFF000F30);
  static const offwhite = Color(0xFFF4F7FF);
  static const darkblue = Color(0xFF001440);
  static const white = Color(0xFFFFFFFF);
  static const lightoffwhite = Color(0xFFD6D6D6);
  static const gray = Color(0xFF686868);
  static const lightgrey = Color(0xFFF0F0F0);
  static const lightblue = Color(0xFF002D8F);
  static const brightgrey = Color(0xFFE9EAEB);
  static const greyIcon = Color(0xFFB9B9B9);



  static ThemeData darkTheme = ThemeData(
    splashFactory: NoSplash.splashFactory,
    primaryColor: darkPrimary,
    scaffoldBackgroundColor: darkBlack,
    brightness: Brightness.dark,

      textTheme: TextTheme(
        headlineMedium: TextStyle(
            fontWeight: .w600,
            fontSize: 24,
            color: white
        ),
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

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: darkPrimary,
          textStyle: TextStyle(fontSize: 14,
              fontWeight: FontWeight.w600,
            decoration: .underline
              )
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
        unselectedIconTheme: IconThemeData(color: gray),
      ),

      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: darkPrimary,
        foregroundColor: white,
        shape: CircleBorder(),
      ),

      inputDecorationTheme: InputDecorationThemeData(
       filled: true,
       fillColor: darkblue,
       hintStyle: TextStyle(
         fontWeight: .w400,
         fontSize: 14,
         color: lightoffwhite
       ),
       enabledBorder: OutlineInputBorder(
         borderRadius: .circular(16),
         borderSide: BorderSide(color: lightblue ),),
       focusedBorder: OutlineInputBorder(
         borderRadius: .circular(16),
         borderSide: BorderSide(color: lightblue ),),
         errorBorder:  OutlineInputBorder(
           borderRadius: .circular(16),
           borderSide: BorderSide(color: Colors.red  ),),
         focusedErrorBorder:  OutlineInputBorder(
         borderRadius: .circular(16),
    borderSide: BorderSide(color: Colors.red ),),
       ),

      listTileTheme: ListTileThemeData(
        tileColor: darkblue,
        minTileHeight: 0,
      contentPadding: EdgeInsets.symmetric(horizontal:16 ,vertical:14 ),
      shape: RoundedRectangleBorder(borderRadius: .circular(16),
      ),
      titleTextStyle: TextStyle(
        fontWeight: .w500,
        fontSize: 16,
        color: white,
      ),
    ),



  );

  static ThemeData lightTheme = ThemeData(
      splashFactory: NoSplash.splashFactory,
      primaryColor: primary,
      scaffoldBackgroundColor: offwhite,
    brightness: Brightness.light,

    textTheme: TextTheme(
      headlineMedium: TextStyle(
          fontWeight: .w600,
          fontSize: 24,
          color: primary
      ),
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

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: TextStyle(fontSize: 14,
            fontWeight: FontWeight.w600,
            decoration: .underline
          )

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


    ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(),
  ),

    inputDecorationTheme: InputDecorationThemeData(
      filled: true,
      fillColor: white,
      hintStyle: TextStyle(
          fontWeight: .w400,
          fontSize: 14,
          color: gray
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: .circular(16),
        borderSide: BorderSide(color: lightgrey ),),
      focusedBorder: OutlineInputBorder(
        borderRadius: .circular(16),
        borderSide: BorderSide(color: lightgrey ),),
      errorBorder:  OutlineInputBorder(
        borderRadius: .circular(16),
        borderSide: BorderSide(color: Colors.red  ),),
      focusedErrorBorder:  OutlineInputBorder(
        borderRadius: .circular(16),
        borderSide: BorderSide(color: Colors.red ),),
    ),

    listTileTheme: ListTileThemeData(
      tileColor: white,
      minTileHeight: 0,
      contentPadding: EdgeInsets.symmetric(horizontal:16 ,vertical:14 ),
      shape: RoundedRectangleBorder(borderRadius: .circular(16),

      ),
      titleTextStyle: TextStyle(
        fontWeight: .w500,
        fontSize: 16,
        color: black,
      ),
    ),






  );
}