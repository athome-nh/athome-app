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
Color mainColorRed = const Color(0xFFe73339);
Color mainColorSuger = const Color(0xFFF8EACF);
Color mainColorSuger1 = const Color(0xFFe0d4ba);
Color mainColorGrey = const Color(0xFF3a393b);
Color mainColorLightGrey = const Color(0xFFf2f2f2);
Color mainColorWhite = const Color(0XFFffffff);
Color mainColorBlack = const Color(0XFF000000);
Color mainFacebookColor = const Color(0xff367FC0);
Color mainGoogleColor = const Color(0xffDD4B39);

///Define { Images } in AtHome
String mainImagePattern = 'assets/images/001_pattern.jpg';
String mainImageLogo1 = 'assets/images/Splash.gif';

/// Define { Width and Height } of the device screen
double getWidth(BuildContext context, double percentage) {
  double h = MediaQuery.of(context).size.width;
  return (h / 100) * percentage;
}

double getHeight(BuildContext context, double percentage) {
  double h = MediaQuery.of(context).size.height;
  return (h / 100) * percentage;
}
