import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
                    "WelcomeToAthomeOnlineMarketApplication!".tr,
                    style: TextStyle(
                        // height: 1.5,
                        color: mainColorBlack,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                    textAlign: TextAlign.justify,
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
                      Icon(Icons.call),
                      Text(
                        "0750 123 4568".tr,
                        style: TextStyle(
                            // height: 1.5,
                            color: mainColorBlack,
                            fontFamily: mainFontnormal,
                            fontSize: 16),
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
                      Icon(Icons.web),
                      Text(
                        "Dllylas.com".tr,
                        style: TextStyle(
                            // height: 1.5,
                            color: mainColorBlack,
                            fontFamily: mainFontnormal,
                            fontSize: 16),
                        textAlign: TextAlign.justify,
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
