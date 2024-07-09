import 'package:blox/core/router/router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "BloX",
      routerConfig: AppRouter().router,
      darkTheme: ThemeData(
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
      ),
      themeMode: ThemeMode.dark,
    );
  }
}
