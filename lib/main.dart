import 'package:athome/Landing/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(const AtHomeApp());

class AtHomeApp extends StatelessWidget {
  const AtHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AtHome Market',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}