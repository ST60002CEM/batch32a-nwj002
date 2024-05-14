import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/screen/on_boarding_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // themes
      home: OnBoardingScreen(),
    );
  }
}
