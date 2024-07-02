import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class coinReward extends StatefulWidget {
  const coinReward({super.key});

  @override
  State<coinReward> createState() => _coinRewardState();
}

class _coinRewardState extends State<coinReward> {
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                "Voucher Codes".tr,
                style: TextStyle(fontSize: 20, fontFamily: mainFontbold),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: getHeight(context, 100),
              child: ListView.builder(
                itemCount: productrovider.points.length,
                itemBuilder: (context, index) {
                  final point = productrovider.points[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: getHeight(context, 17),
                      decoration: BoxDecoration(
                          border: Border.all(
                              color: mainColorBlack.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(15)),
                      child: Column(
                        children: [
                          Container(
                            width: getWidth(context, 100),
                            height: getHeight(context, 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0),
                                ),
                                color: mainColorGrey),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Image.asset(
                                  "assets/images/App-Icon.png",
                                  height: 50,
                                ),
                                Text(
                                  "STARBUCKS".tr,
                                  style: TextStyle(
                                      color: mainColorWhite, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: new TextSpan(
                                        style: new TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black,
                                        ),
                                        children: <TextSpan>[
                                          new TextSpan(
                                            text:
                                                addCommasToPrice(point.price!),
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.green,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: mainFontnormal),
                                          ),
                                          new TextSpan(
                                            text: " " + "OFF".tr,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: mainColorRed,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: mainFontnormal),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "VALUE".tr + ": " + 
                                      point.porint.toString() + 
                                      " " + "Point".tr,
                                      style: TextStyle(
                                          fontFamily: mainFontbold,
                                          color: mainColorBlack,
                                          fontSize: 12),
                                    ),
                                  ],
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: mainColorGrey,
                                    ),
                                    onPressed: () {},
                                    child: Text("Buy Now".tr))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
