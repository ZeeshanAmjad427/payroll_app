import 'dart:async';
import 'package:flutter/material.dart';
import 'package:payroll/presentation/screens/bottom_navbar_screen/bottom_navbar_screen.dart';
import 'package:payroll/presentation/screens/home_screen/home_screen_ui/home_screen_ui.dart';
import 'package:payroll/presentation/screens/login_screen/login_screen_ui/login_screen_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenUi extends StatefulWidget {
  const SplashScreenUi({super.key});

  @override
  State<SplashScreenUi> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenUi>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _init();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();



  }

  Future<void> _checkSession() async {
    final prefs = await SharedPreferences.getInstance();

    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const BottomNavbarScreen()),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreenUi()),
      );
    }
  }

  Future<void> _init() async{
    await Future.delayed(Duration(seconds: 3));
    await _checkSession();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff008B8B),
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset(
            'assets/logo.png',
            width: 200,
            height: 150,
          ),
        ),
      ),
    );
  }
}
