import 'package:athome/Config/my_widget.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/map/maps.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../main.dart';
import 'check_out.dart';

class MyCart extends StatefulWidget {
  const MyCart({super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  update(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);
    productrovider.updatePost();
  }

  @override
  void initState() {
    //update(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListId());
    int total = cartProvider.calculateTotalPrice(CardItemshow);
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
                  if (cartProvider.cartItems.isNotEmpty) {
                    AwesomeDialog(
                            context: context,
                            animType: AnimType.scale,
                            dialogType: DialogType.question,
                            showCloseIcon: true,
                            title: 'Clear My cart',
                            desc: "You want delete all items in cart",
                            btnOkColor: mainColorRed,
                            btnCancelOnPress: () {},
                            btnOkText: "Delete",
                            btnOkOnPress: () {
                              cartProvider.clearCart();

                              Navigator.pop(context);
                            },
                            btnCancelColor: mainColorGrey)
                        .show();
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
        body: cartProvider.cartItems.isNotEmpty
            ? Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 6,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                          itemCount: cartProvider.cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cartitem = CardItemshow[index];
                            final cartitemQ = cartProvider.cartItems[index];
                            return Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    cartProvider.deleteitem(cartitemQ.product);
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
                                      borderRadius: BorderRadius.circular(15.0),
                                    ),
                                    child: Container(
                                      width: getWidth(context, 80),
                                      height: getHeight(context, 12),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(8),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Container(
                                              width: getWidth(context, 20),
                                              height: getHeight(context, 10),
                                              decoration: BoxDecoration(
                                                color: const Color(0xffF2F2F2),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: Center(
                                                child: CachedNetworkImage(
                                                  imageUrl: cartitem.coverImg
                                                      .toString(),
                                                  width: getWidth(context, 20),
                                                  height:
                                                      getHeight(context, 10),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                SizedBox(
                                                  width: getWidth(context, 30),
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
                                                      "${cartitem.price!} IQD",
                                                      style: TextStyle(
                                                          decoration: cartitem
                                                                      .offerPrice! >
                                                                  -1
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                          color: mainColorGrey,
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 10),
                                                    ),
                                                    cartitem.offerPrice! > -1
                                                        ? Text(
                                                            "${cartitem.offerPrice!} IQD",
                                                            style: TextStyle(
                                                                color:
                                                                    mainColorRed,
                                                                fontFamily:
                                                                    mainFontbold,
                                                                fontSize: 10),
                                                          )
                                                        : const SizedBox(),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    // Text(
                                                    //   "info: ".tr,
                                                    //   style: TextStyle(
                                                    //       color: mainColorGrey,
                                                    //       fontFamily: mainFontnormal,
                                                    //       fontSize: 12,
                                                    //       ),
                                                    // ),

                                                    // limit letter of info in cart items
                                                    Text(
                                                      lang == "en"
                                                          ? textCount(
                                                              cartitem
                                                                  .contentsEn
                                                                  .toString(),
                                                              20)
                                                          : lang == "ar"
                                                              ? textCount(
                                                                  cartitem
                                                                      .contentsAr
                                                                      .toString(),
                                                                  20)
                                                              : textCount(
                                                                  cartitem
                                                                      .contentsKu
                                                                      .toString(),
                                                                  20),
                                                      style: TextStyle(
                                                        color: mainColorGrey,
                                                        fontFamily:
                                                            mainFontnormal,
                                                        fontSize: 12,
                                                      ),
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
                                                              -1 &&
                                                          cartitem.orderLimit ==
                                                              cartProvider
                                                                  .calculateQuantityForProduct(
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
                                                              .product);
                                                      cartProvider
                                                          .addToCart(cartItem);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                              .product);
                                                      cartProvider
                                                          .removeFromCart(
                                                              cartItem);
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              2.0),
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
                                                              color:
                                                                  mainColorWhite,
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
                  Expanded(
                    flex: 3,
                    child: Container(
                      decoration: BoxDecoration(
                          color: mainColorGrey,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(25),
                            topRight: Radius.circular(25),
                          )),
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
                            child: TextButton(
                              onPressed: () async {
                                if (await noInternet(context)) {
                                  return;
                                }

                                // ignore: use_build_context_synchronously
                                showModalBottomSheet(
                                  context: context,
                                  isDismissible: true,
                                  shape: const RoundedRectangleBorder(
                                    // <-- SEE HERE
                                    borderRadius: BorderRadius.vertical(
                                      top: Radius.circular(25.0),
                                    ),
                                  ),
                                  builder: (BuildContext context) {
                                    return Container(
                                      color: mainColorWhite,
                                      child: Column(
                                        children: <Widget>[
                                          Container(
                                            padding: EdgeInsets.only(
                                              top: getWidth(context, 2),
                                              left: getWidth(context, 2),
                                              right: getWidth(context, 2),
                                              bottom: getWidth(context, 1),
                                            ),
                                            margin: const EdgeInsets.all(8.0),
                                            height: getWidth(context, 10),
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color: mainColorGrey
                                                  .withOpacity(0.5),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "Select Location",
                                                style: TextStyle(
                                                  color: mainColorWhite,
                                                  fontSize: 20,
                                                  fontFamily: mainFontnormal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: getHeight(context, 40),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: productrovider
                                                      .location.isNotEmpty
                                                  ? ListView.builder(
                                                      itemCount: productrovider
                                                          .location.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        final location =
                                                            productrovider
                                                                    .location[
                                                                index];
                                                        return Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  bottom:
                                                                      getHeight(
                                                                          context,
                                                                          1)),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) =>
                                                                        CheckOut(
                                                                            id: location.id!)),
                                                              );
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  color:
                                                                      mainColorLightGrey,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              5)),
                                                              child: ListTile(
                                                                title: Text(
                                                                  location
                                                                      .name!,
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainColorGrey,
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          mainFontbold),
                                                                ),
                                                                subtitle: Text(
                                                                  location
                                                                      .area!,
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainColorGrey,
                                                                      fontSize:
                                                                          14,
                                                                      fontFamily:
                                                                          mainFontnormal),
                                                                ),
                                                                trailing: Text(
                                                                  "Select",
                                                                  style: TextStyle(
                                                                      color:
                                                                          mainColorRed,
                                                                      fontFamily:
                                                                          mainFontnormal),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        );
                                                      })
                                                  : Center(
                                                      child: Text(
                                                      "Not have any location",
                                                      style: TextStyle(
                                                        color: mainColorGrey,
                                                        fontSize: 20,
                                                      ),
                                                    )),
                                            ),
                                          ),
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal:
                                                    getWidth(context, 4)),
                                            child: TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const Maps_screen()),
                                                );
                                              },
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor: mainColorRed,
                                                fixedSize: Size(
                                                    getWidth(context, 85),
                                                    getHeight(context, 6)),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: Text(
                                                "Add another location".tr,
                                                style: TextStyle(
                                                  color: mainColorWhite,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: mainColorRed,
                                fixedSize: Size(getWidth(context, 80),
                                    getHeight(context, 6)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              child: Text(
                                "Checkout".tr,
                                style: TextStyle(
                                  color: mainColorWhite,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: getWidth(context, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
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
                      "Your cart is empty",
                      style:
                          TextStyle(fontFamily: mainFontnormal, fontSize: 16),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
