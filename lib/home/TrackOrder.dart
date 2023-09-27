import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TrackOrder extends StatefulWidget {
  const TrackOrder({super.key});

  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Track Order",
          style: TextStyle(
              color: mainColorGrey,
              fontFamily: mainFontMontserrat4,
              fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: mainColorWhite,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColorRed,
            )),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: getHeight(context, 85),
          width: getWidth(context, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text(
                    "Order #678678",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 28,
                        fontFamily: mainFontMontserrat4),
                  ),
                  Text(
                    "Mon,24 Oct 2023",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 20,
                        fontFamily: mainFontMontserrat4),
                  ),
                ],
              ),
              Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: "assets/images/003_welcome_1.png",
                    width: getWidth(context, 60),
                    height: getHeight(context, 40),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Icon(
                          Icons.circle,
                          color: mainColorRed,
                          size: 30,
                        ),
                        Container(
                            width: getWidth(context, 18),
                            child: Divider(
                              color: mainColorGrey,
                              thickness: 3,
                            )),
                        Icon(
                          Icons.circle_outlined,
                          color: mainColorRed,
                          size: 30,
                        ),
                        Container(
                            width: getWidth(context, 18),
                            child: Divider(
                              color: mainColorGrey,
                              thickness: 3,
                            )),
                        Icon(
                          Icons.circle_outlined,
                          color: mainColorRed,
                          size: 30,
                        ),
                        Container(
                            width: getWidth(context, 18),
                            child: Divider(
                              color: mainColorGrey,
                              thickness: 3,
                            )),
                        Icon(
                          Icons.circle_outlined,
                          color: mainColorRed,
                          size: 30,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(
                    "Order Placed",
                    style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 28,
                        fontFamily: mainFontMontserrat4),
                  ),
                  Container(
                    width: getWidth(context, 70),
                    child: Text(
                      "Your order is on way to delvier you jdsncjndscjkndkcnkdsjnc",
                      style: TextStyle(
                          color: mainColorGrey,
                          fontSize: 16,
                          fontFamily: mainFontMontserrat4),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: mainFontMontserrat4,
                            color: mainColorGrey),
                      ),
                      Row(
                        children: [
                          Text(
                            "3000",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: mainFontMontserrat8,
                                color: mainColorRed),
                          ),
                          SizedBox(
                            width: getWidth(context, 1),
                          ),
                          Text(
                            "IQD",
                            style: TextStyle(
                                fontSize: 18,
                                fontFamily: mainFontMontserrat8,
                                color: mainColorGrey),
                          ),
                        ],
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'Cancle order',
                      style: TextStyle(
                          color: mainColorGrey,
                          fontSize: 16,
                          fontFamily: mainFontMontserrat4),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: mainColorLightGrey,
                      fixedSize:
                          Size(getWidth(context, 35), getHeight(context, 3)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
