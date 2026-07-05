import 'package:flutter/material.dart';
import 'package:news_app/core/theme/light_color.dart';

ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(),
  primaryColor: LightColor.primaryColor,

  scaffoldBackgroundColor: Color(0xFFf5f5f5),
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(foregroundColor: LightColor.primaryColor),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LightColor.primaryColor,
      foregroundColor: Color(0xFFFFFCFC),
      textStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadiusGeometry.zero),
      fixedSize: Size(400, 52)
    ),
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
   backgroundColor: LightColor.backgroundColor,
   type: BottomNavigationBarType.fixed,
   unselectedItemColor: Color(0xFF363636),
   selectedItemColor:  LightColor.primaryColor ,
    showUnselectedLabels: true,
  ),
  progressIndicatorTheme: ProgressIndicatorThemeData(
    color: Colors.white,
  ),
  textTheme: TextTheme(
    titleMedium: TextStyle(color: Color(0xFF161F1B), fontSize: 16),
    labelMedium: TextStyle(color: Colors.black, fontSize: 16),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
    filled: true,
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Colors.red, width: 1),
    ),
    focusColor: Color(0xFFD1DAD6),
    fillColor: Color(0xFFFFFFFF),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: Color(0xFFD1DAD6), width: 1),
    ),
  ),


);
