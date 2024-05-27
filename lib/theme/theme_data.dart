import 'package:flutter/material.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
    primarySwatch: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    fontFamily: 'OpenSans Regular',
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'OpenSans Regular',
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFD29062),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    ),
  );
}

