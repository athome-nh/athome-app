import 'package:athome/Account/old_order.dart';
import 'package:athome/Account/order_items.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cartpast.dart';
import 'package:athome/model/order_model/order_model.dart';
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
  @override
  Widget build(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: true);
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        backgroundColor: mainColorWhite,
        automaticallyImplyLeading: false,
        elevation: 0.5,
        title: Image.asset(
          "assets/images/logoB.png",
          width: getWidth(context, 30),
        ),
      ),
      body: Center(
        child: !isLogin
            ? loginFirstContainer(context)
            : productrovider.Orders.isNotEmpty
                ? ListView.builder(
                    itemCount: productrovider.Orders.length,
                    itemBuilder: (BuildContext context, int index) {
                      OrderModel order =
                          productrovider.Orders.reversed.toList()[index];
                      print(order);
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          width: getWidth(context, 90),
                          height: getHeight(context, 13),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          child: Card(
                            elevation: 5,
                            color: mainColorWhite,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                ListTile(
                                  trailing: IconButton(
                                    onPressed: () {
                                      if (order.status! < 5) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TrackOrder(
                                                  order.orderCode.toString(),
                                                  order.id.toString(),
                                                  order.totalPrice.toString(),
                                                  order.createdAt.toString())),
                                        );
                                      } else {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => OldOrder(
                                                  order.orderCode.toString(),
                                                  order.id.toString(),
                                                  order.returnTotalPrice
                                                      .toString(),
                                                  order.createdAt.toString())),
                                        );
                                      }
                                    },
                                    icon: Icon(Icons.arrow_forward_ios,
                                        color: mainColorRed),
                                  ),
                                  leading: Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                        width: getWidth(context, 13),
                                        height: getHeight(context, 18),
                                        decoration: BoxDecoration(
                                          color: mainColorLightGrey,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: order.status! < 5
                                            ? Image.asset(
                                                "assets/images/123.gif")
                                            : Icon(
                                                order.status! == 5
                                                    ? Icons.check
                                                    : Icons.close,
                                                color: order.status! == 5
                                                    ? Colors.green
                                                    : mainColorRed,
                                                size: 30,
                                              )),
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        "Order ID:".tr,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontFamily: mainFontbold,
                                            color: mainColorGrey),
                                      ),
                                      Text(
                                        order.orderCode!,
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
                                        fontSize: 12,
                                        fontFamily: mainFontnormal,
                                        color: mainColorGrey),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    productrovider
                                        .getordersbyOrderCode(order.orderCode!)
                                        .forEach((element) {
                                      final cartItem = CartItemPast(
                                        product: element.productId!,
                                        quantity: element.qt!,
                                      );
                                      cartProvider.addToCartPast(cartItem);
                                    });
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const OrederItems()),
                                    ).then((value) {
                                      cartProvider.clearCartPast();
                                    });
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: getWidth(context, 5),
                                        right: getWidth(context, 5),
                                        top: getWidth(context, 1)),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.repeat,
                                          color: mainColorGrey,
                                        ),
                                        Text(
                                          "Re Order".tr,
                                          style: TextStyle(
                                              color: mainColorRed,
                                              fontFamily: mainFontnormal),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
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
                      Text(
                        "You not have any order".tr,
                        style:
                            TextStyle(fontSize: 32, fontFamily: mainFontnormal),
                      ),
                      SizedBox(
                        height: getHeight(context, 2),
                      ),
                      Image.asset("assets/images/gif_favorite.gif"),
                    ],
                  )),
      ),
    );
  }
}
