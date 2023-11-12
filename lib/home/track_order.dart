import 'dart:async';
import 'package:athome/Order/old_order.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Network/Network.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/splash_screen.dart';
import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  String id = "";
  String total = "";
  String time = "";
  TrackOrder(this.id, this.total, this.time, {super.key});
  @override
  State<TrackOrder> createState() => _TrackOrderState();
}

List images = [
  "assets/images/new_pick.gif",
  "assets/images/new_process.gif",
  "assets/images/new_process.gif",
  "assets/images/new_way.gif",
  "assets/images/new_delivered.gif",
  "assets/images/Order-Success.gif",
];
List titles = [
  "Order Placed",
  "Processing Order",
  "Processing Order",
  "Order Is On way",
  "Order Ready For Pickup",
  "Order is delivered"
];
List content = [
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is on way to deliver you jassk xcnc kz nkcxnk acs sazxz .",
  "Your order is  delivered thank you for ordering jassk xcnc kz  ."
];
int status = 0;

class _TrackOrderState extends State<TrackOrder> {
  int updateStatus() {
    Network(false).getData("orderTrack/${widget.id}").then((value) {
      print(value);
      if (value != "") {
        if (value["code"] == "200") {
          setState(() {
            if (value["status"] == 5) {
              final productrovider =
                  Provider.of<productProvider>(context, listen: false);
              productrovider.updateOrder(int.parse(widget.id), 5);
              productrovider.getDataUser(userdata["id"]);
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
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      if (status <= 5) {
        updateStatus();
      }
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
          "Track Order".tr,
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
        child: SizedBox(
          height: getHeight(context, 85),
          width: getWidth(context, 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  Text("Order:".tr + widget.id,
                      style: TextStyle(
                        color: mainColorGrey,
                        fontSize: 28,
                        fontFamily: mainFontnormal,
                      )),
                  Text(widget.time.substring(0, 19),
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
                        // gif image place and size
                        Image.asset(
                          images[status],
                          width: getWidth(context, 100),
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
                                        indicatorType:
                                            Indicator.ballSpinFadeLoader,
                                        colors: [mainColorRed],
                                        strokeWidth: 5,
                                      )
                                    : status > 0
                                        ? Icon(
                                            Icons.check_circle,
                                            color: mainColorWhite,
                                            size: getWidth(context, 5),
                                          )
                                        : const SizedBox(),
                              ),
                              SizedBox(
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
                                        indicatorType:
                                            Indicator.ballSpinFadeLoader,
                                        colors: [mainColorRed],
                                        strokeWidth: 5,
                                      )
                                    : status > 1 || status == 2
                                        ? Icon(
                                            Icons.check_circle,
                                            color: mainColorWhite,
                                            size: getWidth(context, 5),
                                          )
                                        : const SizedBox(),
                              ),
                              SizedBox(
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
                                        indicatorType:
                                            Indicator.ballSpinFadeLoader,
                                        colors: [mainColorRed],
                                        strokeWidth: 5,
                                      )
                                    : status > 3
                                        ? Icon(
                                            Icons.check_circle,
                                            color: mainColorWhite,
                                            size: getWidth(context, 5),
                                          )
                                        : const SizedBox(),
                              ),
                              SizedBox(
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
                                child: status == 4 || status == 5
                                    ? Icon(
                                        Icons.check_circle,
                                        color: mainColorWhite,
                                        size: getWidth(context, 5),
                                      )
                                    : const SizedBox(),
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
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 10)),
                          child: Text(
                            content[status],
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: mainColorGrey,
                              fontSize: 16,
                              fontFamily: mainFontnormal,
                            ),
                          ),
                        ),
                      ],
                    )
                  : WaitingWiget(context),
              Row(
                mainAxisAlignment: status > 0
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  loading
                      ? status > 0
                          ? const SizedBox()
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
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColorLightGrey,
                                fixedSize: Size(getWidth(context, 35),
                                    getHeight(context, 3)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                              ),
                              child: Text("Cancle order".tr,
                                  style: TextStyle(
                                    color: mainColorGrey,
                                    fontSize: 16,
                                    fontFamily: mainFontnormal,
                                  )),
                            )
                      : const SizedBox(),
                  loading
                      ? TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OldOrder(widget.id,
                                      widget.total, widget.time, status)),
                            );
                          },
                          child: Text('View order',
                              style: TextStyle(
                                color: mainColorWhite,
                                fontSize: 16,
                                fontFamily: mainFontnormal,
                              )),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: mainColorGrey,
                            fixedSize: Size(
                                getWidth(context, 35), getHeight(context, 3)),
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
