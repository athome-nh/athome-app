import 'package:athome/controller/cartprovider.dart';
import 'package:athome/home/TrackOrder.dart';
import 'package:athome/main.dart';
import 'package:athome/model/order_model/order_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Config/my_widget.dart';
import '../Config/property.dart';
import '../controller/productprovider.dart';

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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
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
                            }
                          },
                          child: Container(
                            width: getWidth(context, 90),
                            height: getHeight(context, 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                            ),
                            child: Card(
                              elevation: 5,
                              color: mainColorWhite,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                trailing: Icon(
                                  Icons.arrow_forward_ios,
                                  color: mainColorRed,
                                ),
                                leading: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: Container(
                                      width: getWidth(context, 13),
                                      height: getHeight(context, 18),
                                      decoration: BoxDecoration(
                                        color: mainColorLightGrey,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Icon(
                                        order.status! < 5
                                            ? Icons.shopping_cart
                                            : order.status! == 6
                                                ? Icons.close
                                                : Icons.check,
                                        color: order.status! == 5
                                            ? Colors.green
                                            : mainColorRed,
                                        size: 30,
                                      )),
                                ),
                                title: Row(
                                  children: [
                                    Text(
                                      "Order ID: ",
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
                                  "Date: ${order.createdAt.toString().substring(0, 16)}",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: mainFontnormal,
                                      color: mainColorGrey),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                : nullContainer(
                    context, "title", "you do not have any order yet."),
      ),
    );
  }
}
