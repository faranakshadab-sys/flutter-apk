import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    colorSchemeSeed: Color(0xff2C61C9),
    brightness: Brightness.light,
    fontFamily: "IranSans",
    textTheme: textTheme);

TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 57,
      height: 64 / 57,
      letterSpacing: -0.25,
      color: Color(0xff1A253A)),
  displayMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 45,
      height: 52 / 45,
      color: Color(0xff1A253A)),
  displaySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      height: 44 / 36,
      color: Color(0xff1A253A)),
  headlineLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 40 / 32,
      color: Color(0xff1A253A)),
  headlineMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      height: 36 / 28,
      color: Color(0xff1A253A)),
  headlineSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 24,
      height: 32 / 24,
      color: Color(0xff1A253A)),
  titleLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 22,
      height: 28 / 22,
      color: Color(0xff1A253A)),
  titleMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 18,
      height: 24 / 18,
      letterSpacing: 0.1,
      color: Color(0xff1A253A)),
  titleSmall: TextStyle(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: Color(0xff1A253A)),
  labelLarge: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 14,
      height: 20 / 14,
      color: Color(0xff1A253A)),
  labelMedium: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 12,
      height: 16 / 12,
      color: Color(0xff1A253A)),
  labelSmall: TextStyle(
      fontWeight: FontWeight.w700,
      fontSize: 11,
      height: 16 / 11,
      color: Color(0xff1A253A)),
  bodyLarge: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      color: Color(0xff1A253A)),
  bodyMedium: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      color: Color(0xff1A253A)),
  bodySmall: TextStyle(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      color: Color(0xff1A253A)),
);
