import 'package:flutter/material.dart';

import '../Config/property.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "About Us",
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontMontserrat1, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: mainColorWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColorRed,
          ),
        ),
      ),
    );
  }
}