import 'package:flutter/material.dart';

class AppTheme {
  ThemeData lightTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0xFF2862F5),
      );

  ThemeData darkTheme() => ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.white,
        brightness: Brightness.dark,
      );
}
