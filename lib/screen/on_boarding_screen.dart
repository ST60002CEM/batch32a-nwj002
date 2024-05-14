import 'package:flutter/material.dart';
import 'package:liquor_ordering_system/screen/login_screen.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color:
            const Color(0xFFD8CEC4), // Set your desired background color here
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/tipsy.png',
                width: 300, // adjust the width as needed
                height: 300, // adjust the height as needed
              ),
              const Text(
                'Welcome to Tipsy',
                style: TextStyle(
                    fontFamily: 'Times New Roman',
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD29062)),
              ),
              const Text('Online Liquor Store',
                  style: TextStyle(
                      fontFamily: 'Times New Roman',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFD29062))),
              const SizedBox(height: 16),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
