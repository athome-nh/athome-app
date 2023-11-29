import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/home/check_out.dart';
import 'package:athome/model/cartpast.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(
                Icons.arrow_back_ios,
                color: mainColorRed,
              )),
        ),
        body: cartProvider.cartItemsPast.isNotEmpty
            ? Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ListView.builder(
                    itemCount: cartProvider.cartItemsPast.length,
                    itemBuilder: (BuildContext context, int index) {
                      final cartitem = CardItemshow[index];

                      final cartitemQ = cartProvider.cartItemsPast[index];
                      // if (checkProductLimit(cartitem, cartitemQ.quantity)) {
                      //   final cartItem = CartItemPast(
                      //     product: cartitem.id!,
                      //     quantity: cartitem.orderLimit!,
                      //   );
                      //   cartProvider.addToCartPast(cartItem);
                      // } else {}
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
                          child: const Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Icon(
                                Icons.delete,
                                color: Colors.white,
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
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            imageUrlServer + cartitem.coverImg!,
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
                                              color: mainColorGrey,
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
                                                      .addToCartPast(cartItem);
                                                },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
                                                    BorderRadius.circular(5),
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
                      child: Image.asset("assets/images/gif_favorite.gif"),
                    ),
                    Text(
                      "Your cart is empty".tr,
                      style:
                          TextStyle(fontFamily: mainFontnormal, fontSize: 16),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: productrovider.nointernetCheck
            ? noInternetWidget(context)
            : cartProvider.cartItemsPast.isNotEmpty
                ? Container(
                    height: getHeight(context, 26),
                    decoration: BoxDecoration(
                      color: mainColorWhite,
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: getHeight(context, 3),
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
                                    fontSize: 16),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                addCommasToPrice(cartProvider
                                    .calculateTotalPricePast(CardItemshow)),
                                style: TextStyle(
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
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
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 16),
                              ),
                              Text(
                                textAlign: TextAlign.end,
                                "Free Delivery".tr,
                                style: TextStyle(
                                    color: Colors.green,
                                    fontFamily: mainFontnormal,
                                    fontSize: 16),
                              ),
                            ],
                          ),
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

                                  // ignore: use_build_context_synchronously
                                  // showModalBottomSheet(
                                  //   context: context,
                                  //   isDismissible: true,
                                  //   shape: const RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.vertical(
                                  //       top: Radius.circular(25.0),
                                  //     ),
                                  //   ),
                                  //   builder: (BuildContext context) {
                                  //     return Container(
                                  //       color: mainColorWhite,
                                  //       child: Column(
                                  //         children: <Widget>[
                                  //           Container(
                                  //             padding: EdgeInsets.only(
                                  //               top: getWidth(context, 2),
                                  //               left: getWidth(context, 2),
                                  //               right: getWidth(context, 2),
                                  //               bottom: getWidth(context, 1),
                                  //             ),
                                  //             margin: const EdgeInsets.all(8.0),
                                  //             height: getWidth(context, 10),
                                  //             width: double.infinity,
                                  //             decoration: BoxDecoration(
                                  //               color: mainColorGrey
                                  //                   .withOpacity(0.5),
                                  //               borderRadius:
                                  //                   BorderRadius.circular(5),
                                  //             ),
                                  //             child: Center(
                                  //               child: Text(
                                  //                 "Select Location".tr,
                                  //                 style: TextStyle(
                                  //                   color: mainColorWhite,
                                  //                   fontSize: 20,
                                  //                   fontFamily: mainFontnormal,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //           SizedBox(
                                  //             height: getHeight(context, 40),
                                  //             child: Padding(
                                  //               padding:
                                  //                   const EdgeInsets.all(8.0),
                                  //               child: productrovider
                                  //                       .location.isNotEmpty
                                  //                   ? ListView.builder(
                                  //                       itemCount:
                                  //                           productrovider
                                  //                               .location
                                  //                               .length,
                                  //                       itemBuilder:
                                  //                           (BuildContext
                                  //                                   context,
                                  //                               int index) {
                                  //                         final location =
                                  //                             productrovider
                                  //                                     .location[
                                  //                                 index];
                                  //                         return Padding(
                                  //                           padding: EdgeInsets.only(
                                  //                               bottom:
                                  //                                   getHeight(
                                  //                                       context,
                                  //                                       1)),
                                  //                           child:
                                  //                               GestureDetector(
                                  //                             onTap: () {
                                  //                               cartProvider.addPastToCart(
                                  //                                   cartProvider
                                  //                                       .cartItemsPast);

                                  //                               Navigator.push(
                                  //                                 context,
                                  //                                 MaterialPageRoute(
                                  //                                     builder:
                                  //                                         (context) =>
                                  //                                             CheckOut()),
                                  //                               ).then((value) {
                                  //                                 cartProvider
                                  //                                     .clearCart();
                                  //                               });
                                  //                             },
                                  //                             child: Container(
                                  //                               decoration: BoxDecoration(
                                  //                                   color:
                                  //                                       mainColorLightGrey,
                                  //                                   borderRadius:
                                  //                                       BorderRadius.circular(
                                  //                                           5)),
                                  //                               child: ListTile(
                                  //                                 title: Text(
                                  //                                   location
                                  //                                       .name!,
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           mainColorGrey,
                                  //                                       fontSize:
                                  //                                           14,
                                  //                                       fontFamily:
                                  //                                           mainFontbold),
                                  //                                 ),
                                  //                                 subtitle:
                                  //                                     Text(
                                  //                                   location
                                  //                                       .area!,
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           mainColorGrey,
                                  //                                       fontSize:
                                  //                                           14,
                                  //                                       fontFamily:
                                  //                                           mainFontnormal),
                                  //                                 ),
                                  //                                 trailing:
                                  //                                     Text(
                                  //                                   "Select".tr,
                                  //                                   style: TextStyle(
                                  //                                       color:
                                  //                                           mainColorRed,
                                  //                                       fontFamily:
                                  //                                           mainFontnormal),
                                  //                                 ),
                                  //                               ),
                                  //                             ),
                                  //                           ),
                                  //                         );
                                  //                       })
                                  //                   : Center(
                                  //                       child: Text(
                                  //                       "Not have any location"
                                  //                           .tr,
                                  //                       style: TextStyle(
                                  //                         color: mainColorGrey,
                                  //                         fontSize: 20,
                                  //                       ),
                                  //                     )),
                                  //             ),
                                  //           ),
                                  //           Padding(
                                  //             padding: EdgeInsets.symmetric(
                                  //                 horizontal:
                                  //                     getWidth(context, 4)),
                                  //             child: TextButton(
                                  //               onPressed: () {
                                  //                 Navigator.pop(context);
                                  //                 Navigator.push(
                                  //                   context,
                                  //                   MaterialPageRoute(
                                  //                       builder: (context) =>
                                  //                           const Map_screen()),
                                  //                 );
                                  //               },
                                  //               style: ElevatedButton.styleFrom(
                                  //                 backgroundColor: mainColorRed,
                                  //                 fixedSize: Size(
                                  //                     getWidth(context, 85),
                                  //                     getHeight(context, 6)),
                                  //                 shape: RoundedRectangleBorder(
                                  //                   borderRadius:
                                  //                       BorderRadius.circular(
                                  //                           5),
                                  //                 ),
                                  //               ),
                                  //               child: Text(
                                  //                 "Add another location".tr,
                                  //                 style: TextStyle(
                                  //                   color: mainColorWhite,
                                  //                   fontSize: 16,
                                  //                 ),
                                  //               ),
                                  //             ),
                                  //           ),
                                  //         ],
                                  //       ),
                                  //     );
                                  //   },
                                  // );
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => CheckOut(
                                            cartProvider
                                                .calculateTotalPricePast(
                                                    CardItemshow))),
                                  );
                                },
                                style: TextButton.styleFrom(
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
                                        builder: (context) =>
                                            const NavSwitch()),
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
                        SizedBox(
                          height: getWidth(context, 2),
                        )
                      ],
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }
}
