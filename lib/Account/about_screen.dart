import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/property.dart';

// custom text class
class CustomTextAbout extends StatelessWidget {
  final String text;
  const CustomTextAbout({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
      child: Text(
        text.tr,
        style: TextStyle(
          color: mainColorBlack,
          fontFamily: mainFontnormal,
          fontSize: 16,
        ),
        textAlign: TextAlign.justify,
      ),
    );
  }
}

// AboutScreen class
class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text("About Us".tr),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                // Image ( logo )
                Padding(
                  padding: EdgeInsets.only(top: getHeight(context, 5)),
                  child: Image.asset(
                    'assets/images/Logo-Type-2.png',
                    width: getWidth(context, 80),
                  ),
                ),
                // Text and Space
                SizedBox(height: getHeight(context, 5)),
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
                SizedBox(height: getHeight(context, 5)),

              ],
            ),
          ),
        ),
      ),
    );
  }
}