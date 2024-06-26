import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Config/property.dart';

class HelpScreen extends StatefulWidget {
  const HelpScreen({super.key});

  @override
  State<HelpScreen> createState() => _HelpScreenState();
}

class _HelpScreenState extends State<HelpScreen> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Help".tr,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
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
                    top: getHeight(context, 5),
                  ),
                  child: Image.asset(
                    'assets/images/Logo-Type-2.png',
                    width: getWidth(context, 80),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 5),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
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
                  height: getHeight(context, 5),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                  child: Row(
                    children: [
                      Icon(Icons.call),
                      SizedBox(
                        width: getHeight(context, 2),
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
                  height: getHeight(context, 2),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                  child: Row(
                    children: [
                      Icon(Icons.email_outlined),
                      SizedBox(
                        width: getHeight(context, 2),
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          "Email".tr,
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
                  height: getHeight(context, 2),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(
                        width: getHeight(context, 2),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Uri url = Uri.parse('https://dllylas.com');
                          if (!await launchUrl(url,
                              mode: LaunchMode.inAppBrowserView)) {
                            throw Exception('Could not launch $url');
                          }
                        },
                        child: Text(
                          "WebSite".tr,
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
                  height: getHeight(context, 2),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 6)),
                  child: Row(
                    children: [
                      Icon(Icons.facebook),
                      SizedBox(
                        width: getHeight(context, 2),
                      ),
                      GestureDetector(
                        onTap: () async {
                          Uri url = Uri.parse(
                              'https://mobile.facebook.com/DLLY.LAS.24');
                          if (!await launchUrl(url,
                              mode: LaunchMode.inAppBrowserView)) {
                            throw Exception('Could not launch $url');
                          }

                          // Replace <page_id> with your Facebook Page ID
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
                  height: getHeight(context, 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
