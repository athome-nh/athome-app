import 'package:flutter/material.dart';

import '../Config/property.dart';

class BlankPage extends StatefulWidget {
  const BlankPage({super.key});

  @override
  State<BlankPage> createState() => _BlankPageState();
}

class _BlankPageState extends State<BlankPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Under Design",
        ),
      ),

      // body
      body: Center(
        child: Text(
          "No Design",
          style: TextStyle(
            fontFamily: mainFontbold,
            color: mainColorGrey,
            fontSize: 24,
          ),
        ),
      ),
    );
  }
}
