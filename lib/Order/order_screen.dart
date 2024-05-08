import 'dart:async';

import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Order/old_order.dart';
import 'package:dllylas/Order/order_items.dart';

import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/model/cartpast.dart';
import 'package:dllylas/model/order_model/order_model.dart';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/my_widget.dart';
import '../Config/property.dart';
import '../controller/productprovider.dart';
import '../home/track_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (result[0] == ConnectivityResult.none) {
      pro.setnointernetcheck(true);
    } else {
      if (pro.nointernetCheck) {
        pro.updatePost(false);
        pro.setnointernetcheck(false);
      }
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return productrovider.nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: DefaultTabController(
              length: 2,
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      )),
                  title: Text(
                    "My Orders".tr,
                  ),
                  bottom: TabBar(
                    unselectedLabelColor: mainColorGrey,
                    labelColor: mainColorGrey,
                    indicatorColor: mainColorGrey,
                    labelStyle:
                        TextStyle(fontFamily: mainFontnormal, fontSize: 14),
                    unselectedLabelStyle:
                        TextStyle(fontFamily: mainFontnormal, fontSize: 14),
                    tabs: [
                      Tab(
                        text: "On going".tr,
                      ),
                      Tab(text: "History".tr),
                    ],
                  ),
                ),
                body: TabBarView(
                  children: [
                    !isLogin
                        ? loginFirstContainer(context)
                        : productrovider.Orders.any(
                                (order) => order.status! < 5)
                            ? ListView.builder(
                                itemCount:
                                    productrovider.getOrderOngoing().length,
                                itemBuilder: (BuildContext context, int index) {
                                  OrderModel order = productrovider
                                      .getOrderOngoing()
                                      .reversed
                                      .toList()[index];

                                  return Card(
                                    elevation: 2,
                                    margin: EdgeInsets.all(8),
                                    color: mainColorWhite,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                              width: getWidth(context, 15),
                                              height: getHeight(context, 18),
                                              decoration: BoxDecoration(
                                                color: mainColorGrey
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Image.asset(
                                                "assets/Victors/ongoing.png",
                                                width: getWidth(context, 15),
                                                height: getHeight(context, 18),
                                              )),
                                          title: Row(
                                            children: [
                                              Text(
                                                "Order number:".tr,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: mainFontbold,
                                                    color: mainColorBlack),
                                              ),
                                              Text(
                                                order.id.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: mainFontbold,
                                                    color: mainColorRed),
                                              ),
                                            ],
                                          ),
                                          trailing: IconButton(
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          TrackOrder(
                                                              order.id.toString(),
                                                              order
                                                                  .returnTotalPrice
                                                                  .toString(),
                                                              order.createdAt
                                                                  .toString())),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.arrow_forward_ios,
                                                color: mainColorGrey,
                                              )),
                                          subtitle: Text(
                                            "Date:".tr +
                                                order.createdAt
                                                    .toString()
                                                    .substring(0, 16),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: mainFontnormal,
                                                color: mainColorBlack),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                            : Center(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //textcheck
                                  Image.asset("assets/Victors/empty.png"),
                                  SizedBox(
                                    height: getHeight(context, 1),
                                  ),
                                  Text(
                                    "You not have any order".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: mainFontnormal),
                                  ),
                                ],
                              )),
                    !isLogin
                        ? loginFirstContainer(context)
                        : productrovider.getOrderHistory().isNotEmpty
                            ? ListView.builder(
                                itemCount:
                                    productrovider.getOrderHistory().length,
                                itemBuilder: (BuildContext context, int index) {
                                  OrderModel order = productrovider
                                      .getOrderHistory()
                                      .reversed
                                      .toList()[index];

                                  return Card(
                                    elevation: 2,
                                    margin: EdgeInsets.all(8),
                                    color: mainColorWhite,
                                    child: Column(
                                      children: [
                                        ListTile(
                                          leading: Container(
                                              width: getWidth(context, 15),
                                              height: getHeight(context, 18),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: order.status == 5
                                                  ? Image.asset(
                                                      "assets/Victors/delivered.png",
                                                    )
                                                  : Image.asset(
                                                      "assets/Victors/undelivered.png",
                                                    )),
                                          title: Row(
                                            children: [
                                              Text(
                                                "Order number:".tr,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: mainFontbold,
                                                    color: mainColorGrey),
                                              ),
                                              Text(
                                                order.id.toString(),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    fontFamily: mainFontbold,
                                                    color: mainColorRed),
                                              ),
                                            ],
                                          ),
                                          subtitle: Text(
                                            "Date:".tr +
                                                order.createdAt
                                                    .toString()
                                                    .substring(0, 16),
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontFamily: mainFontnormal,
                                                color: mainColorGrey),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: getWidth(context, 4)),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              TextButton.icon(
                                                onPressed: () {
                                                  productrovider.getordersbyOrderId(
                                                          order.id.toString())
                                                      .forEach((element) {
                                                    final existingItemIndex =
                                                        productrovider.products
                                                            .indexWhere(
                                                      (pro) =>
                                                          pro.id ==
                                                          element.productId,
                                                    );

                                                    if (existingItemIndex !=
                                                        -1) {
                                                      //count order
                                                      final productitem =
                                                          productrovider
                                                                  .products[
                                                              existingItemIndex];
                                                      int count = element.qt!;
                                                      if (order.status == 5) {
                                                        count = (element
                                                                .pickedQt! -
                                                            element
                                                                .returnedQt!);
                                                      } else {
                                                        count = element.qt!;
                                                      }

                                                      if (count == 0) {
                                                        return;
                                                      }

                                                      if (checkOferPrice(
                                                              productitem) &&
                                                          productitem
                                                                  .orderLimit! <
                                                              count) {
                                                        final cartItem =
                                                            CartItemPast(
                                                          product:
                                                              productitem.id!,
                                                          quantity: productitem
                                                              .orderLimit!,
                                                        );
                                                        cartProvider
                                                            .addToCartPast(
                                                                cartItem);
                                                      } else if (count >
                                                          productitem.stock!) {
                                                        final cartItem =
                                                            CartItemPast(
                                                          product:
                                                              productitem.id!,
                                                          quantity: productitem
                                                              .stock!,
                                                        );
                                                        cartProvider
                                                            .addToCartPast(
                                                                cartItem);
                                                      } else {
                                                        final cartItem =
                                                            CartItemPast(
                                                          product: element
                                                              .productId!,
                                                          quantity: count,
                                                        );
                                                        cartProvider
                                                            .addToCartPast(
                                                                cartItem);
                                                      }
                                                    } else {}
                                                  });
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const OrederItems()),
                                                  ).then((value) {
                                                    cartProvider
                                                        .clearCartPast();
                                                  });
                                                },
                                                icon: Icon(
                                                  Icons.repeat,
                                                  color: mainColorGrey,
                                                ), // Add your desired icon
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    fixedSize: Size(
                                                        getWidth(context, 45),
                                                        getHeight(context, 3))),
                                                label: Text(
                                                  "Re order".tr,
                                                  style: TextStyle(
                                                      color: mainColorGrey),
                                                ),
                                              ),
                                              
                                              TextButton.icon(
                                                onPressed: () {
                                                  productrovider
                                                      .getproductitems(
                                                          order.id!);
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            OldOrder(
                                                                order.id
                                                                    .toString(),
                                                                order
                                                                    .returnTotalPrice
                                                                    .toString(),
                                                                order.createdAt
                                                                    .toString(),
                                                                order.status!)),
                                                  );
                                                },
                                                icon: Icon(
                                                  Icons.visibility_outlined,
                                                  color: mainColorGrey,
                                                ), // Add your desired icon
                                                style: TextButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    fixedSize: Size(
                                                        getWidth(context, 30),
                                                        getHeight(context, 3))),
                                                label: Text(
                                                  "View".tr,
                                                  style: TextStyle(
                                                      color: mainColorGrey),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                })
                            : Center(
                                child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  //textcheck
                                  Image.asset("assets/Victors/empty.png"),
                                  SizedBox(
                                    height: getHeight(context, 1),
                                  ),
                                  Text(
                                    "You not have any order".tr,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontFamily: mainFontnormal),
                                  ),
                                ],
                              )),
                  ],
                ),
              ),
            ),
          );
  }
}
