import 'dart:async';

import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  String ordercode = "";
  String id = "";
  String total = "";
  String time = "";
  TrackOrder(this.ordercode, this.id, this.total, this.time);
  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

List images = [
  "assets/images/008_track_1.png",
  "assets/images/008_track_2.png",
  "assets/images/008_track_2.png",
  "assets/images/008_track_3.png",
  "assets/images/008_track_4.png",
];
List titles = [
  "Order Placed",
  "Processing Order",
  "Processing Order",
  "Order Is On way",
  "Order Ready For Pickup"
];
List content = [
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz ."
];
int status = 0;

class _TrackOrderState extends State<TrackOrder> {
  int updateStatus() {
    Network(false).getData("orderTrack/" + widget.id).then((value) {
      if (value != "") {
        if (value["code"] == "200") {
          setState(() {
            if (value["status"] == 5) {
              final productrovider =
                  Provider.of<productProvider>(context, listen: false);
              productrovider.updateOrder(int.parse(widget.id), 5);
              Navigator.pop(context);
            }
            final productrovider =
                Provider.of<productProvider>(context, listen: false);
            productrovider.updateOrder(int.parse(widget.id), status);
            status = value["status"];
            loading = true;
            return value["status"];
          });
        }
      }
    });
    return -1;
  }

  bool loading = false;
  Timer? _timer;
  @override
  void initState() {
    updateStatus();
    _startTimer();
    super.initState();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      updateStatus();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  Text(widget.time,
                      style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 20,
                        fontFamily: mainFontnormal,
                      )),
                ],
              ),
              loading
                  ? Column(
                      children: [
                        Image.asset(
                          images[status],
                          width: getWidth(context, 60),
                          height: getHeight(context, 40),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 5)),
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
                                child: status == 1 || status == 2
                                    ? LoadingIndicator(
                                        indicatorType: Indicator.ballScale,
                                        colors: [mainColorRed],
                                        strokeWidth: 5,
                                      )
                                    : status > 1 || status == 2
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
                                    ? LoadingIndicator(
                                        indicatorType: Indicator.ballScale,
                                        colors: [mainColorRed],
                                        strokeWidth: 5,
                                      )
                                    : status > 3
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
                                child: status == 4
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
                        SizedBox(
                          height: getHeight(context, 3),
                        ),
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
                    )
                  : WaitingWiget(context),
              Row(
                mainAxisAlignment: status > 0
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
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
                        addCommasToPrice(int.parse(widget.total)),
                        style: TextStyle(
                            fontSize: 18,
                            fontFamily: mainFontbold,
                            color: mainColorRed),
                      ),
                    ],
                  ),
                  loading
                      ? status > 0
                          ? SizedBox()
                          : TextButton(
                              onPressed: () {
                                Network(false)
                                    .postData("userCancel", {"oid": widget.id},
                                        context)
                                    .then((value) {
                                  if (value != "") {
                                    if (value["code"] == "201") {
                                      final productrovider =
                                          Provider.of<productProvider>(context,
                                              listen: false);
                                      productrovider.updateOrder(
                                          int.parse(widget.id), 6);
                                      Navigator.pop(context);
                                    }
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
                                fixedSize: Size(getWidth(context, 35),
                                    getHeight(context, 3)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                            )
                      : SizedBox(),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
