import 'package:athome/Config/my_widget.dart';
import 'package:athome/Config/value.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/model/cart.dart';
import 'package:athome/model/product_model/product_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:athome/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/athome_functions.dart';
import '../main.dart';
import 'check_out.dart';

class MyCart extends StatefulWidget {
  bool back = false;
  MyCart(this.back, {super.key});

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
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
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListId());

    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: productrovider.nointernetCheck
          ? noInternetWidget(context)
          : Scaffold(
              backgroundColor: mainColorWhite,
              appBar: AppBar(
                title: Text(
                  "My Cart".tr,
                  style: TextStyle(
                      color: mainColorGrey,
                      fontFamily: mainFontnormal,
                      fontSize: 24),
                ),
                leading: widget.back
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: mainColorRed,
                        ))
                    : const SizedBox(),
                centerTitle: true,
                backgroundColor: mainColorWhite,
                elevation: 0,
                actions: [
                  cartProvider.cartItems.isEmpty
                      ? const SizedBox()
                      : IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Stack(
                                    alignment: lang == "en"
                                        ? Alignment.topLeft
                                        : Alignment.topRight,
                                    children: [
                                      SizedBox(
                                        width: getWidth(context, 70),
                                        height: getHeight(context, 50),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Image.asset(
                                              "assets/images/003_welcome_1.png",
                                              width: getWidth(context, 40),
                                              height: getWidth(context, 40),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            Text(
                                              "Login Please".tr,
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              style: TextStyle(
                                                color: mainColorGrey,
                                                fontFamily: mainFontbold,
                                                fontSize: 25,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            Text(
                                              "You need login to add item to favourite"
                                                  .tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                color: mainColorGrey,
                                                fontFamily: mainFontnormal,
                                                fontSize: 16,
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                cartProvider.clearCart();
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(
                                                    getWidth(context, 70),
                                                    getHeight(context, 5)),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: mainColorRed),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: Text(
                                                "Clear".tr,
                                                style: TextStyle(
                                                  color: mainColorRed,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              style: ElevatedButton.styleFrom(
                                                fixedSize: Size(
                                                    getWidth(context, 70),
                                                    getHeight(context, 5)),
                                                shape: RoundedRectangleBorder(
                                                  side: BorderSide(
                                                      color: mainColorGrey),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                ),
                                              ),
                                              child: Text(
                                                "Cancle".tr,
                                                style: TextStyle(
                                                  color: mainColorGrey,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          icon: const Icon(Icons.close))
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.delete_outline,
                            color: mainColorRed,
                          )),
                ],
              ),
              body: cartProvider.cartItems.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: ListView.builder(
                          itemCount: cartProvider.cartItems.length,
                          itemBuilder: (BuildContext context, int index) {
                            final cartitem = CardItemshow[index];
                            final cartitemQ = cartProvider.cartItems[index];
                            return Dismissible(
                              key: Key(cartitem.id.toString()),
                              direction: DismissDirection.startToEnd,
                              onDismissed: (direction) {
                                String name = lang == "en"
                                    ? cartitem.nameEn.toString()
                                    : lang == "ar"
                                        ? cartitem.nameAr.toString()
                                        : cartitem.nameKu.toString();
                                cartProvider.deleteitem(cartitemQ.product);
                                CardItemshow = productrovider
                                    .getProductsByIds(cartProvider.ListId());

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
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
                                                color: mainColorBlack
                                                    .withOpacity(0.1)),
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl: imageUrlServer +
                                                  cartitem.coverImg!,
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
                                                        ? cartitem.nameAr
                                                            .toString()
                                                        : cartitem.nameKu
                                                            .toString(),
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
                                                    ? cartitem.contentsEn
                                                        .toString()
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
                                                          checkOferPrice(
                                                                  cartitem)
                                                              ? TextDecoration
                                                                  .lineThrough
                                                              : TextDecoration
                                                                  .none,
                                                      color: checkOferPrice(
                                                              cartitem)
                                                          ? mainColorRed
                                                          : Colors.green,
                                                      fontFamily:
                                                          checkOferPrice(
                                                                  cartitem)
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
                                                            cartitem
                                                                .offerPrice!),
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                            color: Colors.green,
                                                            fontFamily:
                                                                mainFontbold,
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
                                            borderRadius:
                                                BorderRadius.circular(5),
                                            color: mainColorWhite,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              GestureDetector(
                                                onTap: checkProductStock(
                                                            cartitem,
                                                            cartitemQ
                                                                .quantity) ||
                                                        checkProductLimit(
                                                            cartitem,
                                                            cartitemQ.quantity)
                                                    ? null
                                                    : () {
                                                        final cartItem = CartItem(
                                                            product: cartitemQ
                                                                .product);
                                                        cartProvider.addToCart(
                                                            cartItem);
                                                      },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
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
                                                                  .withOpacity(
                                                                      0.5)
                                                              : Colors.green)),
                                                  child: Icon(Icons.add,
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
                                                          : Colors.green,
                                                      size: getHeight(
                                                          context, 2.5)),
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
                                                  final cartItem = CartItem(
                                                      product:
                                                          cartitemQ.product);
                                                  cartProvider
                                                      .removeFromCart(cartItem);
                                                },
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                      border: Border.all(
                                                          color: mainColorRed)),
                                                  child: Icon(Icons.remove,
                                                      color: mainColorRed,
                                                      size: getHeight(
                                                          context, 2.5)),
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
                            child:
                                Image.asset("assets/images/gif_favorite.gif"),
                          ),
                          Text(
                            "Your cart is empty".tr,
                            style: TextStyle(
                                fontFamily: mainFontnormal, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
              bottomNavigationBar: productrovider.nointernetCheck
                  ? noInternetWidget(context)
                  : cartProvider.cartItems.isNotEmpty
                      ? Container(
                          height: getHeight(context, 29),
                          decoration: BoxDecoration(
                            color: mainColorWhite,
                            // borderRadius: const BorderRadius.only(
                            //   topLeft: Radius.circular(25),
                            //   topRight: Radius.circular(25),
                            // ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: getHeight(context, 3),
                              ),
                              SizedBox(
                                height: getHeight(context, 1),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: getWidth(context, 4)),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          .calculateTotalPrice(CardItemshow)),
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          .calculateTotalPrice(CardItemshow)),
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
                                child: TextButton(
                                  onPressed: () async {
                                    if (await noInternet(context)) {
                                      return;
                                    }
                                    if (cartProvider
                                            .calculateTotalPrice(CardItemshow) <
                                        productrovider.minimumOrder) {
                                      toastLong("minimum order");
                                      return;
                                    }
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => CheckOut(
                                              cartProvider.calculateTotalPrice(
                                                  CardItemshow))),
                                    );
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 90),
                                        getHeight(context, 6)),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                  ),
                                  child: Text(
                                    "Checkout".tr,
                                    style: TextStyle(
                                      color: mainColorWhite,
                                      fontSize: 18,
                                    ),
                                  ),
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
