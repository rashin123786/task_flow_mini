import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: Colors.blue, // Use #0EA5E9
  scaffoldBackgroundColor: Colors.white,
  iconTheme: IconThemeData(color: Colors.white),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.white, // #0EA5E9
    foregroundColor: Colors.black,
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.black)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF0EA5E9), // #0EA5E9 for buttons
      foregroundColor: Colors.white,
    ),
  ),
);
ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primarySwatch: Colors.blue, // Use #0EA5E9
  scaffoldBackgroundColor: Colors.grey[900],
  iconTheme: IconThemeData(color: Colors.black),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[850],
    foregroundColor: Colors.white,
  ),
  textTheme: const TextTheme(bodyMedium: TextStyle(color: Colors.white)),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: Color(0xFF0EA5E9), // #0EA5E9 for buttons
      foregroundColor: Colors.white,
    ),
  ),
);
// Color(0xFF0EA5E9)
