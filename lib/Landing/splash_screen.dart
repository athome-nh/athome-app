import 'dart:async';

import 'package:athome/home/NavSwitch.dart';
import 'package:flutter/material.dart';
import '../Config/property.dart';

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
      Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const NavSwitch(),
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
            Opacity(
              opacity: 0.25,
              child: Image.asset(
                mainImagePattern,
                width: getWidth(context, 100),
                height: getHeight(context, 100),
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Image.asset(
                mainImageLogo1,
                width: getWidth(context, 100),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
