import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.lightBlueAccent,
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(fontWeight: FontWeight.w700),
    titleMedium: TextStyle(fontWeight: FontWeight.w700),
    titleSmall: TextStyle(fontWeight: FontWeight.w700),
    bodyLarge: TextStyle(fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(fontWeight: FontWeight.w500),
    bodySmall: TextStyle(fontWeight: FontWeight.w500),
  ),
);
