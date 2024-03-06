import 'package:dllylas/Config/property.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyScreen extends StatefulWidget {
  const PrivacyScreen({super.key});

  @override
  State<PrivacyScreen> createState() => _PrivacyScreenState();
}

class _PrivacyScreenState extends State<PrivacyScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: Scaffold(
          appBar: AppBar(
            title: Text("Privacy Poilcy".tr),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Privacy Policy Title".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Privacy Policy intoduction".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "collection and using personal data - types of data collected "
                      .tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "personal data".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "personal data content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Usage Data".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Usage Data content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "How We Use Your Information".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "How We Use Your Information content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Sharing Your Information".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Sharing Your Information content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Your Privacy Choices".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Your Privacy Choices content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Data Security".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Data Security content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Data Retention".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Data Retention content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "additional information & Permissions and Compliance with Laws"
                      .tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Permissions".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Permissions content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Compliance with Laws".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Compliance with Laws content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Effective Date".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Effective Date content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Changes to Privacy Policy".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Changes to Privacy Policy content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
                Text(
                  "Contact Us".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Text(
                  "Contact Us content".tr,
                  style: TextStyle(fontFamily: mainFontnormal, fontSize: 14.0),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ),
        ));
  }
}
