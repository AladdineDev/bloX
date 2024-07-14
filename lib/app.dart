import 'package:blox/core/router/router.dart';
import 'package:blox/core/theme/theme.dart' as theme;
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: "BloX",
      routerConfig: AppRouter().router,
      darkTheme: theme.darkTheme,
      themeMode: ThemeMode.dark,
    );
  }
}
