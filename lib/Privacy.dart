// Import necessary packages and dependencies
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// Define the PrivacyScreen widget as a stateful widget
class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

// Define the state for the PrivacyScreen widget
class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      // Set the text direction based on the language (LTR for English, RTL for others)
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        // Define the app bar with a localized title
        appBar: AppBar(
          title: Text("Privacy Poilcy".tr), // Localized text for privacy policy title
        ),
        // The body of the screen is a scrollable column
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0), // Padding around the content
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
            children: <Widget>[
              // Section title for "Privacy Policy Title" with bold styling
              Text(
                "Privacy Policy Title".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Text block for the introduction of the privacy policy
              Text(
                "Privacy Policy intoduction".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for data collection with bold styling
              Text(
                "collection and using personal data - types of data collected".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Subsection for personal data with bold styling
              Text(
                "personal data".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for personal data
              Text(
                "personal data content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Subsection for usage data with bold styling
              Text(
                "Usage Data".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for usage data
              Text(
                "Usage Data content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for how data is used with bold styling
              Text(
                "How We Use Your Information".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for how data is used
              Text(
                "How We Use Your Information content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for data sharing with bold styling
              Text(
                "Sharing Your Information".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for data sharing
              Text(
                "Sharing Your Information content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for privacy choices with bold styling
              Text(
                "Your Privacy Choices".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for privacy choices
              Text(
                "Your Privacy Choices content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for data security with bold styling
              Text(
                "Data Security".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for data security
              Text(
                "Data Security content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for data retention with bold styling
              Text(
                "Data Retention".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for data retention
              Text(
                "Data Retention content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for additional information and permissions with bold styling
              Text(
                "additional information & Permissions and Compliance with Laws"
                    .tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Subsection for permissions with bold styling
              Text(
                "Permissions".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for permissions
              Text(
                "Permissions content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for compliance with laws with bold styling
              Text(
                "Compliance with Laws".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for compliance with laws
              Text(
                "Compliance with Laws content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for the effective date with bold styling
              Text(
                "Effective Date".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for the effective date
              Text(
                "Effective Date content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for changes to the privacy policy with bold styling
              Text(
                "Changes to Privacy Policy".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for changes to the privacy policy
              Text(
                "Changes to Privacy Policy content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Spacing between sections

              // Section title for contact information with bold styling
              Text(
                "Contact Us".tr,
                style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8.0), // Smaller spacing for subsections

              // Description text for contact information
              Text(
                "Contact Us content".tr,
                style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
              ),
              const SizedBox(height: 16.0), // Final spacing at the bottom of the page
            ],
          ),
        ),
      ),
    );
  }
}
