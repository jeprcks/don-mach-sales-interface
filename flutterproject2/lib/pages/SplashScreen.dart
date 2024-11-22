// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'dart:async';
import '../Auth/login_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();

    // Toggle visibility and navigate after delay
    Timer(const Duration(seconds: 2), () {
      setState(() {
        _visible = false;
      });

      Timer(const Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginPage()),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Subtle background to match branding
      appBar: AppBar(
        title: const Text(
          'Don Macchiatos Sales Management System',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.brown, // Theme matching background color
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedOpacity(
              opacity: _visible ? 1.0 : 0.0,
              duration: const Duration(seconds: 2),
              child: Image.asset(
                'assets/donmacisreal.png', // Replace with your image path
                width: 450, // Increased size
                height: 450,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
