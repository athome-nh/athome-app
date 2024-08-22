// Import necessary packages and libraries
import 'package:dllylas/main.dart';  
import 'package:flutter/material.dart'; 
import 'package:get/get.dart';  
import 'package:url_launcher/url_launcher.dart';  
import '../Config/property.dart'; 

/// provides a screen with help and contact information.
class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      // Set text direction based on language
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Help".tr,  
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);  // Navigate back to the previous screen
            },
            icon: Icon(
              Icons.arrow_back_ios,  
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    top: getHeight(context, 5),  // Top margin for the logo
                  ),
                  child: Image.asset(
                    'assets/images/Logo-Type-2.png',  // Logo image
                    width: getWidth(context, 80),  // Width of the logo
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 5),  // Spacing below the logo
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),  // Horizontal padding for the text
                  child: Text(
                    "DescriptionTextInHelp".tr,  
                    style: TextStyle(
                        color: mainColorBlack,
                        fontFamily: mainFontnormal,
                        fontSize: 20),
                    textAlign: TextAlign.justify,  
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 5),  // Spacing between sections
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),  // Horizontal padding for the phone number section
                  child: Row(
                    children: [
                      Icon(Icons.call),  // Phone icon
                      SizedBox(
                        width: getHeight(context, 2),  // Spacing between icon and text
                      ),
                      Text(
                        "PhoneNumber".tr, 
                        style: TextStyle(
                            color: mainColorBlack,
                            fontFamily: mainFontnormal,
                            fontSize: 20),
                        textAlign: TextAlign.justify,  
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),  // Spacing between sections
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),  // Horizontal padding for the email section
                  child: Row(
                    children: [
                      Icon(Icons.email_outlined),  // Email icon
                      SizedBox(
                        width: getHeight(context, 2),  // Spacing between icon and text
                      ),
                      GestureDetector(
                        onTap: () {
                          // Action when email text is tapped (email functionality can be implemented here)
                        },
                        child: Text(
                          "Email".tr,
                          style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 20),
                          textAlign: TextAlign.justify,  // Justified text alignment
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),  // Spacing between sections
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),  // Horizontal padding for the website section
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(
                        width: getHeight(context, 2),  // Spacing between icon and text
                      ),
                      GestureDetector(
                        onTap: () async {
                          Uri url = Uri.parse('https://dllylas.com');  // URL for the website
                          if (!await launchUrl(url,
                              mode: LaunchMode.inAppBrowserView)) {
                            // Handle the case where the URL could not be launched
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Text(
                          "WebSite".tr, 
                          style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 20),
                          textAlign: TextAlign.justify,  // Justified text alignment
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),  // Spacing between sections
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),  // Horizontal padding for the Facebook section
                  child: Row(
                    children: [
                      Icon(Icons.facebook),  // Facebook icon
                      SizedBox(
                        width: getHeight(context, 2),  // Spacing between icon and text
                      ),
                      GestureDetector(
                        onTap: () async {
                          Uri url = Uri.parse(
                              'https://mobile.facebook.com/DLLY.LAS.24');  // URL for the Facebook page
                          if (!await launchUrl(url,
                              mode: LaunchMode.inAppBrowserView)) {
                            // Handle the case where the URL could not be launched
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Text(
                          "Facebook".tr,
                          style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 20),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 5),// Spacing
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
