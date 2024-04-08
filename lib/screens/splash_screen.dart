import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:bsf/screens/Login/login_screen.dart'; // Import the LoginScreen class

class SplashScreen extends StatefulWidget {
  static const String routeName = '/'; // Define route name for SplashScreen

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loadSplashScreen();
  }

  void _loadSplashScreen() async {
    // Simulate a delay of 1 second
    await Future.delayed(const Duration(seconds: 1));
    // Navigate to the next screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/load.json',
          width: 200, // Adjust the width as needed
          height: 200, // Adjust the height as needed
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
