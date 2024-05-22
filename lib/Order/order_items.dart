import 'package:dllylas/Config/my_widget.dart';

import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/check_out.dart';
import 'package:dllylas/model/cartpast.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:dllylas/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../home/nav_switch.dart';
import '../main.dart';

class OrederItems extends StatefulWidget {
  const OrederItems({super.key});

  @override
  State<OrederItems> createState() => _OrederItemsState();
}

// ignore: camel_case_types
class _OrederItemsState extends State<OrederItems> {
  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    // ignore: non_constant_identifier_names
    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListIdPast());

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: Scaffold(
        backgroundColor: mainColorWhite,
        appBar: AppBar(
          title: Text(
            "Past Order".tr,
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
              )),
        ),
        body: cartProvider.cartItemsPast.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                    itemCount: cartProvider.cartItemsPast.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cartitemQ = cartProvider.cartItemsPast[index];
                      final cartitem =
                          productrovider.getoneProductById(cartitemQ.product);

                      return Dismissible(
                        key: Key(cartitem.id.toString()),
                        direction: DismissDirection.startToEnd,
                        onDismissed: (direction) {
                          String name = lang == "en"
                              ? cartitem.nameEn.toString()
                              : lang == "ar"
                                  ? cartitem.nameAr.toString()
                                  : cartitem.nameKu.toString();
                          cartProvider.deleteitemPast(cartitemQ.product);
                          CardItemshow = productrovider
                              .getProductsByIds(cartProvider.ListIdPast());
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Delete".tr + name,
                              ),
                            ),
                          );
                        },
                        background: Container(
                          color: Colors.red,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.delete,
                                color: mainColorWhite,
                              ),
                            ),
                          ),
                        ),
                        child: Column(
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
                                          color:
                                              mainColorBlack.withOpacity(0.1)),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            dotenv.env['imageUrlServer']! +
                                                cartitem.coverImg!,
                                        filterQuality: FilterQuality.low,
                                        width: getWidth(context, 15),
                                        height: getWidth(context, 15),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: getWidth(context, 2),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: getWidth(context, 40),
                                        child: Text(
                                          lang == "en"
                                              ? cartitem.nameEn.toString()
                                              : lang == "ar"
                                                  ? cartitem.nameAr.toString()
                                                  : cartitem.nameKu.toString(),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorBlack,
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
                                              ? cartitem.contentsEn.toString()
                                              : lang == "ar"
                                                  ? cartitem.contentsAr
                                                      .toString()
                                                  : cartitem.contentsKu
                                                      .toString(),
                                          textAlign: TextAlign.start,
                                          maxLines: 1,
                                          style: TextStyle(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              fontFamily: mainFontbold,
                                              fontSize: 11),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            addCommasToPrice(
                                                cartitem.price2! > -1
                                                    ? cartitem.price2!
                                                    : cartitem.price!),
                                            maxLines: 1,
                                            style: TextStyle(
                                                decoration:
                                                    checkOferPrice(cartitem)
                                                        ? TextDecoration
                                                            .lineThrough
                                                        : TextDecoration.none,
                                                color: checkOferPrice(cartitem)
                                                    ? mainColorRed
                                                    : Colors.green,
                                                fontFamily:
                                                    checkOferPrice(cartitem)
                                                        ? mainFontnormal
                                                        : mainFontbold,
                                                fontSize: 14),
                                          ),
                                          checkOferPrice(cartitem)
                                              ? const Text("/")
                                              : const SizedBox(),
                                          checkOferPrice(cartitem)
                                              ? Text(
                                                  addCommasToPrice(
                                                      cartitem.offerPrice!),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      color: Colors.green,
                                                      fontFamily: mainFontbold,
                                                      fontSize: 14),
                                                )
                                              : const SizedBox(),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  Container(
                                    width: getWidth(context, 20),
                                    height: getHeight(context, 4),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: mainColorWhite,
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        GestureDetector(
                                          onTap: checkProductStock(cartitem,
                                                      cartitemQ.quantity) ||
                                                  checkProductLimit(cartitem,
                                                      cartitemQ.quantity)
                                              ? null
                                              : () {
                                                  final cartItem = CartItemPast(
                                                      product:
                                                          cartitemQ.product);
                                                  cartProvider
                                                      .plusToCartPast(cartItem);
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: checkProductStock(
                                                                cartitem,
                                                                cartitemQ
                                                                    .quantity) ||
                                                            checkProductLimit(
                                                                cartitem,
                                                                cartitemQ
                                                                    .quantity)
                                                        ? mainColorGrey
                                                            .withOpacity(0.5)
                                                        : Colors.green)),
                                            child: Icon(Icons.add,
                                                color: checkProductStock(
                                                            cartitem,
                                                            cartitemQ
                                                                .quantity) ||
                                                        checkProductLimit(
                                                            cartitem,
                                                            cartitemQ.quantity)
                                                    ? mainColorGrey
                                                        .withOpacity(0.5)
                                                    : Colors.green,
                                                size: getHeight(context, 2.5)),
                                          ),
                                        ),
                                        Text(
                                          cartitemQ.quantity.toString(),
                                          style: TextStyle(
                                              color: mainColorGrey,
                                              fontFamily: mainFontnormal,
                                              fontSize: 18),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            final cartItem = CartItemPast(
                                                product: cartitemQ.product);
                                            cartProvider
                                                .removeFromCartPast(cartItem);
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: mainColorRed)),
                                            child: Icon(Icons.remove,
                                                color: mainColorRed,
                                                size: getHeight(context, 2.5)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Divider()
                          ],
                        ),
                      );
                    }),
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: getWidth(context, 60),
                      height: getWidth(context, 50),
                      child: Image.asset("assets/Victors/cart_empty.png"),
                    ),
                    Text(
                      "Your cart is empty".tr,
                      style: TextStyle(
                          fontFamily: mainFontnormal,
                          color: mainColorBlack,
                          fontSize: 16),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: productrovider.nointernetCheck
            ? noInternetWidget(context)
            : cartProvider.cartItemsPast.isNotEmpty
                ? Container(
                    height: getHeight(context, 20),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(context, 3),
                        ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: getWidth(context, 4)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         "Sub Total".tr,
                        //         style: TextStyle(
                        //             color: mainColorBlack,
                        //             fontFamily: mainFontnormal,
                        //             fontSize: 16),
                        //       ),
                        //       Text(
                        //         textAlign: TextAlign.end,
                        //         addCommasToPrice(cartProvider
                        //             .calculateTotalPricePast(CardItemshow)),
                        //         style: TextStyle(
                        //             color: mainColorBlack,
                        //             fontFamily: mainFontnormal,
                        //             fontSize: 16),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: getHeight(context, 1),
                        // ),
                        // Padding(
                        //   padding: EdgeInsets.symmetric(
                        //       horizontal: getWidth(context, 4)),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //     children: [
                        //       Text(
                        //         "Delivery Cost".tr,
                        //         style: TextStyle(
                        //             color: mainColorBlack,
                        //             fontFamily: mainFontnormal,
                        //             fontSize: 16),
                        //       ),
                        //       Text(
                        //         textAlign: TextAlign.end,
                        //         "Free Delivery".tr,
                        //         style: TextStyle(
                        //             color: Colors.green,
                        //             fontFamily: mainFontnormal,
                        //             fontSize: 16),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                       
                       // Line (Divider)
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
                                    color: mainColorBlack,
                                    fontFamily: mainFontbold,
                                    fontSize: 20),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                addCommasToPrice(cartProvider
                                    .calculateTotalPricePast(CardItemshow)),
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: mainFontbold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                        
                        SizedBox(
                          height: getHeight(context, 2),
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
                                        builder: (context) => CheckOut(
                                            cartProvider
                                                .calculateTotalPricePast(
                                                    CardItemshow))),
                                  ).then((value) {
                                    cartProvider.clearCart();
                                  });
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: mainColorRed,
                                  fixedSize: Size(getWidth(context, 40),
                                      getHeight(context, 6)),
                                ),
                                child: Text(
                                  "Re order".tr,
                                ),
                              ),
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
                                        builder: (context) => NavSwitch()),
                                  );
                                  cartProvider.clearCartPast();
                                },
                                style: TextButton.styleFrom(
                                  fixedSize: Size(getWidth(context, 40),
                                      getHeight(context, 6)),
                                ),
                                child: Text(
                                  "Add More Items".tr,
                                ),
                              ),
                            ],
                          ),
                        ),
                        
                        // SizedBox(
                        //   height: getWidth(context, 2),
                        // )

                      ],
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }
}
