import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static final Color? backgroundColor = Colors.blueGrey[900];
  static final Color? primaryColor = Colors.yellowAccent[700];
  static final Color accentColor = Colors.white;
  static final Color hintTextColor = Colors.white54;
  static final Color textColor = Colors.white;
  static final Color buttonTextColor = Colors.black;

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
      suffixIconColor: hintTextColor,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(double.infinity, 50),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(primaryColor!),
        foregroundColor: WidgetStateProperty.all<Color>(buttonTextColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStateProperty.all<TextStyle>(
          GoogleFonts.poppins(fontSize: 16),
        ),
        minimumSize: WidgetStateProperty.all<Size>(
          const Size(double.infinity, 50),
        ),
        backgroundColor: WidgetStateProperty.all<Color>(Colors.transparent),
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white54),
        side: WidgetStateProperty.all<BorderSide>(
          BorderSide(color: Colors.white54),
        ),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      ),
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
