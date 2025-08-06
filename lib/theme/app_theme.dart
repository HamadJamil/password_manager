import 'package:flutter/material.dart';

class AppTheme {
  static final Color? backgroundColor = Colors.blueGrey[900];
  static final Color? primaryColor = Colors.yellowAccent[700];
  static final Color accentColor = Colors.white;
  static final Color hintTextColor = Colors.white54;
  static final Color textColor = Colors.white;

  static ThemeData get lightTheme => ThemeData(
    primarySwatch: Colors.yellow,
    primaryColor: primaryColor,
    scaffoldBackgroundColor: backgroundColor,
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: hintTextColor),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: hintTextColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: hintTextColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: primaryColor!),
      ),
      prefixIconColor: hintTextColor,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: primaryColor,
      selectionColor: primaryColor!.withValues(alpha: 0.1),
      selectionHandleColor: primaryColor,
    ),

    textTheme: TextTheme(bodyMedium: TextStyle(color: textColor)),
  );

  static TextStyle get textFieldStyle => TextStyle(color: textColor);
}
