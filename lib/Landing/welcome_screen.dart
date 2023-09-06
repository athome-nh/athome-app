import 'package:athome/Landing/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:athome/Account/all_text.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../Config/property.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => WelcomeScreenState();
}

class WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const PhoneScreen()),
                            );
                          },
                          child: Text(
                            "Get Start",
                            style: TextStyle(
                                fontFamily: 'Segoe UI',
                                fontSize: 19,
                                color: mainColorWhite,
                                fontWeight: FontWeight.w600),
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
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const PhoneScreen()),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColorWhite,
                              ),
                              child: Text(
                                'SKIP',
                                style: TextStyle(
                                    fontFamily: 'Segoe UI',
                                    fontSize: 19,
                                    color: mainColorGrey,
                                    fontWeight: FontWeight.w600),
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
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const PhoneScreen()),
                                    );
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
                                          fontFamily: 'Segoe UI',
                                          fontSize: 18,
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
        Expanded(
          child: Image.asset(
            welcomeLogoRed,
          ),
        ),
        Expanded(
          flex: 2,
          child: Image.asset(
            welcomeImages[currentIndex],
          ),
        ),
        SizedBox(
          height: (getWidth(context, 5) + getHeight(context, 5)) / 2,
        ),
        //texts
        Expanded(
          child: Column(
            children: [
              Text(
                welcomeTitle[currentIndex],
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize:
                        (getWidth(context, 5) + getHeight(context, 5)) / 2,
                    color: mainColorGrey,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: (getWidth(context, 5) + getHeight(context, 5)) / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  welcomeDescription[currentIndex],
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize:
                          (getWidth(context, 3) + getHeight(context, 3)) / 2,
                      color: mainColorGrey,
                      overflow: TextOverflow.clip),
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
        Expanded(
          child: Image.asset(
            welcomeLogoRed,
          ),
        ),
        Expanded(
          flex: 2,
          child: Image.asset(
            welcomeImages[currentIndex],
          ),
        ),
        SizedBox(
          height: (getWidth(context, 5) + getHeight(context, 5)) / 2,
        ),
        //texts
        Expanded(
          child: Column(
            children: [
              Text(
                welcomeTitle[currentIndex],
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize:
                        (getWidth(context, 5) + getHeight(context, 5)) / 2,
                    color: mainColorGrey,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: (getWidth(context, 5) + getHeight(context, 5)) / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  welcomeDescription[currentIndex],
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize:
                          (getWidth(context, 3) + getHeight(context, 3)) / 2,
                      color: mainColorGrey,
                      overflow: TextOverflow.clip),
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
        Expanded(
          child: Image.asset(
            welcomeLogoRed,
          ),
        ),
        Expanded(
          flex: 2,
          child: Image.asset(
            welcomeImages[currentIndex],
          ),
        ),
        SizedBox(
          height: (getWidth(context, 3) + getHeight(context, 3)) / 2,
        ),
        //texts
        Expanded(
          child: Column(
            children: [
              Text(
                welcomeTitle[currentIndex],
                style: TextStyle(
                    fontFamily: 'Segoe UI',
                    fontSize:
                        (getWidth(context, 5) + getHeight(context, 5)) / 2,
                    color: mainColorGrey,
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: (getWidth(context, 5) + getHeight(context, 5)) / 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  welcomeDescription[currentIndex],
                  style: TextStyle(
                      fontFamily: 'Segoe UI',
                      fontSize:
                          (getWidth(context, 3) + getHeight(context, 3)) / 2,
                      color: mainColorGrey,
                      overflow: TextOverflow.clip),
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