/// All the necessary methods for Fonts, Colors and Images to build the Athome App
import 'package:flutter/material.dart';

/// Define {NRT Fonts } in AtHome
String mainFontbold = 'nrtB';
String mainFontnormal = 'nrtN';

/// Define {SPEDA Fonts } in AtHome
// String mainFontbold = 'spedaB';
// String mainFontnormal = 'spedaN';

/// Define {Iranyakan Fonts } in AtHome
// String mainFontbold = 'iraniB';
// String mainFontnormal = 'iraniN';

/// Define { Colors } in AtHome
Color mainColorRed = const Color(0xFFc82036);
Color mainColorGrey = const Color(0xFF014a64);
// Color mainColorLightGrey = const Color(0xFFf2f2f2);
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

///Define { Images } in AtHome
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
