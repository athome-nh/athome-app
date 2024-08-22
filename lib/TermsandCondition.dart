// Import necessary packages and dependencies
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/main.dart'; 
import 'package:flutter/material.dart'; 
import 'package:get/get.dart'; 

class TermsandCondition extends StatefulWidget {
  // Constructor for the TermsandCondition widget
  const TermsandCondition({super.key});

  @override
  State<TermsandCondition> createState() => _TermsandConditionState();
}

class _TermsandConditionState extends State<TermsandCondition> {
  @override
  Widget build(BuildContext context) {
    // Build method to construct the UI
    return Directionality(
        // Set text direction based on the language
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          // Scaffold widget provides the basic structure for the visual layout
          appBar: AppBar(
            // AppBar widget for displaying the title
            title: Text("Terms Of Use".tr), // Translated title for the AppBar
          ),
          body: SingleChildScrollView(
            // Allows scrolling of content when it overflows the screen
            padding: const EdgeInsets.all(16.0), // Padding around the content
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // Title of the terms and conditions section
                Text(
                  "Terms and Condition for Dlly Las Grocery App title".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 22.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 16.0), // Space between elements
                // Main content of the terms and conditions
                Text(
                  "Terms and Condition for Dlly Las Grocery App content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: General
                Text(
                  "General:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under General section
                Text(
                  "General: content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 8.0),
                // Section title: Delivery
                Text(
                  "Delivery:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Delivery section
                Text(
                  "Delivery: content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: Returns and Refunds
                Text(
                  "Returns and Refunds:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Returns and Refunds section
                Text(
                  "Returns and Refunds: content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: Payment
                Text(
                  "Payment:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Payment section
                Text(
                  "Payment:content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: Privacy
                Text(
                  "Privacy:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Privacy section
                Text(
                  "Privacy:content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: Content Protection
                Text(
                  "Content Protection:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Content Protection section
                Text(
                  "Content Protection:content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: Changes to Terms and Conditions
                Text(
                  "Changes to Terms and Conditions:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Changes to Terms and Conditions section
                Text(
                  "Changes to Terms and Conditions:content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: Governing Law
                Text(
                  "Governing Law:".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Governing Law section
                Text(
                  "Governing Law:content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
                // Section title: Contact Us
                Text(
                  "Contact Us:TC".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 18.0, // Font size for text
                      fontWeight: FontWeight.bold), // Font weight for text
                ),
                const SizedBox(height: 8.0),
                // Content under Contact Us section
                Text(
                  "Contact Us:TC content".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal, // Font family for text
                      fontSize: 14.0), // Font size for text
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ));
  }
}
