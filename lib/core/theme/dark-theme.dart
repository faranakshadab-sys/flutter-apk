import 'package:flutter/material.dart';

ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color(0xff2C61C9),
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff0B121F),
    textTheme: textTheme,
    fontFamily: "IranSans");

TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 57,
      height: 64 / 57,
      letterSpacing: -0.25,
      color: Colors.white),
  displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 45,
      height: 52 / 45,
      color: Colors.white),
  displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      height: 44 / 36,
      color: Colors.white),
  headlineLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 40 / 32,
      color: Colors.white),
  headlineMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      height: 36 / 28,
      color: Colors.white),
  headlineSmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 32 / 24,
      color: Colors.white),
  titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      height: 28 / 22,
      color: Colors.white),
  titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 24 / 18,
      letterSpacing: 0.1,
      color: Colors.white),
  titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: Colors.white),
  labelLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 20 / 14,
      color: Colors.white),
  labelMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 12,
      height: 16 / 12,
      color: Colors.white),
  labelSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 11,
      height: 16 / 11,
      color: Colors.white),
  bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      color: Colors.white),
  bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      color: Colors.white),
  bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      color: Colors.white),
);
