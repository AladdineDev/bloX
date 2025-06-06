import 'package:flutter/material.dart';

final darkTheme = ThemeData.dark().copyWith(
  colorScheme: const ColorScheme.dark(
    primary: Color(0xff1d9bf0),
    secondary: Colors.white,
    surface: Colors.black,
    onPrimary: Colors.white,
    onSurface: Color(0xff7c838b),
    onSurfaceVariant: Colors.white,
    onInverseSurface: Colors.black,
    error: Color(0xfff4222f),
    errorContainer: Color(0xffffd401),
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
    foregroundColor: Colors.white,
  ),
  tabBarTheme: TabBarThemeData(
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
  dividerTheme: DividerThemeData(
    color: const Color(0xff7c838b).withOpacity(0.5),
    thickness: 0.5,
    space: 0,
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
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    shape: CircleBorder(),
    iconSize: 28,
  ),
  filledButtonTheme: FilledButtonThemeData(
    style: FilledButton.styleFrom(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      minimumSize: const Size(64, 32),
      textStyle: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: FilledButton.styleFrom(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black,
      textStyle: const TextStyle(
        fontSize: 18,
        color: Colors.black,
        fontWeight: FontWeight.w700,
      ),
    ),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    shape: LinearBorder(),
  ),
);
