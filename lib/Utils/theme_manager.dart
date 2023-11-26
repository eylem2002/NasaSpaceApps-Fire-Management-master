import 'package:flutter/material.dart';


class ThemeManager {


  static String appName = "NasaScapeApps";

  //Colors for theme
  static Color lightPrimary = Colors.grey.shade50;
  static Color darkPrimary = Colors.grey.shade800;
  static Color lightAccent = Color(0xCDa5afac);
  static Color darkAccent = Color(0xCDa5afac);

  static Color background = lightPrimary;
  static Color accent = lightAccent;
  static Color primary = lightPrimary;
  static ThemeData appTheme = lightTheme;

  static Color badgeColor = Colors.red;
  static Color iconColor = darkPrimary;
  static Color textColor = Colors.black;
  static Color textColorNegative = Colors.black;
  static Color textRecognizerColor = Color(0xff3b60ce);

  static ThemeData lightTheme = ThemeData(
    fontFamily: 'Cairo',
    backgroundColor: lightPrimary,
    primaryColor: lightPrimary,
    scaffoldBackgroundColor: lightPrimary,
    appBarTheme: AppBarTheme(
      elevation: 0.5,
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
          color: Colors.grey[600], fontSize: 22.0, fontWeight: FontWeight.w800),
      subtitle1: TextStyle(
          color: Colors.grey[700], fontSize: 18.0, fontWeight: FontWeight.w500),
      bodyText1: TextStyle(
          color: Colors.grey[500], fontSize: 18.0, fontWeight: FontWeight.w500),
      bodyText2: TextStyle(
          color: Colors.grey[500], fontSize: 14.0, fontWeight: FontWeight.w400),
      button: TextStyle(
          color: lightPrimary, fontSize: 18.0, fontWeight: FontWeight.w500),
    ),
    buttonTheme: ButtonThemeData(
      buttonColor: lightAccent,
      height: 50.0,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}