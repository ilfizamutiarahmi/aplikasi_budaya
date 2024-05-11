import 'package:flutter/material.dart';
import 'package:aplikasi_budaya/view/login.dart';
import 'package:aplikasi_budaya/view/register.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _goToNextScreen();
  }

  _goToNextScreen() async {
    await Future.delayed(const Duration(milliseconds: 5000));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFFFAD7C8),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/rumah_gadang1.png',
                width: 250,
              ),
              Text(
                    "Minangkabau",
                    style: TextStyle(
                      fontFamily: 'Sail',
                      fontSize: 36,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
