// Import necessary packages and libraries
import 'package:dllylas/Config/property.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// The `disableaccount` class is a StatefulWidget that displays a message indicating the account is disabled.
class disableaccount extends StatefulWidget {
  const disableaccount({super.key});

  @override
  State<disableaccount> createState() => _disableaccountState();
}

class _disableaccountState extends State<disableaccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          // Display a message indicating that the account is disabled.
          "account is disabled".tr,
          style: TextStyle(
            fontFamily: mainFontnormal, // Font style for the text.
            fontSize: 22.0,             // Font size for the text.
            fontWeight: FontWeight.bold, // Font weight for the text.
          ),
        ),
      ),
    );
  }
}
