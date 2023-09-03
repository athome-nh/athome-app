import 'dart:async';
import 'package:flutter/material.dart';
import 'package:athome/screens/welcome_screen_1.dart';
import '../configuration.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int x = 500;
  @override
  void initState() {
    super.initState();
    Timer(
      const Duration(seconds: 7),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const WelcomeScreenOne(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(mainImagePattern,
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              fit: BoxFit.cover,
            ),
            Center(
              child: Image.asset(mainImageLogo1,),
            ),
          ],
        ),
      ),
    );
  }
}