import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff1d9bf0),
    surface: Colors.black,
    onSurface: Color(0xffd7d7d7),
    onSurfaceVariant: Colors.white,
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
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
  ),
  tabBarTheme: TabBarTheme(
    labelPadding: const EdgeInsets.symmetric(vertical: 8),
    dividerColor: const Color(0xff7c838b),
    indicatorSize: TabBarIndicatorSize.tab,
    indicator: UnderlineTabIndicator(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(
        style: BorderStyle.solid,
        color: Color(0xff1d9bf0),
        width: 3,
      ),
      insets: const EdgeInsets.only(left: 10, right: 10, bottom: 1),
    ),
    labelStyle: const TextStyle(
      fontSize: 14,
    ),
    labelColor: const Color(0xffd7d7d7),
    unselectedLabelStyle: const TextStyle(
      fontSize: 14,
    ),
    unselectedLabelColor: const Color(0xff7c838b),
  ),
  dividerTheme: const DividerThemeData(
    color: Color(0xff7c838b),
    thickness: 0.5,
  ),
  listTileTheme: const ListTileThemeData(
    contentPadding: EdgeInsets.symmetric(horizontal: 20),
    minTileHeight: 48,
    titleTextStyle: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  ),
  expansionTileTheme: const ExpansionTileThemeData(
    textColor: Colors.white,
    shape: Border(),
  ),
);
