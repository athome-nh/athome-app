// Import necessary packages and libraries
import 'dart:async';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Order/old_order.dart';
import 'package:dllylas/Order/order_items.dart';
import 'package:dllylas/Order/track_order.dart';
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

/// This is a stateful widget that represents the Order Screen of the application.
class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

/// This state class manages the OrderScreen UI and its connectivity status.
class _OrderScreenState extends State<OrderScreen> {
  // Declaring a Connectivity instance to monitor internet connectivity.
  final Connectivity _connectivity = Connectivity();

  // Declaring a StreamSubscription to listen to connectivity changes.
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  /// This method is called when the state is initialized.
  /// It subscribes to the connectivity status changes and calls _updateConnectionStatus when a change occurs.
  @override
  void initState() {
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  /// This function updates the connection status based on the connectivity result.
  /// It modifies the provider's 'no internet' check status accordingly.
  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (result[0] == ConnectivityResult.none) {
      // If no internet connection, set 'noInternetCheck' to true.
      pro.setnointernetcheck(true);
    } else {
      // If internet connection is restored, update and reset the 'noInternetCheck' flag.
      if (pro.nointernetCheck) {
        pro.updatePost(false);
        pro.setnointernetcheck(false);
      }
    }
  }

  /// Disposes the connectivity subscription to avoid memory leaks when the widget is disposed.
  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  /// Builds the UI of the OrderScreen, showing either the ongoing or history tab based on user login and order status.
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    // Check if there is no internet connection, display the no internet widget.
    return productrovider.nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: DefaultTabController(
              length: 2, // Two tabs: "On going" and "History".
              child: Scaffold(
                appBar: AppBar(
                  leading: IconButton(
                      onPressed: () {
                        Navigator.pop(context); // Navigates back on press.
                      },
                      icon: const Icon(Icons.arrow_back_ios)),
                  title: Text("My Orders".tr), // Translated "My Orders" title.
                  bottom: TabBar(
                    unselectedLabelColor: mainColorGrey,
                    labelColor: mainColorGrey,
                    indicatorColor: mainColorGrey,
                    labelStyle:
                        TextStyle(fontFamily: mainFontnormal, fontSize: 14),
                    unselectedLabelStyle:
                        TextStyle(fontFamily: mainFontnormal, fontSize: 14),
                    tabs: [
                      Tab(text: "On going".tr),
                      Tab(text: "History".tr)
                    ], // Two tabs for ongoing and history orders.
                  ),
                ),
                body: TabBarView(
                  children: [
                    // Ongoing Orders Tab
                    !isLogin
                        ? loginFirstContainer(
                            context) // If not logged in, display login prompt.
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
                                  return Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                          color:
                                              mainColorGrey2.withOpacity(0.5),
                                        ),
                                        color: mainColorlightGrey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.all(8),
                                    padding: EdgeInsets.all(4),
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
                                                "Order number".tr + " : ",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontFamily: mainFontbold,
                                                    color: mainColorBlack),
                                              ),
                                              Text(
                                                order.id.toString(),
                                                style: TextStyle(
                                                    fontSize: 16,
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
                                                          TrackOrder(order
                                                              .id!))); // Navigate to track order page.
                                            },
                                            icon: Icon(
                                              Icons.arrow_forward_ios,
                                              color: mainColorGrey,
                                            ),
                                          ),
                                          subtitle: Text(
                                            "Date".tr +
                                                " : " +
                                                convertToBaghdadTime(
                                                    order.createdAt.toString()),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                    Image.asset("assets/Victors/empty.png"),
                                    SizedBox(height: getHeight(context, 1)),
                                    Text("You not have any order".tr,
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: mainFontnormal))
                                  ])),
                    // Order History Tab
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
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: mainColorGrey2
                                                  .withOpacity(0.5)),
                                          color: mainColorlightGrey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        ClipRRect(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                          child: Image.asset(
                                                            "assets/images/App_Icon_Red.png",
                                                            height: getWidth(
                                                                context, 9),
                                                            width: getWidth(
                                                                context, 9),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: getWidth(
                                                              context, 1),
                                                        ),
                                                        Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              "Dlly Las Market"
                                                                  .tr,
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      mainFontbold,
                                                                  color:
                                                                      mainColorBlack),
                                                            ),
                                                            Text(
                                                              "Order number"
                                                                      .tr +
                                                                  " : " +
                                                                  order.id
                                                                      .toString(),
                                                              style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily:
                                                                      mainFontnormal,
                                                                  color:
                                                                      mainColorBlack),
                                                            ),
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      "Order Case".tr,
                                                      style: TextStyle(
                                                          fontSize: 16,
                                                          fontFamily:
                                                              mainFontbold,
                                                          color:
                                                              mainColorBlack),
                                                    ),
                                                    SizedBox(
                                                        height: getHeight(
                                                            context, 1)),
                                                    order.status == 5
                                                        ? Image.asset(
                                                            "assets/Victors/delivered.png",
                                                            height: getWidth(
                                                                context, 9),
                                                            width: getWidth(
                                                                context, 9),
                                                          )
                                                        : Image.asset(
                                                            "assets/Victors/undelivered.png",
                                                            height: getWidth(
                                                                context, 9),
                                                            width: getWidth(
                                                                context, 9),
                                                          ),
                                                  ],
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                                height: getHeight(context, 1)),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        productrovider
                                                            .getordersbyOrderId(
                                                                order.id
                                                                    .toString())
                                                            .forEach((element) {
                                                          final existingItemIndex =
                                                              productrovider
                                                                  .products
                                                                  .indexWhere(
                                                            (pro) =>
                                                                pro.id ==
                                                                element
                                                                    .productId,
                                                          );

                                                          if (existingItemIndex !=
                                                              -1) {
                                                            final productitem =
                                                                productrovider
                                                                        .products[
                                                                    existingItemIndex];
                                                            int count =
                                                                element.qt!;
                                                            if (order.status ==
                                                                5) {
                                                              count = (element
                                                                      .pickedQt! -
                                                                  element
                                                                      .returnedQt!);
                                                            } else {
                                                              count =
                                                                  element.qt!;
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
                                                                    productitem
                                                                        .id!,
                                                                quantity:
                                                                    productitem
                                                                        .orderLimit!,
                                                              );
                                                              cartProvider
                                                                  .addToCartPast(
                                                                      cartItem);
                                                            } else if (count >
                                                                productitem
                                                                    .stock!) {
                                                              final cartItem =
                                                                  CartItemPast(
                                                                product:
                                                                    productitem
                                                                        .id!,
                                                                quantity:
                                                                    productitem
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
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            color:
                                                                mainColorGrey,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5)),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal: 6,
                                                                  vertical: 3),
                                                          child: Row(
                                                            children: [
                                                              Icon(
                                                                Icons
                                                                    .rotate_left,
                                                                color:
                                                                    mainColorWhite,
                                                                size: 20,
                                                              ),
                                                              Text(
                                                                "Re order".tr,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        13,
                                                                    fontFamily:
                                                                        mainFontnormal,
                                                                    color:
                                                                        mainColorWhite),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(width: 10),
                                                    GestureDetector(
                                                      onTap: () {
                                                        productrovider
                                                            .refreshOrderData();
                                                        productrovider
                                                            .getproductitems(
                                                                order.id!);
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  OldOrder(
                                                                      order.id!,
                                                                      false)),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                          Icon(
                                                            Icons
                                                                .visibility_outlined,
                                                            color:
                                                                mainColorBlack,
                                                          ),
                                                          SizedBox(width: 3),
                                                          Text(
                                                            "View".tr,
                                                            style: TextStyle(
                                                                fontSize: 14,
                                                                fontFamily:
                                                                    mainFontnormal,
                                                                color:
                                                                    mainColorBlack),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Text(
                                                      order.status == 5
                                                          ? "Delivered".tr
                                                          : "Undelivered".tr,
                                                      style: TextStyle(
                                                          fontSize: 10,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          color:
                                                              mainColorBlack),
                                                    ),
                                                    Text(
                                                      "Date".tr +
                                                          " : " +
                                                          convertToBaghdadTime(
                                                              order.createdAt
                                                                  .toString()),
                                                      style: TextStyle(
                                                          fontSize: 11,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          color:
                                                              mainColorBlack),
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                })
                            : Center(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/Victors/empty.png"),
                                    SizedBox(height: getHeight(context, 1)),
                                    Text(
                                      "You not have any order".tr,
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontFamily: mainFontnormal),
                                    ),
                                  ],
                                ),
                              ),
                  ],
                ),
              ),
            ),
          );
  }
}
