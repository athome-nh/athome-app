// Import necessary packages and libraries
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/property.dart';

// Custom widget for displaying text content about the app
class CustomTextAbout extends StatelessWidget {

  final String text;

  // Constructor to initialize the text content
  const CustomTextAbout({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
      child: Text(
        text.tr,
        style: TextStyle(
          color: mainColorBlack, // Text color
          fontFamily: mainFontnormal, // Font family
          fontSize: 16, // Font size
        ),
        textAlign: TextAlign.justify, // Align the text to be justified
      ),
    );
  }
}

// AboutScreen widget that displays information about the app
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

// State class for AboutScreen
class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    // Determine text direction based on language (RTL for Arabic and Kurdish, LTR for English)
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        // AppBar containing the title and a back button
        appBar: AppBar(
          title: Text("About Us".tr), // Title with translation
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context); // Go back to the previous screen
            },
            icon: Icon(Icons.arrow_back_ios), // Back icon
          ),
        ),
        // Body of the screen wrapped in SingleChildScrollView for scrolling
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Display logo image at the top
                Padding(
                  padding: EdgeInsets.only(top: getHeight(context, 5)),
                  child: Image.asset(
                    'assets/images/Logo-Type-2.png', // Path to the logo image
                    width: getWidth(context, 80), // Set width relative to screen size
                  ),
                ),
                
                // Add vertical spacing 
                SizedBox(height: getHeight(context, 5)),
                
                // CustomTextAbout widget to display various translated text blocks
                CustomTextAbout(text: "AboutTextOne"),
                SizedBox(height: getHeight(context, 2)),
                CustomTextAbout(text: "AboutTextTwo"),
                SizedBox(height: getHeight(context, 2)),
                CustomTextAbout(text: "AboutTextThree"),
                SizedBox(height: getHeight(context, 2)),
                CustomTextAbout(text: "AboutTextFour"),
                SizedBox(height: getHeight(context, 2)),
                CustomTextAbout(text: "AboutTextFive"),
                SizedBox(height: getHeight(context, 2)),
                CustomTextAbout(text: "AboutTextSix"),
                SizedBox(height: getHeight(context, 2)),
                CustomTextAbout(text: "AboutTextSeven"),
                SizedBox(height: getHeight(context, 2)),
                CustomTextAbout(text: "AboutTextEight"),
                
                // Add vertical spacing
                SizedBox(height: getHeight(context, 5)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
