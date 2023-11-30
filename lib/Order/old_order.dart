import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/model/order_items/order_items.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class OldOrder extends StatefulWidget {
  String id = "";
  String total = "";
  String time = "";
  int status = 0;

  OldOrder(this.id, this.total, this.time, this.status, {super.key});
  @override
  State<OldOrder> createState() => _OldOrderState();
}

class _OldOrderState extends State<OldOrder> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    List<OrderItems> items = productrovider.getordersbyOrderId(widget.id);
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        backgroundColor: mainColorWhite,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: mainColorRed,
            )),
        elevation: 0.5,
        title: Image.asset(
          "assets/images/logoB.png",
          width: getWidth(context, 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: (productrovider.productitems.isEmpty)
            ? Center(child: waitingWiget(context))
            : ListView.builder(
                itemCount: items.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = items[index];

                  return Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            left: getWidth(context, 2),
                            right: getWidth(context, 4)),
                        child: Row(
                          children: [
                            Container(
                              width: getWidth(context, 20),
                              height: getWidth(context, 20),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: mainColorBlack.withOpacity(0.1)),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: imageUrlServer +
                                      productrovider
                                          .getoneProductItemsById(
                                              items[index].productId!)
                                          .coverImg!,
                                  width: getWidth(context, 15),
                                  height: getWidth(context, 15),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(context, 2),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SizedBox(
                                  width: getWidth(context, 40),
                                  child: Text(
                                    lang == "en"
                                        ? productrovider
                                            .getoneProductItemsById(
                                                items[index].productId!)
                                            .nameEn!
                                        : lang == "ar"
                                            ? productrovider
                                                .getoneProductItemsById(
                                                    items[index].productId!)
                                                .nameAR
                                                .toString()
                                            : productrovider
                                                .getoneProductItemsById(
                                                    items[index].productId!)
                                                .nameKU!,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorGrey,
                                        fontFamily: mainFontbold,
                                        fontSize: 14),
                                  ),
                                ),
                                SizedBox(
                                  height: getHeight(context, 1),
                                ),
                                SizedBox(
                                  width: getWidth(context, 40),
                                  child: Text(
                                    lang == "en"
                                        ? productrovider
                                            .getoneProductItemsById(
                                                items[index].productId!)
                                            .contentsEn!
                                        : lang == "ar"
                                            ? productrovider
                                                .getoneProductItemsById(
                                                    items[index].productId!)
                                                .contentsAR!
                                            : productrovider
                                                .getoneProductItemsById(
                                                    items[index].productId!)
                                                .contentsKU!,
                                    textAlign: TextAlign.start,
                                    maxLines: 1,
                                    style: TextStyle(
                                        color: mainColorGrey.withOpacity(0.5),
                                        fontFamily: mainFontbold,
                                        fontSize: 11),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Quantity: ".tr,
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontFamily: mainFontnormal,
                                          fontSize: 14),
                                    ),
                                    Text(
                                      item.pickedQt == 0
                                          ? item.qt.toString()
                                          : (item.pickedQt! - item.returnedQt!)
                                              .toString(),
                                      style: TextStyle(
                                          color: mainColorGrey,
                                          fontFamily: mainFontnormal,
                                          fontSize: 16),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const Spacer(),
                            Text(
                              addCommasToPrice(item.sellPrice!),
                              maxLines: 1,
                              style: TextStyle(
                                  decoration: TextDecoration.none,
                                  color: Colors.green,
                                  fontFamily: mainFontbold,
                                  fontSize: 14),
                            ),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  );
                }),
      ),
      bottomNavigationBar: Container(
        height: getHeight(context, 30),
        decoration: BoxDecoration(
          color: mainColorWhite,
          // borderRadius: const BorderRadius.only(
          //   topLeft: Radius.circular(25),
          //   topRight: Radius.circular(25),
          // ),
        ),
        child: Column(
          children: [
            SizedBox(
              height: getHeight(context, 3),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child: Text(
                widget.status == 0
                    ? "Order Placed".tr
                    : (widget.status == 1 || widget.status == 2)
                        ? "Processing Order".tr
                        : widget.status == 3
                            ? "Order Is On way".tr
                            : widget.status == 4
                                ? "Order Ready For Pickup".tr
                                : widget.status == 5
                                    ? "Order is delivered".tr
                                    : "Undelivered".tr,
                style: TextStyle(
                    color: widget.status < 5
                        ? mainColorGrey
                        : widget.status > 5
                            ? mainColorRed
                            : Colors.green,
                    fontFamily: mainFontbold,
                    fontSize: 18),
              ),
            ),
            SizedBox(
              height: getHeight(context, 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Date and Time".tr,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    widget.time.substring(0, 16),
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context, 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Order No.".tr,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    widget.id,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context, 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Sub Total".tr,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    addCommasToPrice(int.parse(widget.total)),
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: getHeight(context, 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Delivery Cost".tr,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontnormal,
                        fontSize: 16),
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    "Free Delivery".tr,
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: mainFontnormal,
                        fontSize: 14),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child:
                  Divider(color: mainColorGrey.withOpacity(0.2), thickness: 1),
            ),
            SizedBox(
              height: getHeight(context, 1),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 4)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    textAlign: TextAlign.start,
                    "Total".tr,
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontbold,
                        fontSize: 20),
                  ),
                  Text(
                    textAlign: TextAlign.end,
                    addCommasToPrice(int.parse(widget.total)),
                    style: TextStyle(
                        color: mainColorGrey,
                        fontFamily: mainFontbold,
                        fontSize: 20),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}