import 'package:blox/core/router/router.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRouter().router,
      debugShowCheckedModeBanner: false,
      title: "BloX",
    );
  }
}
