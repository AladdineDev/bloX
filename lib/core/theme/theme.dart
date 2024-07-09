import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.content,
    seedColor: Colors.black,
  ),
);

final darkTheme = ThemeData(
  appBarTheme: const AppBarTheme(
    color: Colors.black,
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: const TextTheme(
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.content,
    seedColor: Colors.white,
  ),
);
