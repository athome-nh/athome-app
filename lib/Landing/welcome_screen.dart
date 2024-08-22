import 'dart:convert';
import 'package:animate_do/animate_do.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import '../Config/property.dart';
import '../home/nav_switch.dart';

/// `WelcomeScreen` is a StatefulWidget that displays a welcome screen with a carousel slider
/// and a start button that navigates to the `NavSwitch` screen after user completes the carousel.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0; // Tracks the current page index of the carousel slider.
  CarouselController buttonCarouselController =
      CarouselController(); // Controller for the carousel slider.

  @override
  void initState() {
    clearPrifrences(); // Clears preferences when the widget is initialized.
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: mainColorWhite,
          leading: IconButton(
            onPressed: () {
              // Handles back navigation or carousel navigation based on the current index.
              if (currentIndex == 0) {
                Navigator.pop(context);
              } else {
                buttonCarouselController.jumpToPage(currentIndex - 1);
              }
            },
            icon: Icon(
              Icons.arrow_back_ios,
            ),
          ),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Carousel Slider displaying different slides.
            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: false,
                height: getHeight(context, 60),
                viewportFraction: 1.0,
                initialPage: 0,
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    currentIndex =
                        index; // Updates the current index when the page changes.
                  });
                },
              ),
              items: [
                slid1(), // Slide 1 widget.
                slid2(), // Slide 2 widget.
                slid3(), // Slide 3 widget.
              ],
            ),

            // Displays the "Start" button only on the last slide.
            currentIndex == 2
                ? ZoomIn(
                    delay: const Duration(milliseconds: 100),
                    child: Container(
                      width: getWidth(context, 70),
                      height: getHeight(context, 6),
                      decoration: BoxDecoration(
                          color: mainColorRed,
                          borderRadius: BorderRadius.circular(15)),
                      child: TextButton(
                        onPressed: () {
                          // Saves the onboarding status and navigates to `NavSwitch` screen.
                          Map<String, dynamic> myMap = {};
                          myMap["onbord"] = true;
                          setStringPrefs("data", json.encode(myMap));
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NavSwitch()),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(top: 2),
                          child: Text(
                            "Start".tr, // Translated "Start" text.
                            style: TextStyle(
                              fontFamily: mainFontbold,
                              fontSize: 18,
                              color: mainColorWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.all(getWidth(context, 5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Page indicator dots.
                        Container(
                          margin: EdgeInsets.only(
                              top: getWidth(context, 1), left: 5),
                          width: getWidth(context, 2.5),
                          height: getWidth(context, 2.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: currentIndex == 0
                                ? mainColorGrey
                                : mainColorRed,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: getWidth(context, 1), left: 5),
                          width: getWidth(context, 2.5),
                          height: getWidth(context, 2.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: currentIndex == 1
                                ? mainColorGrey
                                : mainColorRed,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: getWidth(context, 1), left: 5),
                          width: getWidth(context, 2.5),
                          height: getWidth(context, 2.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: currentIndex == 2
                                ? mainColorGrey
                                : mainColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  /// Creates the first slide for the carousel.
  Widget slid1() {
    return Column(
      children: [
        // Image for Slide 1.
        Image.asset(
          "assets/images/003_welcome_1.png",
          width: getWidth(context, 100),
          height: getHeight(context, 40),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),
        // Title text for Slide 1.
        Text(
          "wst01".tr,
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
        // Description text for Slide 1.
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 7),
          ),
          child: Text(
            "wsd01".tr,
            style: TextStyle(
              fontFamily: mainFontnormal,
              fontSize: getHeight(context, 2),
              color: mainColorBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Creates the second slide for the carousel.
  Widget slid2() {
    return Column(
      children: [
        // Image for Slide 2.
        Image.asset(
          "assets/images/003_welcome_2.png",
          width: getWidth(context, 100),
          height: getHeight(context, 40),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),
        // Title text for Slide 2.
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
        // Description text for Slide 2.
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 7),
          ),
          child: Text(
            "wsd02".tr,
            style: TextStyle(
              fontFamily: mainFontnormal,
              fontSize: getHeight(context, 2),
              color: mainColorBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  /// Creates the third slide for the carousel.
  Widget slid3() {
    return Column(
      children: [
        // Image for Slide 3.
        Image.asset(
          "assets/images/003_welcome_3.png",
          width: getWidth(context, 100),
          height: getHeight(context, 40),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),
        // Title text for Slide 3.
        Text(
          "wst03".tr,
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
        // Description text for Slide 3.
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getWidth(context, 7),
          ),
          child: Text(
            "wsd03".tr,
            style: TextStyle(
              fontFamily: mainFontnormal,
              fontSize: getHeight(context, 2),
              color: mainColorBlack,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
