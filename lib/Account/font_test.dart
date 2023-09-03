import 'package:flutter/material.dart';
import '../configuration.dart';

class FontTest extends StatefulWidget {
  const FontTest({super.key});

  @override
  State<FontTest> createState() => _FontTestState();
}

class _FontTestState extends State<FontTest> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat1,
                   fontSize: 30,
                   ),
              ),
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat2,
                   fontSize: 30,
                   ),
              ),
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat3,
                   fontSize: 30,
                   ),
              ),
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat4,
                   fontSize: 30,
                   ),
              ),
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat5,
                   fontSize: 30,
                   ),
              ),
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat6,
                   fontSize: 30,
                   ),
              ),
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat7,
                   fontSize: 30,
                   ),
              ),
              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat8,
                   fontSize: 30,
                   ),
              ),

              Text(
                "Bawar Wahid Saber",
                style: TextStyle(
                  fontFamily: mainFontMontserrat9,
                   //fontWeight: FontWeight.w900,
                   //fontStyle: FontStyle.italic,
                   fontSize: 30,
                   ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}