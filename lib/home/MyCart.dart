import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';

import 'package:athome/Config/property.dart';
import 'package:athome/Home/CheckOut.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

import '../main.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListId());
    final total = cartProvider.calculateTotalPrice(CardItemshow);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "My Cart".tr,
            style: TextStyle(
                color: mainColorGrey, fontFamily: mainFontnormal, fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: mainColorWhite,
          elevation: 0,
          actions: [
            IconButton(
                onPressed: () {
                  if (cartProvider.cartItems.length > 0) {
                    confirmAlertMycart(context, "Delete All Items".tr,
                        "are you sure delete all items".tr, cartProvider);
                  }
                },
                icon: Icon(
                  Icons.delete_outline,
                  color: mainColorRed,
                )),
          ],
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),
        ),
        body: cartProvider.cartItems.length > 0
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Container(
                        height: getHeight(context, 50),
                        child: ListView.builder(
                            itemCount: cartProvider.cartItems.length,
                            itemBuilder: (BuildContext context, int index) {
                              final cartitem = CardItemshow[index];
                              final cartitemQ = cartProvider.cartItems[index];
                              return Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      cartProvider
                                          .deleteitem(cartitemQ.product!);
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
                                                BorderRadius.circular(15)),
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
                                                        setState(() {
                                                          final cartItem = CartItem(
                                                              product: cartitemQ
                                                                  .product!);
                                                          cartProvider
                                                              .addToCart(
                                                                  cartItem);
                                                        });
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
                                                        setState(() {
                                                          final cartItem = CartItem(
                                                              product: cartitemQ
                                                                  .product!);
                                                          cartProvider
                                                              .removeFromCart(
                                                                  cartItem);
                                                        });
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
                    Column(
                      children: [
                        Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 4)),
                            child: TextField(
                              maxLines: 2,
                              cursorColor: mainColorRed,
                              decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontbold,
                                    fontSize: 14),
                                labelText: "Delivery Instrusctions".tr,
                                hintText: "Type Notes here".tr,
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: mainColorGrey,
                                    strokeAlign:
                                        2, // Change this to the color you want
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:
                                        mainColorGrey, // Change this to the color you want
                                  ),
                                ),
                              ),
                            )),
                        SizedBox(
                          height: getHeight(context, 1),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: getWidth(context, 4)),
                          child: Divider(
                              color: mainColorGrey.withOpacity(0.2),
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
                                "Sub Total".tr,
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 13),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                total.toStringAsFixed(2),
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontbold,
                                    fontSize: 14),
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
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 13),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                "20,000 IQD",
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontbold,
                                    fontSize: 14),
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
                          child: Divider(
                              color: mainColorGrey.withOpacity(0.2),
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
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 13),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                "60,000 IQD",
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontbold,
                                    fontSize: 18),
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
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckOut()),
                              );
                            },
                            child: Text(
                              "Checkout".tr,
                              style: TextStyle(
                                color: mainColorWhite,
                                fontSize: 16,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: mainColorRed,
                              fixedSize: Size(
                                  getWidth(context, 85), getHeight(context, 6)),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            : loginFirstContainer(context),
      ),
    );
  }

  Future<void> confirmAlertMycart(BuildContext context, String title,
      String content, CartProvider cartprovider) {
    return QuickAlert.show(
      context: context,
      confirmBtnColor: mainColorRed,
      type: QuickAlertType.error,
      title: title,
      text: content,
      confirmBtnText: "Yes".tr,
      cancelBtnText: "No".tr,
      onConfirmBtnTap: () {
        cartprovider.clearCart();
        Navigator.pop(context);
        Navigator.pop(context);
      },
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
    );
  }
}
