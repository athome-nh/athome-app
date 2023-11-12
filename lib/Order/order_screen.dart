import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Order/old_order.dart';
import 'package:athome/Order/order_items.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cartpast.dart';
import 'package:athome/model/order_model/order_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
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
  var subscription;
  @override
  void initState() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        Provider.of<productProvider>(context, listen: false)
            .setnointernetcheck(true);
      } else {
        Provider.of<productProvider>(context, listen: false).updatePost(false);

        Provider.of<productProvider>(context, listen: false)
            .setnointernetcheck(false);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    return productrovider.nointernetCheck
        ? noInternetWidget(context)
        : DefaultTabController(
            length: 2,
            child: Scaffold(
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
                centerTitle: true,
                elevation: 0.5,
                title: Text(
                  "My Orders".tr,
                  style: TextStyle(
                      color: mainColorGrey,
                      fontFamily: mainFontnormal,
                      fontSize: 24),
                ),
                bottom: TabBar(
                  labelColor:
                      mainColorGrey, // Set the color for the selected tab's label
                  indicatorColor: mainColorRed,
                  tabs: const [
                    Tab(text: 'On going'),
                    Tab(text: 'history'),
                  ],
                ),
              ),
              body: TabBarView(
                children: [
                  !isLogin
                      ? loginFirstContainer(context)
                      : productrovider.Orders.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  productrovider.getOrderOngoing().length,
                              itemBuilder: (BuildContext context, int index) {
                                OrderModel order = productrovider
                                    .getOrderOngoing()
                                    .reversed
                                    .toList()[index];

                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                          width: getWidth(context, 15),
                                          height: getHeight(context, 18),
                                          decoration: BoxDecoration(
                                            color: mainColorLightGrey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Image.asset(
                                            "assets/images/123.png",
                                            width: getWidth(context, 15),
                                            height: getHeight(context, 18),
                                          )),
                                      title: Row(
                                        children: [
                                          Text(
                                            "Order number:".tr,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: mainFontbold,
                                                color: mainColorGrey),
                                          ),
                                          Text(
                                            order.id.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
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
                                                          order.totalPrice
                                                              .toString(),
                                                          order.createdAt
                                                              .toString())),
                                            );
                                          },
                                          icon: Icon(
                                            Icons.arrow_forward_ios,
                                            color: mainColorRed,
                                          )),
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
                                    Divider(
                                      color: mainColorGrey,
                                    )
                                  ],
                                );
                              })
                          : Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You not have any order".tr,
                                  style: TextStyle(
                                      fontSize: 32, fontFamily: mainFontnormal),
                                ),
                                SizedBox(
                                  height: getHeight(context, 2),
                                ),
                                Image.asset("assets/images/gif_favorite.gif"),
                              ],
                            )),
                  !isLogin
                      ? loginFirstContainer(context)
                      : productrovider.Orders.isNotEmpty
                          ? ListView.builder(
                              itemCount:
                                  productrovider.getOrderHistory().length,
                              itemBuilder: (BuildContext context, int index) {
                                OrderModel order = productrovider
                                    .getOrderHistory()
                                    .reversed
                                    .toList()[index];

                                return Column(
                                  children: [
                                    ListTile(
                                      leading: Container(
                                          width: getWidth(context, 15),
                                          height: getHeight(context, 18),
                                          decoration: BoxDecoration(
                                            color: mainColorLightGrey,
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: order.status == 5
                                              ? const Icon(
                                                  Icons.check,
                                                  color: Colors.green,
                                                  size: 35,
                                                )
                                              : Icon(
                                                  Icons.close,
                                                  color: mainColorRed,
                                                  size: 35,
                                                )),
                                      title: Row(
                                        children: [
                                          Text(
                                            "Order number:".tr,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: mainFontbold,
                                                color: mainColorGrey),
                                          ),
                                          Text(
                                            order.id.toString(),
                                            style: TextStyle(
                                                fontSize: 20,
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
                                          Container(
                                            height: getHeight(context, 4),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: mainColorGrey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: TextButton(
                                                onPressed: () {
                                                  productrovider
                                                      .getordersbyOrderId(
                                                          order.id.toString())
                                                      .forEach((element) {
                                                    final existingItemIndex =
                                                        productrovider.products
                                                            .indexWhere(
                                                      (pro) =>
                                                          pro.id ==
                                                          element.productId,
                                                    );
                                                    print(existingItemIndex);
                                                    if (existingItemIndex !=
                                                        -1) {
                                                      //count order

                                                      final cartItem =
                                                          CartItemPast(
                                                        product:
                                                            element.productId!,
                                                        quantity: (element
                                                                .pickedQt! -
                                                            element
                                                                .returnedQt!),
                                                      );
                                                      cartProvider
                                                          .addToCartPast(
                                                              cartItem);
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
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "Re order",
                                                      style: TextStyle(
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 12),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Ionicons.repeat_outline,
                                                      color: mainColorRed,
                                                      size: 20,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                          Container(
                                            height: getHeight(context, 4),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: mainColorGrey),
                                                borderRadius:
                                                    BorderRadius.circular(5)),
                                            child: TextButton(
                                                onPressed: () {
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
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      "View",
                                                      style: TextStyle(
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 14),
                                                    ),
                                                    const SizedBox(
                                                      width: 5,
                                                    ),
                                                    Icon(
                                                      Ionicons.eye_outline,
                                                      color: mainColorRed,
                                                      size: 20,
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Divider(
                                      color: mainColorGrey,
                                    )
                                  ],
                                );
                              })
                          : Center(
                              child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "You not have any order".tr,
                                  style: TextStyle(
                                      fontSize: 32, fontFamily: mainFontnormal),
                                ),
                                SizedBox(
                                  height: getHeight(context, 2),
                                ),
                                Image.asset("assets/images/gif_favorite.gif"),
                              ],
                            )),
                ],
              ),
            ),
          );
  }
}
