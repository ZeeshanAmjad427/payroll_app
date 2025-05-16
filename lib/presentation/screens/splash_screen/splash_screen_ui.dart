import 'dart:async';
import 'package:flutter/material.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/login_screen_ui.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenUi> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreenUi()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff008B8B),
      body: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 200,
          height: 150,
        ),
      ),
    );
  }
}
