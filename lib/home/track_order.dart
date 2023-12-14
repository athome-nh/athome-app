import 'dart:async';
import 'package:DllyLas/Order/old_order.dart';
import 'package:DllyLas/Config/my_widget.dart';
import 'package:DllyLas/Network/Network.dart';
import 'package:DllyLas/controller/productprovider.dart';
import 'package:DllyLas/landing/splash_screen.dart';
import 'package:DllyLas/main.dart';
import 'package:flutter/material.dart';

import 'package:DllyLas/Config/property.dart';
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
  "assets/images/Order-Success.gif",
];
late List titles;
late List content;

int status = 0;

class _TrackOrderState extends State<TrackOrder> {
  int updateStatus() {
    Network(false).getData("orderTrack/${widget.id}").then((value) {
      if (value != "") {
        if (value["code"] == "200") {
          setState(() {
            if (value["status"] == 5) {
              final productrovider =
                  Provider.of<productProvider>(context, listen: false);
              productrovider.getDataUser(userdata["id"].toString());
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
    if (lang == "en") {
      titles = [
        "Order Placed",
        "Processing Order",
        "Processing Order",
        "Order Is On way",
        "Order Ready For Pickup",
        "The Order Is Delivered"
      ];
      content = [
        "Great choice! Your order is confirmed. Thanks for shopping with us.",
        "Our team is working on your order. Updates will follow shortly.",
        "Our team is working on your order. Updates will follow shortly.",
        "Your order is in transit and will be at your doorstep soon.",
        "You can now pick up your order. The driver is waiting on your doorstep!",
      ];
    } else if (lang == "ar") {
      titles = [
        "تم التثبیت الطلب",
        "قید العمل",
        "قید العمل",
        "الطلبیة قيد التوصيل",
        "الطلبیة جاهز للاستلام",
        "تم توصيل الطلب"
      ];
      content = [
        "اختيار رائع! تم تأكيد طلبك. شكرًا لتسوقك معنا",
        "يُعمل فريقنا على طلبك حاليًا. يتم إرسال التحديثات إليك قريبًا",
        "يُعمل فريقنا على طلبك حاليًا. يتم إرسال التحديثات إليك قريبًا",
        "تم الشحن الطلبیة، وسيصل إلى باب بیتکم قريبًا",
        "الطلب جاهز للاستلام الآن. السائق في انتظارك",
      ];
    } else {
      titles = [
        "داواکاریەکەت تۆمارکرا",
        "لە ژێر کارکردن دایە",
        "لە ژێر کارکردن دایە",
        "داواکاریەکە لە ڕێگایە ",
        "داواکاریەکە ئامادەیە بۆ وەرگرتن",
        "داواکاریەکە گەیەنرا"
      ];
      content = [
        "داواکاریەکی دروست! ، داواکاریەکەت وەرگیرا. سوپاس بۆ بازاڕکردنت لەگەڵ ئێمە",
        "داواکاریەکەت کاری لەسەر دەکرێت، لەهەر نوێکاریەک بە زووترین کات ئاگادار دەکرێیتەوە",
        "داواکاریەکەت کاری لەسەر دەکرێت، لەهەر نوێکاریەک بە زووترین کات ئاگادار دەکرێیتەوە",
        "داواکاریەکە لە ڕێگایە لە زووترین کاتدا دەگاتە لات",
        "دەتوانیت داواکاریەکەتان وەربگرن. شۆفێر لەبەر دەرگایە",
      ];
    }
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
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Track Order".tr,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
                Provider.of<productProvider>(context, listen: false)
                    .getDataUser(userdata["id"].toString());
              },
              icon: Icon(
                Icons.arrow_back_ios,
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
                          color: mainColorBlack,
                          fontSize: 28,
                          fontFamily: mainFontnormal,
                        )),
                    Text(widget.time.substring(0, 19),
                        style: TextStyle(
                          color: mainColorBlack,
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
                                          colors: [mainColorWhite],
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
                                          colors: [mainColorWhite],
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
                                          colors: [mainColorWhite],
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
                                color: mainColorBlack,
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
                                color: mainColorBlack,
                                fontSize: 16,
                                fontFamily: mainFontnormal,
                              ),
                            ),
                          ),
                        ],
                      )
                    : waitingWiget(context),
                Row(
                  mainAxisAlignment: status > 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.spaceEvenly,
                  children: [
                    loading
                        ? status == 0
                            ? TextButton(
                                onPressed: () {
                                  Network(false)
                                      .postData("userCancel",
                                          {"oid": widget.id}, context)
                                      .then((value) {
                                    if (value != "") {
                                      if (value["code"] == "201") {
                                        final productrovider =
                                            Provider.of<productProvider>(
                                                context,
                                                listen: false);
                                        productrovider.getDataUser(
                                            userdata["id"].toString());
                                        Navigator.pop(context);
                                      }
                                    }
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: mainColorRed,
                                  fixedSize: Size(getWidth(context, 35),
                                      getHeight(context, 3)),
                                ),
                                child: Text(
                                  "Cancel order".tr,
                                ),
                              )
                            : const SizedBox()
                        : const SizedBox(),
                    loading
                        ? TextButton(
                            onPressed: () {
                              Provider.of<productProvider>(context,
                                      listen: false)
                                  .getproductitems(int.parse(widget.id));
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OldOrder(widget.id,
                                        widget.total, widget.time, status)),
                              );
                            },
                            style: TextButton.styleFrom(
                              fixedSize: Size(
                                  getWidth(context, 35), getHeight(context, 3)),
                            ),
                            child: Text(
                              "View order".tr,
                            ),
                          )
                        : const SizedBox(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
