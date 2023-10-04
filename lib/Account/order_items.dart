import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/NavSwitch.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';
import 'package:athome/Home/CheckOut.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../Config/athome_functions.dart';
import '../main.dart';

class oreder_items extends StatefulWidget {
  const oreder_items({super.key});

  @override
  State<oreder_items> createState() => _oreder_itemsState();
}

class _oreder_itemsState extends State<oreder_items> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListIdPast());
    int total = cartProvider.calculateTotalPricePast(CardItemshow);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "Past Order".tr,
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: mainColorWhite,
          elevation: 0,
          // actions: [
          //   IconButton(
          //       onPressed: () {
          //         if (cartProvider.cartItems.length > 0) {
          //           confirmAlertMycart(context, "Delete All Items".tr,
          //               "are you sure delete all items".tr, cartProvider);
          //         }
          //       },
          //       icon: Icon(
          //         Icons.add,
          //         color: mainColorRed,
          //       )),
          // ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),
        ),
        body: cartProvider.cartItemsPast.length > 0
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: getHeight(context, 65),
                        child: ListView.builder(
                            itemCount: cartProvider.cartItemsPast.length,
                            itemBuilder: (BuildContext context, int index) {
                              final cartitem = CardItemshow[index];
                              final cartitemQ =
                                  cartProvider.cartItemsPast[index];
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      cartProvider
                                          .deleteitemPast(cartitemQ.product!);
                                    },
                                    icon: Icon(
                                      Icons.delete_outline,
                                      color: mainColorGrey.withOpacity(0.5),
                                    ),
                                  ),
                                  Center(
                                    child: Card(
                                      elevation: 4,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        width: getWidth(context, 80),
                                        height: getHeight(context, 12),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceAround,
                                            children: [
                                              Container(
                                                width: getWidth(context, 20),
                                                height: getHeight(context, 10),
                                                decoration: BoxDecoration(
                                                    color: Color(0xffF2F2F2),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            15)),
                                                child: Center(
                                                  child: CachedNetworkImage(
                                                    imageUrl: cartitem.coverImg
                                                        .toString(),
                                                    width:
                                                        getWidth(context, 20),
                                                    height:
                                                        getHeight(context, 10),
                                                  ),
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Container(
                                                    width:
                                                        getWidth(context, 30),
                                                    child: Text(
                                                      lang == "en"
                                                          ? cartitem.nameEn
                                                              .toString()
                                                          : lang == "ar"
                                                              ? cartitem.nameAr
                                                                  .toString()
                                                              : cartitem.nameKu
                                                                  .toString(),
                                                      maxLines: 2,
                                                      style: TextStyle(
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                  Column(
                                                    children: [
                                                      Text(
                                                        cartitem.price!
                                                                .toString() +
                                                            " IQD",
                                                        style: TextStyle(
                                                            decoration: cartitem
                                                                        .offerPrice! >
                                                                    0
                                                                ? TextDecoration
                                                                    .lineThrough
                                                                : TextDecoration
                                                                    .none,
                                                            color:
                                                                mainColorGrey,
                                                            fontFamily:
                                                                mainFontbold,
                                                            fontSize: 10),
                                                      ),
                                                      cartitem.offerPrice! > 0
                                                          ? Text(
                                                              cartitem.offerPrice!
                                                                      .toString() +
                                                                  " IQD",
                                                              style: TextStyle(
                                                                  color:
                                                                      mainColorRed,
                                                                  fontFamily:
                                                                      mainFontbold,
                                                                  fontSize: 10),
                                                            )
                                                          : SizedBox(),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "info: ".tr,
                                                        style: TextStyle(
                                                            color:
                                                                mainColorGrey,
                                                            fontFamily:
                                                                mainFontnormal,
                                                            fontSize: 12),
                                                      ),
                                                      Text(
                                                        lang == "en"
                                                            ? cartitem
                                                                .contentsEn
                                                                .toString()
                                                            : lang == "ar"
                                                                ? cartitem
                                                                    .contentsAr
                                                                    .toString()
                                                                : cartitem
                                                                    .contentsKu
                                                                    .toString(),
                                                        style: TextStyle(
                                                            color:
                                                                mainColorGrey,
                                                            fontFamily:
                                                                mainFontnormal,
                                                            fontSize: 12),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              Container(
                                                width: getWidth(context, 20),
                                                height: getHeight(context, 4),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  color: mainColorWhite,
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        if (cartitem.offerPrice! >
                                                                0 &&
                                                            cartitem.orderLimit ==
                                                                cartProvider.calculateQuantityForProductPast(
                                                                    int.parse(
                                                                        cartitem
                                                                            .id
                                                                            .toString()))) {
                                                          toastLong(
                                                              "you can not add more this item");
                                                          return;
                                                        }
                                                        final cartItem = CartItem(
                                                            product: cartitemQ
                                                                .product!);
                                                        cartProvider
                                                            .addToCartPast(
                                                                cartItem);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Container(
                                                            width: getWidth(
                                                                context, 6),
                                                            height: getHeight(
                                                                context, 3),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5),
                                                                border: Border.all(
                                                                    color: mainColorGrey
                                                                        .withOpacity(
                                                                            0.5)),
                                                                color:
                                                                    mainColorGrey),
                                                            child: Icon(Icons.add,
                                                                color:
                                                                    mainColorWhite,
                                                                size: getHeight(context, 2))),
                                                      ),
                                                    ),
                                                    Text(
                                                      cartitemQ.quantity
                                                          .toString(),
                                                      style: TextStyle(
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 18),
                                                    ),
                                                    GestureDetector(
                                                      onTap: () {
                                                        final cartItem = CartItem(
                                                            product: cartitemQ
                                                                .product!);
                                                        cartProvider
                                                            .removeFromCartPast(
                                                                cartItem);
                                                      },
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(2.0),
                                                        child: Container(
                                                            width: getWidth(
                                                                context, 6),
                                                            height: getHeight(
                                                                context, 3),
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius.circular(
                                                                        5),
                                                                border: Border.all(
                                                                    color: mainColorGrey
                                                                        .withOpacity(
                                                                            0.5)),
                                                                color:
                                                                    mainColorGrey),
                                                            child: Icon(
                                                                Icons.remove,
                                                                color: mainColorWhite,
                                                                size: getHeight(context, 2))),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            }),
                      ),
                    ),
                    Container(
                      height: getHeight(context, 24.4),
                      decoration: BoxDecoration(color: mainColorGrey),
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
                                  addCommasToPrice(total),
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
                                  "Free Delivery",
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
                                  addCommasToPrice(total),
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
                                    cartProvider.addPastToCart(
                                        cartProvider.cartItemsPast);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckOut()),
                                    );
                                  },
                                  child: Text(
                                    "Re Order".tr,
                                    style: TextStyle(
                                      color: mainColorWhite,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 40),
                                        getHeight(context, 6)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () async {
                                    if (await noInternet(context)) {
                                      return;
                                    }
                                    // if (cartProvider.cartItems ==
                                    //     cartProvider.cartItemsPast) {
                                    //   toastShort(
                                    //       "this items already have in Mycart");
                                    //   return;
                                    // }
                                    cartProvider.addPastToCart(
                                        cartProvider.cartItemsPast);
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavSwitch()),
                                    );
                                  },
                                  child: Text(
                                    "Add More Items".tr,
                                    style: TextStyle(
                                      color: mainColorWhite,
                                      fontSize: 16,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 40),
                                        getHeight(context, 6)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            : loginFirstContainer(context),
      ),
    );
  }
}
