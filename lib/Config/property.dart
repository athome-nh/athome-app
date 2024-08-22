// Import necessary packages and libraries
import 'dart:math';
import 'package:flutter/material.dart';

/// Define {NRT Fonts }
String mainFontbold = 'nrtB';
String mainFontnormal = 'nrtN';

/// Define {Iranyakan Fonts }
// String mainFontbold = 'iraniB';
// String mainFontnormal = 'iraniN';

/// Define {Font Size}
double sizePageTitle = 20;
double sizeInputText = 16;
double sizeTitle = 16;
double sizeSubtitle = 14;



/// Define { Colors } in AtHome
const Color green = Color(0xFF2FA849);
const Color lightGreen = Color(0xFFECF4F3);
const Color grey = Color(0xFF9C9C9C);
const Color lightGrey = Color(0xFFEBEBEB);
Color mainColorRed = const Color(0xFFc82036);
Color mainColorGrey = const Color(0xFF014a64);
Color mainColorlightGrey = const Color(0xFFf5f5f5);
Color mainColorGrey2 = const Color(0xFFb6b7b6);
Color mainColorLightGrey = const Color(0xFFf2f2f2);
Color mainColorWhite = const Color(0XFFffffff);
Color mainColorBlack = const Color(0XFF1c1c1c);
Color mainFacebookColor = const Color(0xff367FC0);
Color mainGoogleColor = const Color(0xffDD4B39);
// Define your list of colors
List<Color> categoryColors = [
  Color(0xFFedf8f2),
  Color(0xFFfff6ed),
  Color(0xFFfde8e3),
  Color(0xFFf3ebf8),
  Color(0xFFfff8e5),
  Color(0xFFeef7fc),
];
int colorNumber = Random().nextInt(6);

// String mainImagePattern = 'assets/images/001_pattern.jpg';
String mainImageLogo1 = 'assets/images/dlly_las.gif';

/// Define { Width and Height } of the device screen
double getWidth(BuildContext context, double percentage) {
  double h = MediaQuery.of(context).size.width;
  return (h / 100) * percentage;
}

double getHeight(BuildContext context, double percentage) {
  double h = MediaQuery.of(context).size.height;
  return (h / 100) * percentage;
}
