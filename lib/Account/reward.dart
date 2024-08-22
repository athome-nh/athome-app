// Import necessary packages and libraries
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

/// `coinReward` widget manages coin and reward system for the user.
/// Users can view and purchase vouchers using accumulated points.
class coinReward extends StatefulWidget {
  const coinReward({super.key});

  @override
  State<coinReward> createState() => _coinRewardState();
}

class _coinRewardState extends State<coinReward> {
  bool waiting = false; // Indicates if the user is waiting after pressing 'Buy Now'
  int id = -1; // Stores the ID of the selected voucher
  int time = 6; // Countdown timer for purchasing process
  Timer? _timer; // Timer instance to handle the countdown

  @override
  void dispose() {
    // Clean up the timer when the widget is disposed of
    _timer?.cancel();
    super.dispose();
  }

  /// Starts the countdown timer for handling purchase cooldowns.
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (time < 1) {
          // Reset timer and stop it once countdown ends
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
    // Access product provider to fetch the user's available points and vouchers
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
          "Coin & Reward".tr, // Translated title
        ),
      ),
      body: Directionality(
        textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
        child: 
        // Check if the user has any points available
        ListView.builder(
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
                                        // Voucher image
                                        Image.asset(
                                          "assets/images/Voucher.png",
                                          height: getHeight(context, 6),
                                        ),

                                        SizedBox(
                                          width: getWidth(context, 3),
                                        ),

                                        // Text section showing discount and point details
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                // Display discount information
                                                Text(
                                                  "Discont".tr + " ",
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
                                                  " " + "IQD".tr,
                                                  style: new TextStyle(
                                                    fontFamily: mainFontbold,
                                                    color: mainColorBlack,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            // Display points required for voucher
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
                                    // Show waiting widget if user has initiated a purchase
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
                                                    // Start purchase process
                                                    setState(() {
                                                      waiting = true;
                                                      id = point.id!;
                                                    });
                                                    var data = {
                                                      "id": userdata["id"],
                                                      "discount": point.price,
                                                      "point": point.porint,
                                                    };
                                                    // Send data to backend for voucher purchase
                                                    Network(false)
                                                        .postData("buy_voucher",
                                                            data, context)
                                                        .then((value) {
                                                      if (value != "") {
                                                        if (value["code"] ==
                                                            "200") {
                                                          setState(() {
                                                            // Update vouchers and user points
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
                                            // Show countdown timer or 'Buy Now' button text
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
