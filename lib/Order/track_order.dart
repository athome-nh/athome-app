import 'dart:async';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Order/old_order.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/model/order_model/order_model.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';

import 'package:dllylas/Config/property.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:provider/provider.dart';

class TrackOrder extends StatefulWidget {
  int id;

  TrackOrder(this.id, {super.key});
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
  "assets/images/Order-Faild.gif",
];
late List titles;
late List content;

int status = 0;

class _TrackOrderState extends State<TrackOrder> {
  int updateStatus() {
    final pro = Provider.of<productProvider>(context, listen: false);
    pro.refreshOrderData();
    final OrderModel order = pro.getoneOrderById(widget.id);

    setState(() {
      status = order.status!;
      if (order.status! > 5) {
        status = 6;
      }
      loading = true;
    });
    return order.status!;
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
        "The Order Is Delivered",
        "Undelivered",
      ];
      content = [
        "Your order is confirmed. Thanks for shopping with us.",
        "Our team is working on your order. Updates will follow shortly.",
        "Our team is working on your order. Updates will follow shortly.",
        "Your order is on the way and will be at your doorstep soon.",
        "You can now pick up your order. The driver is waiting on your doorstep!",
        "We are pleased to inform you that your esteemed order has been delivered successfully.",
        "Unfortunately, your order wasn't delivered. Please call our customer support team.",
      ];
    } else if (lang == "ar") {
      titles = [
        "تم تثبیت الطلب",
        "قید العمل",
        "قید العمل",
        "الطلبیة قيد التوصيل",
        "الطلبیة جاهزة للاستلام",
        "تم توصيل الطلب",
        "لم يتم توصيل الطلب",
      ];
      content = [
        "تم تأكيد طلبك. شكرا لتسوقك معنا",
        "يعمل فريقنا على طلبك حاليا. يتم إرسال التحديثات إليك قريبا",
        "يعمل فريقنا على طلبك حاليا. يتم إرسال التحديثات إليك قريبا",
        "تم ارسال الطلبیة، وسيصل إلى باب بیتکم قريبا",
        "الطلب جاهز للاستلام الآن. السائق في انتظارك",
        "يسعدنا إخباركم بأن طلبكم الموقر قد تم تسليمه بنجاح",
        "نعتذر، طلبكم لم يصل، فضلا اتصلوا بدعم العملاء لحل مشكلة",
      ];
    } else {
      titles = [
        "داواکاریەکەت تۆمارکرا",
        "لە ژێر کارکردن دایە",
        "لە ژێر کارکردن دایە",
        "داواکاریەکە لە ڕێگایە ",
        "داواکاریەکە ئامادەیە بۆ وەرگرتن",
        "داواکاریەکە گەیەنرا",
        "داواکاریەکە نەگەیەنرا",
      ];
      content = [
        "داواکاریەکەت وەرگیرا. سوپاس بۆ بازاڕکردنت لەگەڵ ئێمە",
        "داواکاریەکەت کاری لەسەر دەکرێت، لەهەر نوێکاریەک بە زووترین کات ئاگادار دەکرێیتەوە",
        "داواکاریەکەت کاری لەسەر دەکرێت، لەهەر نوێکاریەک بە زووترین کات ئاگادار دەکرێیتەوە",
        "داواکاریەکە لە ڕێگایە لە زووترین کاتدا دەگاتە لات",
        "دەتوانیت داواکاریەکەتان وەربگرن. شۆفێر لەبەر دەرگایە",
        "ئاگادارتان دەکەینەوە کە داواکاری بەڕێزتان بە سەرکەوتوویی گەیشتووە.",
        "داواکاریەکەت نەگەیشت، تکایە پەیوەندی بکە بە کارمەندی بەشی خزمەتگوزاری بەشداربووان.",
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
    final pro = Provider.of<productProvider>(context, listen: false);
    final OrderModel order = pro.getoneOrderById(widget.id);
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
              },
              icon: const Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  SizedBox(
                    height: getHeight(context, 1),
                  ),
                  Text("Order".tr + " : " + widget.id.toString(),
                      style: TextStyle(
                        color: mainColorBlack,
                        fontSize: 28,
                        fontFamily: mainFontnormal,
                      )),
                  Text(convertToBaghdadTime(order.createdAt.toString()),
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
              SizedBox(
                height: getHeight(context, 2),
              ),
              Row(
                mainAxisAlignment: status > 0
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.spaceEvenly,
                children: [
                  loading
                      ? status == 0
                          ? TextButton(
                              onPressed: () {
                                yesNoOption(context);
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
                            pro.getproductitems(widget.id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      OldOrder(widget.id, true)),
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
    );
  }

  // Dialogbox
  Future<void> yesNoOption(
    BuildContext context,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, state) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ClipRect(
                child: Container(
                  width: getWidth(context, 90),
                  height: getHeight(context, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: getHeight(context, 20),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(),
                          Text(
                            "Are you sure Cancel order".tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(),
                          const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "No".tr,
                                ),
                              ),
                              TextButton(
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
                                        productrovider.refreshOrderData();

                                        Navigator.pop(context);
                                        Navigator.pop(context);
                                      }
                                    }
                                  });
                                },
                                style: TextButton.styleFrom(
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "Yes".tr,
                                ),
                              ),
                              const SizedBox(),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
