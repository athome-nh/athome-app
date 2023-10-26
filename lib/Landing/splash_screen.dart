import 'dart:async';

import 'package:athome/Config/local_data.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Config/property.dart';
import '../home/nav_switch.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

var userdata = {};

bool loaddata = false;

class _SplashScreenState extends State<SplashScreen> {
  bool seen = true;
  @override
  void initState() {
    super.initState();

    final productrovider = Provider.of<productProvider>(context, listen: false);
    productrovider.updatePost();
    getBoolPrefs("onbord").then((value2) {
      seen = value2;
    });
    Timer(
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => seen ? NavSwitch() : WelcomeScreen(),
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
