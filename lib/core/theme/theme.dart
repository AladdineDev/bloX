import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark(),
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
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
  ),
  tabBarTheme: const TabBarTheme(
    labelStyle: TextStyle(
      fontSize: 10,
      color: Colors.white,
    ),
  ),
);
