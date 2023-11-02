import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/model/order_items/order_items.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/my_widget.dart';

class OldOrder extends StatefulWidget {
  String ordercode = "";
  String id = "";
  String total = "";
  String time = "";
  OldOrder(this.ordercode, this.id, this.total, this.time, {super.key});
  @override
  State<OldOrder> createState() => _OldOrderState();
}

class _OldOrderState extends State<OldOrder> {
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    List<OrderItems> items =
        productrovider.getordersbyOrderCode(widget.ordercode);
    return Scaffold(
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
      body: Column(
        children: [
          Expanded(
            flex: 7,
            child: SizedBox(
              height: getHeight(context, 100),
              child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int index) {
                    final product = productrovider
                        .getoneProductById(items[index].productId!);
                    final item = items[index];
                    return Center(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Container(
                          width: getWidth(context, 100),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5)),
                          child: Padding(
                            padding: EdgeInsets.all(getWidth(context, 2)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: getWidth(context, 20),
                                      height: getWidth(context, 20),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF2F2F2),
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Center(
                                        child: CachedNetworkImage(
                                          imageUrl: product.coverImg.toString(),
                                          width: getWidth(context, 17),
                                          height: getWidth(context, 17),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getWidth(context, 2),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          lang == "en"
                                              ? textCount(product.nameEn.toString(),20)
                                              : lang == "ar"
                                                  ? textCount(product.nameAr.toString(),30)
                                                  : textCount(product.nameKu.toString(),30),
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: mainFontbold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          lang == "en"
                                              ? textCount(product.contentsEn.toString(),20)
                                              : lang == "ar"
                                                  ? textCount(product.contentsAr.toString(),30)
                                                  : textCount(product.contentsKu.toString(),30),
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: mainFontnormal,
                                              fontSize: 12),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${item.sellPrice!} IQD",
                                              style: TextStyle(
                                                  decoration:
                                                      item.offerPrice! > -1
                                                          ? TextDecoration
                                                              .lineThrough
                                                          : TextDecoration.none,
                                                  color: mainColorGrey,
                                                  fontFamily: mainFontbold,
                                                  fontSize: 10),
                                            ),
                                            item.offerPrice! > -1
                                                ? SizedBox(
                                                    width: getWidth(context, 2),
                                                  )
                                                : const SizedBox(),
                                            item.offerPrice! > -1
                                                ? Text(
                                                    "${item.offerPrice!} IQD",
                                                    style: TextStyle(
                                                        color: mainColorRed,
                                                        fontFamily:
                                                            mainFontbold,
                                                        fontSize: 10),
                                                  )
                                                : const SizedBox(),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "Ordered:".tr,
                                              style: TextStyle(
                                                fontFamily: mainFontnormal,
                                                color: mainColorGrey,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              item.qt.toString(),
                                              style: TextStyle(
                                                fontFamily: mainFontbold,
                                                color: mainColorBlack,
                                                fontSize: 12,
                                              ),
                                            ),
                                            SizedBox(
                                              width: getWidth(context, 2),
                                            ),
                                            Text(
                                              "Delivered:".tr,
                                              style: TextStyle(
                                                fontFamily: mainFontnormal,
                                                color: mainColorGrey,
                                                fontSize: 12,
                                              ),
                                            ),
                                            Text(
                                              item.pickedQt.toString(),
                                              style: TextStyle(
                                                fontFamily: mainFontbold,
                                                color: mainColorGrey,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
        
          Expanded(
                  flex: 3,
                  child: Container(
                    height: getWidth(context, 60),
                    decoration: BoxDecoration(
                      color: mainColorGrey,
                      borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(25),
                          topRight: Radius.circular(25)),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(context, 2),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total".tr,
                                style: TextStyle(
                                    color: mainColorWhite,
                                    fontFamily: mainFontbold,
                                    fontSize: 16),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                addCommasToPrice(0),
                                style: TextStyle(
                                    color: mainColorWhite,
                                    fontFamily: mainFontbold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Delivery Cost".tr,
                                style: TextStyle(
                                    color: mainColorWhite,
                                    fontFamily: mainFontbold,
                                    fontSize: 16),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                "Free Delivery".tr,
                                style: TextStyle(
                                    color: mainColorWhite,
                                    fontFamily: mainFontbold,
                                    fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Divider(
                              color: mainColorWhite.withOpacity(0.2),
                              thickness: 1),
                        ),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                textAlign: TextAlign.start,
                                "Total".tr,
                                style: TextStyle(
                                    color: mainColorWhite,
                                    fontFamily: mainFontbold,
                                    fontSize: 16),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                addCommasToPrice(0),
                                style: TextStyle(
                                    color: mainColorRed,
                                    fontFamily: mainFontbold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: getHeight(context, 3),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  if (await noInternet(context)) {
                                    return;
                                  }

                                  // ignore: use_build_context_synchronously
                                  showModalBottomSheet(
                                    context: context,
                                    isDismissible: true,
                                    shape: const RoundedRectangleBorder(
                                      // <-- SEE HERE
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(25.0),
                                      ),
                                    ),
                                    builder: (BuildContext context) {
                                      return Container(
                                        color: mainColorWhite,
                                        child: Column(
                                          children: <Widget>[
                                            Container(
                                              padding: EdgeInsets.only(
                                                top: getWidth(context, 2),
                                                left: getWidth(context, 2),
                                                right: getWidth(context, 2),
                                                bottom: getWidth(context, 1),
                                              ),
                                              margin:
                                                  const EdgeInsets.all(8.0),
                                              height: getWidth(context, 10),
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: mainColorGrey
                                                    .withOpacity(0.5),
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Select Location".tr,
                                                  style: TextStyle(
                                                    color: mainColorWhite,
                                                    fontSize: 20,
                                                    fontFamily:
                                                        mainFontnormal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: getHeight(context, 40),
                                              child: Padding(
                                                padding:const EdgeInsets.all(8.0),
                                                child: productrovider.location.isNotEmpty
                                                    ? ListView.builder(
                                                        itemCount:productrovider.location.length,
                                                        itemBuilder:
                                                            (BuildContext
                                                                    context,
                                                                int index) {
                                                          final location =
                                                              productrovider
                                                                      .location[
                                                                  index];
                                                          return Padding(
                                                            padding: EdgeInsets.only(
                                                                bottom:
                                                                    getHeight(
                                                                        context,
                                                                        1)),
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                // cartProvider.addPastToCart(
                                                                //     cartProvider
                                                                //         .cartItemsPast);

                                                                // Navigator
                                                                //     .push(
                                                                //   context,
                                                                //   MaterialPageRoute(
                                                                //       builder:
                                                                //           (context) =>
                                                                //               CheckOut(id: location.id!)),
                                                                // ).then(
                                                                //     (value) {
                                                                //   cartProvider
                                                                //       .clearCart();
                                                                // });
                                                              },
                                                              child:
                                                                  Container(
                                                                decoration: BoxDecoration(
                                                                    color:
                                                                        mainColorLightGrey,
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            5)),
                                                                child:
                                                                    ListTile(
                                                                  title: Text(
                                                                    location
                                                                        .name!,
                                                                    style: TextStyle(
                                                                        color:
                                                                            mainColorGrey,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            mainFontbold),
                                                                  ),
                                                                  subtitle:
                                                                      Text(
                                                                    location
                                                                        .area!,
                                                                    style: TextStyle(
                                                                        color:
                                                                            mainColorGrey,
                                                                        fontSize:
                                                                            14,
                                                                        fontFamily:
                                                                            mainFontnormal),
                                                                  ),
                                                                  trailing:
                                                                      Text(
                                                                    "Select",
                                                                    style: TextStyle(
                                                                        color:
                                                                            mainColorRed,
                                                                        fontFamily:
                                                                            mainFontnormal),
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          );
                                                        })
                                                    : Center(
                                                        child: Text(
                                                        "Not have any location".tr,
                                                        style: TextStyle(
                                                          color:
                                                              mainColorGrey,
                                                          fontSize: 20,
                                                        ),
                                                      )),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      getWidth(context, 4)),
                                              child: TextButton(
                                                onPressed: () {
                                                  // Navigator.pop(context);
                                                  // Navigator.push(
                                                  //   context,
                                                  //   MaterialPageRoute(
                                                  //       builder: (context) =>
                                                  //           const Maps_screen()),
                                                  // );
                                                },
                                                style:
                                                    ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      mainColorRed,
                                                  fixedSize: Size(
                                                      getWidth(context, 85),
                                                      getHeight(context, 6)),
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                ),
                                                child: Text(
                                                  "Add another location".tr,
                                                  style: TextStyle(
                                                    color: mainColorWhite,
                                                    fontSize: 16,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColorRed,
                                  fixedSize: Size(getWidth(context, 40),
                                      getHeight(context, 6)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  "Re Order".tr,
                                  style: TextStyle(
                                    color: mainColorWhite,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              TextButton(
                                onPressed: () async {
                                  if (await noInternet(context)) {
                                    return;
                                  }

                                  // cartProvider.addPastToCart(
                                  //     cartProvider.cartItemsPast);
                                  // Navigator.push(
                                  //   context,
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           const NavSwitch()),
                                  // );
                                  // cartProvider.clearCartPast();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColorRed,
                                  fixedSize: Size(getWidth(context, 40),
                                      getHeight(context, 6)),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                                child: Text(
                                  "Add More Items".tr,
                                  style: TextStyle(
                                    color: mainColorWhite,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}