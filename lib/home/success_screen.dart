import 'package:DllyLas/Config/property.dart';
import 'package:DllyLas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key});

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  Widget build(BuildContext context) {
    
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        body: Container(
          height: getHeight(context, 100),
          color: mainColorWhite,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Victors/sendorder.png",
                  width: getWidth(context, 50),
                  height: getWidth(context, 50),
                ),
                Text("Thank You!".tr,
                    style: TextStyle(
                      fontSize: 24,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                    )),
                Text("for yor order".tr,
                    style: TextStyle(
                      fontSize: 16,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                    )),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Order Number:".tr,
                      style: TextStyle(
                          fontSize: 16,
                          color: mainColorBlack,
                          fontFamily: mainFontbold),
                    ),
                    Text(
                      "3333",
                      style: TextStyle(
                          fontSize: 16,
                          color: mainColorRed,
                          fontFamily: mainFontbold),
                    ),
                  ],
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
                  child: Text(
                    "YourOrderIsNowBeingProcessed".tr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: mainColorBlack,
                      fontFamily: mainFontnormal,
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: getWidth(context, 4),
                  ),
                  child: TextButton(
                    onPressed: () {
                      // cartProvider.clearCart();

                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => TrackOrder(
                      //           value["id"].toString(),
                      //           value["total"].toString(),
                      //           value["time"].toString())),
                      // ).then((value) {
                      //   cartProvider.clearCart();
                      //   Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) => const NavSwitch()),
                      //   );
                      // });
                    },
                    style: TextButton.styleFrom(
                      fixedSize:
                          Size(getWidth(context, 85), getHeight(context, 6)),
                    ),
                    child: Text(
                      "Track My Order".tr,
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 2),
                ),
                TextButton(
                  onPressed: () {
                    // cartProvider.clearCart();

                    // Navigator.pushReplacement(
                    //   context,
                    //   MaterialPageRoute(
                    //       builder: (context) => const NavSwitch()),
                    // );
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: mainColorRed,
                    fixedSize:
                        Size(getWidth(context, 85), getHeight(context, 6)),
                  ),
                  child: Text(
                    "Back to Home".tr,
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 5),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
