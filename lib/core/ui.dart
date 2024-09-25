import 'package:flutter/material.dart';

class AppColors {
  static Color accent = const Color(0xff1ab7c3);
  static Color text = const Color(0xff212121);
  static Color textLight = const Color(0xff8a8a8a);
  static Color white = const Color(0xffffffff);
  static Color red = const Color.fromARGB(255, 247, 65, 52);
  static Color backgroundPrimary = const Color(0xFF111015);
  static Color kBackgoundColor =const Color(0xFF191a2c);
}

class Themes {
  static ThemeData defaultTheme = ThemeData(
    brightness: Brightness.dark, // Set brightness to dark
    scaffoldBackgroundColor: Colors.black, // Set scaffold background color to black
    appBarTheme: AppBarTheme(
      elevation: 0,
      backgroundColor: AppColors.backgroundPrimary,
      iconTheme: IconThemeData(color: AppColors.white), // Make icons white for visibility
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: AppColors.white, // Make text color white
      ),
    ),
    colorScheme: ColorScheme.dark( // Set color scheme to dark
      surface: AppColors.kBackgoundColor,
      background: Colors.black, // Set background color to black
      primary: AppColors.white,
      secondary: AppColors.accent,
    ),
  );
}


class TextStyles {
  static TextStyle heading1 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 48);

  static TextStyle heading2 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 32);

  static TextStyle heading3 = TextStyle(
      fontWeight: FontWeight.bold, color: AppColors.text, fontSize: 24);

  static TextStyle body1 = TextStyle(
      fontWeight: FontWeight.normal, color: AppColors.text, fontSize: 18);

  static TextStyle body2 = TextStyle(
      fontWeight: FontWeight.normal, color: AppColors.text, fontSize: 16);
}
