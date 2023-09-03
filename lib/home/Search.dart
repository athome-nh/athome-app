import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'package:athome/configuration.dart';
import 'package:athome/home/AllItem.dart';


class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: mainColorWhite,
     
      body: SafeArea(
        child: Padding(
          padding:  EdgeInsets.only(top:getHeight(context, 3)),
          child: SingleChildScrollView(
            child: Column(children: [
             Center(
                      child: Container(
                        width: getWidth(context, 95),
                        height: getHeight(context, 5),
                        decoration: BoxDecoration(
                            color: Color(0xffF2F2F2),
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 4)),
                              child: Icon(
                                Ionicons.search_outline,
                                color: mainColorGrey.withOpacity(0.45),
                                size: 30,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: TextField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: mainColorGrey.withOpacity(0.45),
                                      fontFamily: mainFontMontserrat4),
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: "Search",
                                      hintStyle: TextStyle(color: mainColorGrey.withOpacity(0.45))),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                        SizedBox(
                          height: getHeight(context, 2),
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
            ],),
          ),
        ),
      ),
    );
  }
}