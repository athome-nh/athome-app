import 'package:athome/Config/athome_functions.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  String ordercode = "";
  TrackOrder(this.ordercode);
  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

List images = [
  "assets/images/008_track_1.png",
  "assets/images/008_track_2.png",
  "assets/images/008_track_3.png",
  "assets/images/008_track_4.png",
];
List titles = [
  "Order Placed",
  "Processing Order",
  "Order Is On way",
  "Order Ready For Pickup"
];
List content = [
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz ."
];
int status = 0;

class _TrackOrderState extends State<TrackOrder> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Track Order",
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
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
                  Text("Order: " + widget.ordercode,
                      style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 28,
                        fontFamily: mainFontnormal,
                      )),
                  Text("Mon,24 Oct 2023",
                      style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 20,
                        fontFamily: mainFontnormal,
                      )),
                ],
              ),
              Column(
                children: [
                  Image.asset(
                    images[status],
                    width: getWidth(context, 60),
                    height: getHeight(context, 40),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: getWidth(context, 5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: getWidth(context, 8),
                          height: getWidth(context, 8),
                          decoration: BoxDecoration(
                            color: mainColorGrey,
                            shape: BoxShape.circle,
                          ),
                          child: status == 0
                              ? LoadingIndicator(
                                  indicatorType: Indicator.ballScale,
                                  colors: [mainColorRed],
                                  strokeWidth: 5,
                                )
                              : status > 0
                                  ? Icon(
                                      Icons.check_circle,
                                      color: mainColorWhite,
                                      size: getWidth(context, 5),
                                    )
                                  : SizedBox(),
                        ),
                        Container(
                            width: getWidth(context, 18),
                            child: Divider(
                              color: mainColorGrey,
                              thickness: 3,
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: getWidth(context, 8),
                          height: getWidth(context, 8),
                          decoration: BoxDecoration(
                            color: mainColorGrey,
                            shape: BoxShape.circle,
                          ),
                          child: status == 1
                              ? LoadingIndicator(
                                  indicatorType: Indicator.ballScale,
                                  colors: [mainColorRed],
                                  strokeWidth: 5,
                                )
                              : status > 1
                                  ? Icon(
                                      Icons.check_circle,
                                      color: mainColorWhite,
                                      size: getWidth(context, 5),
                                    )
                                  : SizedBox(),
                        ),
                        Container(
                            width: getWidth(context, 18),
                            child: Divider(
                              color: mainColorGrey,
                              thickness: 3,
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: getWidth(context, 8),
                          height: getWidth(context, 8),
                          decoration: BoxDecoration(
                            color: mainColorGrey,
                            shape: BoxShape.circle,
                          ),
                          child: status == 2
                              ? LoadingIndicator(
                                  indicatorType: Indicator.ballScale,
                                  colors: [mainColorRed],
                                  strokeWidth: 5,
                                )
                              : status > 2
                                  ? Icon(
                                      Icons.check_circle,
                                      color: mainColorWhite,
                                      size: getWidth(context, 5),
                                    )
                                  : SizedBox(),
                        ),
                        Container(
                            width: getWidth(context, 18),
                            child: Divider(
                              color: mainColorGrey,
                              thickness: 3,
                            )),
                        Container(
                          alignment: Alignment.center,
                          width: getWidth(context, 8),
                          height: getWidth(context, 8),
                          decoration: BoxDecoration(
                            color: mainColorGrey,
                            shape: BoxShape.circle,
                          ),
                          child: status == 3
                              ? Icon(
                                  Icons.check_circle,
                                  color: mainColorWhite,
                                  size: getWidth(context, 5),
                                )
                              : SizedBox(),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text(titles[status],
                      style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 28,
                        fontFamily: mainFontnormal,
                      )),
                  Container(
                    width: getWidth(context, 70),
                    child: Text(content[status],
                        style: TextStyle(
                          color: mainColorGrey,
                          fontSize: 16,
                          fontFamily: mainFontnormal,
                        )),
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
                            fontFamily: mainFontnormal,
                            color: mainColorGrey),
                      ),
                      Text(
                        addCommasToPrice(productrovider
                            .calculateTotalPriceOrder(widget.ordercode)),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: mainFontbold,
                            color: mainColorRed),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        if (status == 3) {
                          status = 0;
                        } else {
                          status++;
                        }
                      });
                    },
                    child: Text('Cancle order',
                        style: TextStyle(
                          color: mainColorGrey,
                          fontSize: 16,
                          fontFamily: mainFontnormal,
                        )),
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
