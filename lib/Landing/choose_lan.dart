import 'package:athome/Landing/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Config/local_data.dart';
import '../Config/property.dart';
import '../main.dart';

class ChooseLang extends StatefulWidget {
  const ChooseLang({super.key});
  @override
  State<ChooseLang> createState() => _ChooseLangState();
}

class _ChooseLangState extends State<ChooseLang> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                
                // top image
                Image.asset("assets/images/world.png"),
                // Language
                Text(
                  "Language".tr,
                  style: TextStyle(
                      fontFamily: mainFontbold,
                      fontSize: 24,
                      color: mainColorGrey),
                ),
                // Space
                SizedBox(
                  height: getHeight(context, 3),
                ),
                // Kurdish 
                GestureDetector(
                  onTap: () {
                    lang = "kur";
                    Get.updateLocale(const Locale("kur"));
                    setStringPrefs("lang", "kur");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: mainColorGrey)),
                    width: getWidth(context, 80),
                    height: getWidth(context, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("assets/images/flag_kurdish.png"),
                        Text(
                          "Kurdish".tr,
                          style: TextStyle(
                              fontFamily: mainFontbold,
                              fontSize: 14,
                              color: mainColorGrey),
                        ),
                        Icon(
                          Icons.check,
                          color: lang == "kur" ? Colors.green : mainColorWhite,
                        ),
                      ],
                    ),
                  ),
                ),
                // Space
                SizedBox(
                  height: getHeight(context, 2),
                ),
                // Arabic
                GestureDetector(
                  onTap: () {
                    lang = "ar";
                    Get.updateLocale(const Locale("ar"));
                    setStringPrefs("lang", "ar");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: mainColorGrey)),
                    width: getWidth(context, 80),
                    height: getWidth(context, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("assets/images/flag_iraq.png"),
                        Text(
                          "Arabic".tr,
                          style: TextStyle(
                              fontFamily: mainFontbold,
                              fontSize: 14,
                              color: mainColorGrey),
                        ),
                        Icon(
                          Icons.check,
                          color: lang == "ar" ? Colors.green : mainColorWhite,
                        ),
                      ],
                    ),
                  ),
                ),
                // Space
                SizedBox(
                  height: getHeight(context, 2),
                ),
                // English
                GestureDetector(
                  onTap: () {
                    lang = "en";
                    Get.updateLocale(const Locale("en"));
                    setStringPrefs("lang", "en");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: mainColorGrey)),
                    width: getWidth(context, 80),
                    height: getWidth(context, 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("assets/images/flag_english.png"),
                        Text(
                          "English".tr,
                          style: TextStyle(
                              fontFamily: mainFontbold,
                              fontSize: 14,
                              color: mainColorGrey),
                        ),
                        Icon(
                          Icons.check,
                          color: lang == "en" ? Colors.green : mainColorWhite,
                        ),
                      ],
                    ),
                  ),
                ),
                // Space
                SizedBox(
                  height: getHeight(context, 7),
                ),
                // Get Start
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const WelcomeScreen(),
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.only(
                      top: getWidth(context, 2),
                      left: getWidth(context, 2),
                      right: getWidth(context, 2),
                      bottom: getWidth(context, 1),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(color: mainColorGrey)),
                    width: getWidth(context, 35),
                    height: getWidth(context, 12),
                    child: Center(
                      child: Text(
                        "Get Start".tr,
                        style: TextStyle(
                            fontFamily: mainFontbold,
                            fontSize: 14,
                            color: mainColorGrey),
                      ),
                    ),
                  ),
                )
              
              ],
            ),
          ),
        ),
      ),
    );
  }
}
