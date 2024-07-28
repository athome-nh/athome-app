import 'dart:async';

import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Landing/splash_screen.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/voucher/voucher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class coinReward extends StatefulWidget {
  const coinReward({super.key});

  @override
  State<coinReward> createState() => _coinRewardState();
}

class _coinRewardState extends State<coinReward> {
  bool waiting = false;
  int id = -1;
  int time = 6;
  Timer? _timer;
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time < 1) {
          time = 6;
          _timer?.cancel();
        } else {
          waiting = false;
          time--;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
            )),
        title: Text(
          "Coin & Reward".tr,
        ),
      ),
      body: Directionality(
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: productrovider.points.isEmpty
            ? Center(
                child: Text(
                  "Do not have any Voucher Code".tr,
                  style: TextStyle(
                    fontFamily: mainFontnormal,
                    fontSize: 20,
                    color: mainColorGrey,
                  ),
                ),
              )
            : ListView.builder(
                itemCount: productrovider.points.length,
                itemBuilder: (context, index) {
                  final point = productrovider.points[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      alignment: lang == "en"
                          ? Alignment.bottomRight
                          : Alignment.bottomLeft,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: mainColorGrey2),
                              borderRadius: BorderRadius.circular(15),
                              color: mainColorlightGrey),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 16, horizontal: 8),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        // voucher image
                                        Image.asset(
                                          "assets/images/Voucher.png",
                                          height: getHeight(context, 6),
                                        ),

                                        SizedBox(
                                          width: getWidth(context, 3),
                                        ),

                                        // Text
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  "IQD" + " ",
                                                  style: new TextStyle(
                                                    fontFamily: mainFontbold,
                                                    color: mainColorBlack,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  addCommasToPriceWithoutIQD(
                                                      point.price!),
                                                  style: new TextStyle(
                                                    fontFamily: mainFontbold,
                                                    color: mainColorBlack,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                                Text(
                                                  " " + "Discont",
                                                  style: new TextStyle(
                                                    fontFamily: mainFontbold,
                                                    color: mainColorBlack,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              "VALUE".tr +
                                                  ": " +
                                                  point.porint.toString() +
                                                  " " +
                                                  "Point".tr,
                                              style: TextStyle(
                                                  fontFamily: mainFontbold,
                                                  color: mainColorRed,
                                                  fontSize: 12),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    waiting && id == point.id
                                        ? Container(
                                            width: getHeight(context, 5),
                                            height: getHeight(context, 5),
                                            child: waitingWiget(context))
                                        : TextButton(
                                            style: TextButton.styleFrom(
                                              fixedSize: Size(
                                                  getWidth(context, 18),
                                                  getHeight(context, 1)),
                                            ),
                                            onPressed: userdata["point"] <
                                                        point.porint ||
                                                    (time != 6 &&
                                                        id == point.id)
                                                ? null
                                                : () {
                                                    setState(() {
                                                      waiting = true;
                                                      id = point.id!;
                                                    });
                                                    var data = {
                                                      "id": userdata["id"],
                                                      "discount": point.price,
                                                      "point": point.porint,
                                                    };
                                                    Network(false)
                                                        .postData("buy_voucher",
                                                            data, context)
                                                        .then((value) {
                                                      if (value != "") {
                                                        if (value["code"] ==
                                                            "200") {
                                                          setState(() {
                                                            productrovider.setvouchers(
                                                                (value['data']
                                                                        as List)
                                                                    .map((x) =>
                                                                        Voucher.fromMap(
                                                                            x))
                                                                    .toList());
                                                            userdata["point"] =
                                                                userdata[
                                                                        "point"] -
                                                                    point
                                                                        .porint;

                                                            _startTimer();

                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .hideCurrentSnackBar();
                                                            ScaffoldMessenger
                                                                    .of(context)
                                                                .showSnackBar(
                                                              SnackBar(
                                                                content: Text(
                                                                  "You buy voucher code ",
                                                                ),
                                                              ),
                                                            );
                                                          });
                                                        } else {
                                                          setState(() {
                                                            waiting = false;
                                                          });
                                                        }
                                                      } else {
                                                        setState(() {
                                                          waiting = false;
                                                        });
                                                      }
                                                    });
                                                  },
                                            child: Text(
                                              time != 6 && id == point.id
                                                  ? time.toString()
                                                  : "Buy Now".tr, style: TextStyle(fontSize: 10),
                                            ),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }
}
