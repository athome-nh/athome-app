import 'package:athome/Config/local_data.dart';

import 'package:athome/home/NavSwitch.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../Config/property.dart';

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: mainColorWhite,
        body: Column(
          children: [
            CarouselSlider(
              carouselController: buttonCarouselController,
              options: CarouselOptions(
                autoPlay: false,
                height: getHeight(context, 88),
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
                    ? Container(
                        width: getWidth(context, 70),
                        height: getHeight(context, 6),
                        decoration: BoxDecoration(
                            color: mainColorRed,
                            borderRadius: BorderRadius.circular(50)),
                        child: TextButton(
                          onPressed: () {
                            setBoolPrefs("onbord", true);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const NavSwitch()),
                            );
                          },
                          child: Text(
                            "Get Start",
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
                            TextButton(
                              onPressed: () {
                                setBoolPrefs("onbord", true);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const NavSwitch()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColorWhite,
                              ),
                              child: Text(
                                'SKIP',
                                style: TextStyle(
                                  fontFamily: mainFontbold,
                                  fontSize: getHeight(context, 2),
                                  color: mainColorBlack,
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
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
                            Container(
                              height: getHeight(context, 5),
                              decoration: BoxDecoration(
                                  color: mainColorRed,
                                  borderRadius: BorderRadius.circular(50)),
                              child: TextButton(
                                onPressed: () {
                                  if (currentIndex == 2) {
                                  } else {
                                    buttonCarouselController.nextPage();
                                  }
                                },
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 5),
                                  ),
                                  child: Row(
                                    children: [
                                      Text(
                                        currentIndex == 2 ? 'FINISH' : 'Next',
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
        Expanded(
          child: CachedNetworkImage(
            imageUrl: "assets/images/002_logo_1.png",
            width: getWidth(context, 80),
            height: getHeight(context, 100),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getHeight(context, 3),
        ),
        Expanded(
          flex: 2,
          child: CachedNetworkImage(
            imageUrl: "assets/images/003_welcome_1.png",
          ),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),
        //texts
        Expanded(
          child: Column(
            children: [
              Text(
                "Shop Smarter & Easier",
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
                  "is an innovative platform designed to enhance your online shopping experience.",
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
        Expanded(
          child: CachedNetworkImage(
            imageUrl: "assets/images/002_logo_1.png",
            width: getWidth(context, 80),
            height: getHeight(context, 100),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getHeight(context, 3),
        ),
        Expanded(
          flex: 2,
          child: CachedNetworkImage(
            imageUrl: "assets/images/003_welcome_2.png",
          ),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),
        //texts
        Expanded(
          child: Column(
            children: [
              Text(
                "Learn From the Best",
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
                  "We will guide you with the best tutors and experts in Kurdistan/Iraq",
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
        Expanded(
          child: CachedNetworkImage(
            imageUrl: "assets/images/002_logo_1.png",
            width: getWidth(context, 80),
            height: getHeight(context, 100),
            fit: BoxFit.cover,
          ),
        ),
        SizedBox(
          height: getHeight(context, 3),
        ),
        Expanded(
          flex: 2,
          child: CachedNetworkImage(
            imageUrl: "assets/images/003_welcome_3.png",
          ),
        ),
        SizedBox(
          height: getHeight(context, 5),
        ),
        //texts
        Expanded(
          child: Column(
            children: [
              Text(
                "Your Pocket's Friend",
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
                  "Learn whatever you want, whenever or wherever you are.",
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
