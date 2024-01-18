import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Test_Screen extends StatefulWidget {
  const Test_Screen({super.key});

  @override
  State<Test_Screen> createState() => _Test_ScreenState();
}

String selectedItem = 'English';

class _Test_ScreenState extends State<Test_Screen> {
  void initState() {
    selectedItem = lang == "en"
        ? "English"
        : lang == "ar"
            ? "Arabic"
            : "Kurdish";

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            "Account".tr,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: DropdownButton<String>(
                underline: Container(),
                value: selectedItem,
                icon: const SizedBox(),
                dropdownColor: mainColorGrey,
                style: TextStyle(
                  color: mainColorWhite,
                  fontFamily: mainFontbold,
                  fontSize: 16, // Text size
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    selectedItem = newValue!;
                    if (newValue == 'English') {
                      lang = "en";
                      Get.updateLocale(const Locale("en"));
                      setStringPrefs("lang", "en");
                    } else if (newValue == 'Arabic') {
                      lang = "ar";
                      Get.updateLocale(const Locale("ar"));
                      setStringPrefs("lang", "ar");
                    } else {
                      lang = "kur";
                      Get.updateLocale(const Locale("kur"));
                      setStringPrefs("lang", "kur");
                    }
                  });
                },
                items: [
                  // English
                  DropdownMenuItem(
                    value: 'English',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/uk.png",
                          width: 35,
                          height: 35,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: getWidth(context, 2),
                            left: getWidth(context, 2),
                            right: getWidth(context, 2),
                            bottom: getWidth(context, 1),
                          ),
                          child: Text(
                            "English".tr,
                            style: TextStyle(
                              fontFamily: mainFontnormal,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Arabic
                  DropdownMenuItem(
                    value: "Arabic",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/iraq.png",
                          width: 35,
                          height: 35,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: getWidth(context, 2),
                            left: getWidth(context, 2),
                            right: getWidth(context, 2),
                            bottom: getWidth(context, 1),
                          ),
                          child: Text(
                            "Arabic".tr,
                            style: TextStyle(fontFamily: mainFontnormal),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Kurdish
                  DropdownMenuItem(
                    value: 'Kurdish',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          "assets/images/flag.png",
                          width: 35,
                          height: 35,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: getWidth(context, 2),
                            left: getWidth(context, 2),
                            right: getWidth(context, 2),
                            bottom: getWidth(context, 1),
                          ),
                          child: Text(
                            "Kurdish".tr,
                            style: TextStyle(fontFamily: mainFontnormal),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        body: Center(
          child: IconButton(
              onPressed: () {
                DateTime now = DateTime.now();
                now = now.add(Duration(days: 14));
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Directionality(
                        textDirection: lang == "en"
                            ? TextDirection.ltr
                            : TextDirection.rtl,
                        child: Stack(
                          alignment: lang == "en"
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          children: [
                            SizedBox(
                              width: getWidth(context, 70),
                              height: getHeight(context, 50),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                //textcheck
                                children: <Widget>[
                                  Image.asset(
                                    "assets/Victors/sure.png",
                                    width: getWidth(context, 40),
                                    height: getWidth(context, 40),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Delete Account".tr,
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontbold,
                                      fontSize: 25,
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    ("Account recovery opportunity".tr)
                                        .replaceAll(
                                            "@date@",
                                            "(" +
                                                now
                                                    .toString()
                                                    .substring(0, 10) +
                                                ")"),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: mainColorBlack,
                                      fontFamily: mainFontnormal,
                                      fontSize: 16,
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {},
                                    style: TextButton.styleFrom(
                                      fixedSize: Size(getWidth(context, 70),
                                          getHeight(context, 5)),
                                      backgroundColor: mainColorRed,
                                    ),
                                    child: Text(
                                      "Delete".tr,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    style: TextButton.styleFrom(
                                      fixedSize: Size(getWidth(context, 70),
                                          getHeight(context, 5)),
                                    ),
                                    child: Text(
                                      "Cancel".tr,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.close,
                                  color: mainColorBlack,
                                ))
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.call,
                size: 60,
              )),
        ),
      ),
    );
  }
}