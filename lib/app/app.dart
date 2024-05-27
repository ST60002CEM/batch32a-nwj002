import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/screen/splash_screen.dart';
import 'package:liquor_ordering_system/theme/theme_data.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: getApplicationTheme(),
      home: const SplashScreen(),
    );
  }
}
