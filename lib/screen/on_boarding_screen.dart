import 'dart:async';

import 'package:flutter/material.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(
      const Duration(seconds: 3),
      () => Navigator.of(context),
    );
    return const Scaffold(
      body: Center(
        child: Text(
          "Welcome Nawaraj Shrestha",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
