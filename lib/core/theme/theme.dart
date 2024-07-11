import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.black,
      fontSize: 44,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.black,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.black,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      color: Colors.black,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      color: Colors.black,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      color: Colors.black,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      color: Colors.black,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      color: Colors.black,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      color: Colors.black,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.black,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Colors.black,
    ),
    labelLarge: TextStyle(
      fontSize: 11,
      color: Colors.black,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      color: Colors.black,
    ),
    labelSmall: TextStyle(
      fontSize: 9,
      color: Colors.black,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.content,
    seedColor: Colors.black,
  ),
);

final darkTheme = ThemeData(
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      color: Colors.white,
      fontSize: 44,
      fontWeight: FontWeight.bold,
    ),
    displayMedium: TextStyle(
      color: Colors.white,
      fontSize: 40,
      fontWeight: FontWeight.bold,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    ),
    headlineLarge: TextStyle(
      fontSize: 32,
      color: Colors.white,
    ),
    headlineMedium: TextStyle(
      fontSize: 28,
      color: Colors.white,
    ),
    headlineSmall: TextStyle(
      fontSize: 24,
      color: Colors.white,
    ),
    titleLarge: TextStyle(
      fontSize: 22,
      color: Colors.white,
    ),
    titleMedium: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
    titleSmall: TextStyle(
      fontSize: 18,
      color: Colors.white,
    ),
    bodyLarge: TextStyle(
      fontSize: 16,
      color: Colors.white,
    ),
    bodyMedium: TextStyle(
      fontSize: 14,
      color: Colors.white,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      color: Colors.white,
    ),
    labelLarge: TextStyle(
      fontSize: 11,
      color: Colors.white,
    ),
    labelMedium: TextStyle(
      fontSize: 10,
      color: Colors.white,
    ),
    labelSmall: TextStyle(
      fontSize: 9,
      color: Colors.white,
    ),
  ),
  colorScheme: ColorScheme.fromSeed(
    dynamicSchemeVariant: DynamicSchemeVariant.content,
    seedColor: Colors.white,
  ),
);
