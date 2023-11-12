import 'dart:convert';
import 'package:athome/Config/local_data.dart';
import 'package:athome/main.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../Config/property.dart';
import '../home/nav_switch.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  @override
  State<StatefulWidget> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  CarouselController buttonCarouselController = CarouselController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          backgroundColor: mainColorWhite,
          elevation: 0,
          leading: IconButton(
              onPressed: () {
                if (currentIndex == 0) {
                  Navigator.pop(context);
                } else if (currentIndex == 1) {
                  buttonCarouselController.jumpToPage(currentIndex - 1);
                } else if (currentIndex == 2) {
                  buttonCarouselController.jumpToPage(currentIndex - 1);
                }
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),
        ),
        body: SafeArea(
          child: Column(
            children: [
              // slide 3 page
              CarouselSlider(
                carouselController: buttonCarouselController,
                options: CarouselOptions(
                  autoPlay: false,
                  height: getHeight(context, 82),
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enlargeCenterPage: false,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, reason) {
                    setState(
                      () {
                        currentIndex = index;
                      },
                    );
                  },
                ),
                items: [
                  slid1(),
                  slid2(),
                  slid3(),
                ],
              ),

              Column(
                children: [
                  currentIndex == 2
                      // Get Start button
                      ? Container(
                          width: getWidth(context, 70),
                          height: getHeight(context, 6),
                          decoration: BoxDecoration(
                              color: mainColorRed,
                              borderRadius: BorderRadius.circular(5)),
                          child: TextButton(
                            onPressed: () {
                              Map<String, dynamic> myMap = {};
                              myMap["onbord"] = true;
                              setStringPrefs("data", json.encode(myMap));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const NavSwitch()),
                              );
                            },
                            style: TextButton.styleFrom(
                                foregroundColor: mainColorRed),
                            child: Text(
                              "Get Start".tr,
                              style: TextStyle(
                                fontFamily: mainFontbold,
                                fontSize: getWidth(context, 4),
                                color: mainColorWhite,
                              ),
                            ),
                          ),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // skip button
                              TextButton(
                                onPressed: () {
                                  Map<String, dynamic> myMap = {};
                                  myMap["onbord"] = true;
                                  setStringPrefs("data", json.encode(myMap));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const NavSwitch()),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColorWhite,
                                  foregroundColor: mainColorWhite,
                                ),
                                child: Text(
                                  'SKIP'.tr,
                                  style: TextStyle(
                                    fontFamily: mainFontbold,
                                    fontSize: getHeight(context, 2),
                                    color: mainColorBlack,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),

                              // 3 dote
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: getWidth(context, 1), left: 5),
                                    width: (getWidth(context, 2.5) +
                                            getHeight(context, 2.5)) /
                                        2,
                                    height: (getWidth(context, 2.5) +
                                            getHeight(context, 2.5)) /
                                        2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: currentIndex == 0
                                          ? mainColorRed
                                          : mainColorBlack,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: getWidth(context, 1), left: 5),
                                    width: (getWidth(context, 2.5) +
                                            getHeight(context, 2.5)) /
                                        2,
                                    height: (getWidth(context, 2.5) +
                                            getHeight(context, 2.5)) /
                                        2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: currentIndex == 1
                                          ? mainColorRed
                                          : mainColorBlack,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: getWidth(context, 1), left: 5),
                                    width: (getWidth(context, 2.5) +
                                            getHeight(context, 2.5)) /
                                        2,
                                    height: (getWidth(context, 2.5) +
                                            getHeight(context, 2.5)) /
                                        2,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: currentIndex == 2
                                          ? mainColorRed
                                          : mainColorBlack,
                                    ),
                                  ),
                                ],
                              ),

                              // next button
                              Container(
                                height: getHeight(context, 5),
                                decoration: BoxDecoration(
                                    color: mainColorRed,
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextButton(
                                  onPressed: () {
                                    if (currentIndex == 2) {
                                    } else {
                                      buttonCarouselController.nextPage();
                                    }
                                  },
                                  style: TextButton.styleFrom(
                                      foregroundColor: mainColorRed),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: getWidth(context, 5),
                                    ),
                                    child: Row(
                                      children: [
                                        Text(
                                          'Next'.tr,
                                          style: TextStyle(
                                            fontFamily: mainFontbold,
                                            fontSize: getHeight(context, 2),
                                            color: mainColorWhite,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Slide One
  Widget slid1() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: getHeight(context, 3),
        ),

        // logo
        Expanded(
          child: Image.asset(
            "assets/images/002_logo_1.png",
            width: getWidth(context, 80),
            height: getHeight(context, 100),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getHeight(context, 3),
        ),

        // image
        Expanded(
          flex: 2,
          child: Image.asset(
            "assets/images/003_welcome_1.png",
          ),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),

        // text
        Expanded(
          child: Column(
            children: [
              Text(
                "wst01".tr,
                style: TextStyle(
                  fontFamily: mainFontbold,
                  fontSize: getHeight(context, 3),
                  color: mainColorGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 7),
                ),
                child: Text(
                  "wsd01".tr,
                  style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: getHeight(context, 2),
                    color: mainColorGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Slide Two
  Widget slid2() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: getHeight(context, 3),
        ),

        // logo
        Expanded(
          child: Image.asset(
            "assets/images/002_logo_1.png",
            width: getWidth(context, 80),
            height: getHeight(context, 100),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getHeight(context, 3),
        ),

        // image
        Expanded(
          flex: 2,
          child: Image.asset(
            "assets/images/003_welcome_2.png",
          ),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),

        // text
        Expanded(
          child: Column(
            children: [
              Text(
                "wst02".tr,
                style: TextStyle(
                  fontFamily: mainFontbold,
                  fontSize: getHeight(context, 3),
                  color: mainColorBlack,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 7),
                ),
                child: Text(
                  "wsd02".tr,
                  style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: getHeight(context, 2),
                    color: mainColorGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Slide Three
  Widget slid3() {
    return Column(
      children: [
        SizedBox(
          height: getHeight(context, 3),
        ),

        // logo
        Expanded(
          child: Image.asset(
            "assets/images/002_logo_1.png",
            width: getWidth(context, 80),
            height: getHeight(context, 100),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getHeight(context, 3),
        ),

        // image
        Expanded(
          flex: 2,
          child: Image.asset(
            "assets/images/003_welcome_3.png",
          ),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),

        // text
        Expanded(
          child: Column(
            children: [
              Text(
                "wst03".tr,
                style: TextStyle(
                  fontFamily: mainFontbold,
                  fontSize: getHeight(context, 3),
                  color: mainColorGrey,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: getHeight(context, 2),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: getWidth(context, 7),
                ),
                child: Text(
                  "wsd03".tr,
                  style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: getHeight(context, 2),
                    color: mainColorGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
