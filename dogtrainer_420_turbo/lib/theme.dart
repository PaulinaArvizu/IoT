import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff4D8D6E),
    onPrimary: Colors.white, //Color(0xff4D8D6E),
    secondary: Color(0xff4D8D6E),
    onSecondary: Colors.white, //Color(0xff4D8D6E),
    error: Colors.red,
    onError: Colors.white, //Colors.red,
    background: Color(0xFFF5F5F5),
    onBackground: Colors.black, //Color(0xFFF5F5F5),
    surface: Color(0xFFF5F5F5),
    onSurface: Colors.black, //Color(0xFFF5F5F5),
  ),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  textTheme: const TextTheme(
    caption: TextStyle(
      color: Colors.red,
    ),
  ),
  cardTheme: const CardTheme(
    elevation: 0,
    color: Color(0xFFF5F5F5),
  ),
);
