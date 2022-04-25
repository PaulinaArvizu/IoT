import 'package:flutter/material.dart';

ThemeData theme = ThemeData(
  primaryColor: Color(0xff4D8D6E),
  accentColor: Color(0xff4D8D6E),
  cardColor: Color(0xff4D8D6E),
  buttonColor: Color(0xff4D8D6E),
  textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all(Colors.white),
          backgroundColor: MaterialStateProperty.all(Color(0xff4D8D6E)))),
  visualDensity: VisualDensity.adaptivePlatformDensity,
  cardTheme: const CardTheme(
    elevation: 0,
    color: Color(0xFFF5F5F5),
  ),
);
