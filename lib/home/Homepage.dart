import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import 'package:athome/Config/property.dart';
import 'package:athome/Home/AllItem.dart';
import 'package:athome/Home/Categories.dart';
import 'package:athome/Home/ItemDeatil.dart';
import 'package:athome/Home/Notfication.dart';
import 'package:athome/Home/test.dart';

// ignore: camel_case_types
class Home_SC extends StatefulWidget {
  const Home_SC({super.key});

  @override
  State<Home_SC> createState() => _Home_SCState();
}

// ignore: camel_case_types
class _Home_SCState extends State<Home_SC> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffF2F2F2),
        centerTitle: false,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  "Delivering to",
                  style: TextStyle(
                      color: mainColorGrey.withOpacity(0.5),
                      fontFamily: mainFontMontserrat4,
                      fontSize: 12),
                ),
              ),
              Row(
                children: [
                  Text(
                    "Current Location",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 14,
                        fontFamily: mainFontMontserrat6),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down_outlined,
                    color: mainColorRed,
                    size: 20,
                  )
                ],
              ),
            ],
          ),
        ),
        actions: [
          Row(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_none_outlined,
                  color: mainColorRed,
                  size: 30,
                ), // Another icon at the end (trailing)
                onPressed: () {
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NotficationScreen()),
            );
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: getWidth(context, 100),
              height: getHeight(context, 25),
              decoration: const BoxDecoration(
                color: Color(0xffF2F2F2),
              ),
              child: Center(
                child: Stack(
                  children: [
                    Image.asset(
                      "assets/images/saxa.png",
                      fit: BoxFit.fill,
                      
                    ),
                    Padding(
                      padding: EdgeInsets.all(getHeight(context, 2)),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          width: getWidth(context, 25),
                          height: getHeight(context, 4),
                          decoration: BoxDecoration(
                              color: mainColorRed,
                              borderRadius: BorderRadius.circular(50)),
                          child: TextButton(
                              onPressed: () {},
                              child: Text(
                                "Order now",
                                style:
                                    TextStyle(color: mainColorWhite, fontSize: 14),
                              )),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Text(
                    "Categories",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 16,
                        fontFamily: mainFontMontserrat6),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Categories()),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: mainColorRed,
                              fontSize: 14,
                              fontFamily: mainFontMontserrat4),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: mainColorRed,
                        size: 13,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: getHeight(context, 15),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ItemDeatil()),
                            );
                          },
                          child: Card(
                            elevation: 3,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  100), // Adjust the corner radius
                            ),
                            child: Container(
                              width: getHeight(context, 9),
                              height: getHeight(context, 9),
                              decoration: BoxDecoration(
                                  color: Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(100)),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/790.png",
                                  width: getHeight(context, 6),
                                  height: getHeight(context, 6),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Text(
                          "Grocery",
                          style: TextStyle(
                              color: mainColorGrey,
                              fontFamily: mainFontMontserrat4,
                              fontSize: 14),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Text(
                    "Discount",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 16,
                        fontFamily: mainFontMontserrat6),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AllItem()),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: mainColorRed,
                              fontSize: 14,
                              fontFamily: mainFontMontserrat4),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: mainColorRed,
                        size: 13,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: getHeight(context, 22),
              decoration: BoxDecoration(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ItemDeatil()),
                                    );
                                  },
                                  child: Container(
                                    width: getHeight(context, 14),
                                    height: getHeight(context, 14),
                                    decoration: BoxDecoration(
                                        color: Color(0xffF2F2F2),
                                        borderRadius:
                                            BorderRadius.circular(15)),
                                    child: Center(
                                      child: Image.asset(
                                        "assets/images/408.png",
                                        width: getHeight(context, 13),
                                        height: getHeight(context, 13),
                                      ),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                        width: getHeight(context, 4),
                                        height: getHeight(context, 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: mainColorGrey
                                                  .withOpacity(0.5)),
                                        ),
                                        child: Icon(Icons.add,
                                            color: mainColorGrey,
                                            size: getHeight(context, 3))),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                width: getHeight(context, 6),
                                height: getHeight(context, 3),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    //  topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    // bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                  color: mainColorRed,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "30\%",
                                      style: TextStyle(
                                          color: mainColorWhite,
                                          fontFamily: mainFontMontserrat4,
                                          fontSize: 12),
                                    ),
                                    Icon(Icons.discount_rounded,
                                        color: mainColorWhite, size: 15),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Container(
                          width: getHeight(context, 12),
                          child: Text(
                            "Nutriholland number 3 ",
                            maxLines: 2,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          width: getHeight(context, 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "200,000 IQD",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: mainColorGrey,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 8),
                              ),
                              Text(
                                "100,500 IQD",
                                style: TextStyle(
                                    color: mainColorRed,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: getHeight(context, 2),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Text(
                    "Highlight",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 16,
                        fontFamily: mainFontMontserrat6),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AllItem()),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: mainColorRed,
                              fontSize: 14,
                              fontFamily: mainFontMontserrat4),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: mainColorRed,
                        size: 13,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: getHeight(context, 22),
              decoration: BoxDecoration(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: getHeight(context, 14),
                                  height: getHeight(context, 14),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF2F2F2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/408.png",
                                      width: getHeight(context, 13),
                                      height: getHeight(context, 13),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                        width: getHeight(context, 4),
                                        height: getHeight(context, 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: mainColorGrey
                                                  .withOpacity(0.5)),
                                        ),
                                        child: Icon(Icons.add,
                                            color: mainColorGrey,
                                            size: getHeight(context, 3))),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                width: getHeight(context, 6),
                                height: getHeight(context, 3),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    //  topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    // bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                  color: mainColorRed,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "30\%",
                                      style: TextStyle(
                                          color: mainColorWhite,
                                          fontFamily: mainFontMontserrat4,
                                          fontSize: 12),
                                    ),
                                    Icon(Icons.discount_rounded,
                                        color: mainColorWhite, size: 15),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Container(
                          width: getHeight(context, 12),
                          child: Text(
                            "Nutriholland number 3 ",
                            maxLines: 2,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          width: getHeight(context, 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "200,000 IQD",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: mainColorGrey,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 8),
                              ),
                              Text(
                                "100,500 IQD",
                                style: TextStyle(
                                    color: mainColorRed,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
              child: Container(
                width: getWidth(context, 100),
                height: getHeight(context, 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: CarouselSlider(
                    items: [
                      ClipRRect(
                        child: Image.asset(
                          "assets/images/100.jpg",
                          width: getWidth(context, 100),
                          height: getHeight(context, 20),
                          fit: BoxFit.fill,
                        ),
                      ),
                      Image.asset(
                        "assets/images/100.jpg",
                        width: getWidth(context, 100),
                        height: getHeight(context, 20),
                        fit: BoxFit.fill,
                      ),
                      Image.asset(
                        "assets/images/100.jpg",
                        width: getWidth(context, 100),
                        height: getHeight(context, 20),
                        fit: BoxFit.fill,
                      ),
                    ],
                    options: CarouselOptions(
                      autoPlay: true,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1.0,
                      enlargeCenterPage: true,
                      autoPlayInterval: Duration(seconds: 5),
                      autoPlayAnimationDuration: Duration(milliseconds: 3000),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Text(
                    "Best Seller",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 16,
                        fontFamily: mainFontMontserrat6),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => AllItem()),
                          );
                        },
                        child: Text(
                          "View All",
                          style: TextStyle(
                              color: mainColorRed,
                              fontSize: 14,
                              fontFamily: mainFontMontserrat4),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_outlined,
                        color: mainColorRed,
                        size: 13,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Container(
              height: getHeight(context, 22),
              decoration: BoxDecoration(),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Container(
                                  width: getHeight(context, 14),
                                  height: getHeight(context, 14),
                                  decoration: BoxDecoration(
                                      color: Color(0xffF2F2F2),
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Center(
                                    child: Image.asset(
                                      "assets/images/408.png",
                                      width: getHeight(context, 13),
                                      height: getHeight(context, 13),
                                    ),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {},
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Container(
                                        width: getHeight(context, 4),
                                        height: getHeight(context, 4),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              color: mainColorGrey
                                                  .withOpacity(0.5)),
                                        ),
                                        child: Icon(Icons.add,
                                            color: mainColorGrey,
                                            size: getHeight(context, 3))),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                                width: getHeight(context, 6),
                                height: getHeight(context, 3),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.only(
                                    //  topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                    // bottomLeft: Radius.circular(0.0),
                                    bottomRight: Radius.circular(20.0),
                                  ),
                                  color: mainColorRed,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "30\%",
                                      style: TextStyle(
                                          color: mainColorWhite,
                                          fontFamily: mainFontMontserrat4,
                                          fontSize: 12),
                                    ),
                                    Icon(Icons.discount_rounded,
                                        color: mainColorWhite, size: 15),
                                  ],
                                )),
                          ],
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Container(
                          width: getHeight(context, 12),
                          child: Text(
                            "Nutriholland number 3 ",
                            maxLines: 2,
                            style: TextStyle(
                                color: mainColorGrey,
                                fontFamily: mainFontMontserrat6,
                                fontSize: 12),
                          ),
                        ),
                        Container(
                          width: getHeight(context, 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "200,000 IQD",
                                style: TextStyle(
                                    decoration: TextDecoration.lineThrough,
                                    color: mainColorGrey,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 8),
                              ),
                              Text(
                                "100,500 IQD",
                                style: TextStyle(
                                    color: mainColorRed,
                                    fontFamily: mainFontMontserrat4,
                                    fontSize: 8),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
