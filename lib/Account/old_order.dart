import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/model/order_items/order_items.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Old_Order extends StatefulWidget {
  String ordercode = "";
  String id = "";
  String total = "";
  String time = "";
  Old_Order(this.ordercode, this.id, this.total, this.time, {super.key});
  @override
  State<Old_Order> createState() => _Old_OrderState();
}

class _Old_OrderState extends State<Old_Order> {
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
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
                                              ? product.nameEn.toString()
                                              : lang == "ar"
                                                  ? product.nameAr.toString()
                                                  : product.nameKu.toString(),
                                          maxLines: 2,
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: mainFontbold,
                                              fontSize: 14),
                                        ),
                                        Text(
                                          lang == "en"
                                              ? product.contentsEn.toString()
                                              : lang == "ar"
                                                  ? product.contentsAr
                                                      .toString()
                                                  : product.contentsKu
                                                      .toString(),
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
                                                : SizedBox(),
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
                                              "Ordered: ",
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
                                              "Delivered:",
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
            )
          ],
        ),
      ),
    );
  }
}
