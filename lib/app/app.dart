import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/screen/log_in_screen.dart';

class MyMyApp extends StatelessWidget {
  const MyMyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // themes
      home: LoginScreen(),
    );
  }
}
