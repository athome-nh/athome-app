import 'dart:async';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/model/cart.dart';
import 'package:dllylas/model/product_model/product_model.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:dllylas/Config/property.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
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
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    final productrovider = Provider.of<productProvider>(context, listen: true);

    List<ProductModel> CardItemshow =
        productrovider.getProductsByIds(cartProvider.ListId());

    return productrovider.nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              // AppBar
              appBar: AppBar(
                title: Text(
                  "My Cart".tr,
                ),
                leading: widget.back
                    ? IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios,
                        ))
                    : const SizedBox(),
                actions: [
                  cartProvider.cartItems.isEmpty || !isLogin
                      ? const SizedBox()
                      : IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Directionality(
                                    textDirection: lang == "en"
                                        ? TextDirection.ltr
                                        : TextDirection.rtl,
                                    child: Stack(
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
                                                "assets/Victors/sure.png",
                                                width: getWidth(context, 40),
                                                height: getWidth(context, 40),
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                "Clear cart".tr,
                                                textAlign: TextAlign.center,
                                                maxLines: 1,
                                                style: TextStyle(
                                                  color: mainColorBlack,
                                                  fontFamily: mainFontbold,
                                                  fontSize: 25,
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                "Are you sure you want to continue?"
                                                    .tr,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: mainColorBlack,
                                                  fontFamily: mainFontnormal,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              TextButton(
                                                onPressed: () {
                                                  cartProvider.clearCart();
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  fixedSize: Size(
                                                      getWidth(context, 70),
                                                      getHeight(context, 5)),
                                                  backgroundColor: mainColorRed,
                                                ),
                                                child: Text(
                                                  "Clear".tr,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                style: TextButton.styleFrom(
                                                  fixedSize: Size(
                                                      getWidth(context, 70),
                                                      getHeight(context, 5)),
                                                ),
                                                child: Text(
                                                  "Cancel".tr,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            icon: Icon(
                                              Icons.close,
                                              color: mainColorBlack,
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                ],
              ),

              // Body
              body: !productrovider.show
                  ? Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Skeletonizer(
                        effect: ShimmerEffect.raw(colors: [
                          mainColorGrey.withOpacity(0.1),
                          mainColorWhite,
                          // mainColorRed.withOpacity(0.1),
                        ]),
                        enabled: true,
                        child: ListView.builder(
                            itemCount: 10,
                            itemBuilder: (BuildContext context, int index) {
                              return Column(
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
                                            color: mainColorWhite,
                                            border: Border.all(
                                                color: mainColorBlack
                                                    .withOpacity(0.1)),
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          child: Center(
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  dotenv.env['imageUrlServer']!,
                                              placeholder: (context, url) =>
                                                  Image.asset(
                                                      "assets/images/home.png"),
                                              errorWidget: (context, url,
                                                      error) =>
                                                  Image.asset(
                                                      "assets/images/home.png"),
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
                                                "sxcsascasc",
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
                                                "500g",
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
                                                  addCommasToPrice(2000),
                                                  maxLines: 1,
                                                  style: TextStyle(
                                                      decoration:
                                                          TextDecoration.none,
                                                      color: Colors.green,
                                                      fontFamily: mainFontbold,
                                                      fontSize: 14),
                                                ),
                                                const SizedBox(),
                                              ],
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        Container(
                                          width: getWidth(context, 28),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Skeleton.leaf(
                                                child: Container(
                                                  width: getHeight(context, 4),
                                                  height: getHeight(context, 4),
                                                  decoration: BoxDecoration(
                                                      color: mainColorRed,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.remove,
                                                      color: mainColorWhite,
                                                      size:
                                                          getHeight(context, 2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Text(
                                                "01",
                                                style: TextStyle(
                                                    color: mainColorRed,
                                                    fontFamily: mainFontnormal,
                                                    fontSize: 20),
                                              ),
                                              Skeleton.leaf(
                                                child: Container(
                                                  width: getHeight(context, 4),
                                                  height: getHeight(context, 4),
                                                  decoration: BoxDecoration(
                                                      color: mainColorRed,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100)),
                                                  child: IconButton(
                                                    onPressed: () {},
                                                    icon: Icon(
                                                      Icons.add,
                                                      color: mainColorWhite,
                                                      size:
                                                          getHeight(context, 2),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  const Divider()
                                ],
                              );
                            }),
                      ),
                    )
                  : !isLogin
                      ? loginFirstContainer(context)
                      : cartProvider.cartItems.isNotEmpty
                          ? Visibility(
                              replacement: Center(child: waitingWiget(context)),
                              visible: productrovider.show,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 5),
                                child: ListView.builder(
                                    itemCount: cartProvider.cartItems.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final cartitemQ =
                                          cartProvider.cartItems[index];
                                      final cartitem = productrovider
                                          .getoneProductById(cartitemQ.product);

                                      return Dismissible(
                                        key: Key(cartitem.id.toString()),
                                        direction: DismissDirection.startToEnd,
                                        onDismissed: (direction) {
                                          String name = lang == "en"
                                              ? cartitem.nameEn.toString()
                                              : lang == "ar"
                                                  ? cartitem.nameAr.toString()
                                                  : cartitem.nameKu.toString();
                                          cartProvider
                                              .deleteitem(cartitemQ.product);
                                          CardItemshow =
                                              productrovider.getProductsByIds(
                                                  cartProvider.ListId());
                                          ScaffoldMessenger.of(context)
                                              .hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "Delete".tr + "$name",
                                              ),
                                            ),
                                          );
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          child: const Align(
                                            alignment: Alignment.centerLeft,
                                            child: Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20),
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
                                                    width:
                                                        getWidth(context, 20),
                                                    height:
                                                        getWidth(context, 20),
                                                    decoration: BoxDecoration(
                                                      color: mainColorWhite,
                                                      border: Border.all(
                                                          color: mainColorBlack
                                                              .withOpacity(
                                                                  0.1)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              15),
                                                    ),
                                                    child: Center(
                                                      child: CachedNetworkImage(
                                                        imageUrl: dotenv.env[
                                                                'imageUrlServer']! +
                                                            cartitem.coverImg!,
                                                        filterQuality:
                                                            FilterQuality.low,
                                                        width: getWidth(
                                                            context, 15),
                                                        height: getWidth(
                                                            context, 15),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: getWidth(context, 2),
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      SizedBox(
                                                        width: getWidth(
                                                            context, 40),
                                                        child: Text(
                                                          lang == "en"
                                                              ? cartitem.nameEn
                                                                  .toString()
                                                              : lang == "ar"
                                                                  ? cartitem
                                                                      .nameAr
                                                                      .toString()
                                                                  : cartitem
                                                                      .nameKu
                                                                      .toString(),
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color:
                                                                  mainColorBlack,
                                                              fontFamily:
                                                                  mainFontnormal,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: getHeight(
                                                            context, 1),
                                                      ),
                                                      SizedBox(
                                                        width: getWidth(
                                                            context, 40),
                                                        child: Text(
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
                                                          textAlign:
                                                              TextAlign.start,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                              color: mainColorGrey
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontFamily:
                                                                  mainFontbold,
                                                              fontSize: 11),
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Text(
                                                            addCommasToPrice(
                                                                cartitem.price2! >
                                                                        -1
                                                                    ? cartitem
                                                                        .price2!
                                                                    : cartitem
                                                                        .price!),
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                                decoration: checkOferPrice(
                                                                        cartitem)
                                                                    ? TextDecoration
                                                                        .lineThrough
                                                                    : TextDecoration
                                                                        .none,
                                                                color: checkOferPrice(
                                                                        cartitem)
                                                                    ? mainColorRed
                                                                    : Colors
                                                                        .green,
                                                                fontFamily: checkOferPrice(
                                                                        cartitem)
                                                                    ? mainFontnormal
                                                                    : mainFontbold,
                                                                fontSize: 14),
                                                          ),
                                                          checkOferPrice(
                                                                  cartitem)
                                                              ? const Text("/")
                                                              : const SizedBox(),
                                                          checkOferPrice(
                                                                  cartitem)
                                                              ? Text(
                                                                  addCommasToPrice(
                                                                          cartitem
                                                                              .offerPrice!)
                                                                      .tr,
                                                                  maxLines: 1,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .green,
                                                                      fontFamily:
                                                                          mainFontbold,
                                                                      fontSize:
                                                                          14),
                                                                )
                                                              : const SizedBox(),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                  const Spacer(),
                                                  Container(
                                                    width:
                                                        getWidth(context, 28),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Container(
                                                          width: getHeight(
                                                              context, 4),
                                                          height: getHeight(
                                                              context, 4),
                                                          decoration: BoxDecoration(
                                                              color:
                                                                  mainColorRed,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                          child: IconButton(
                                                            onPressed: () {
                                                              final cartItem =
                                                                  CartItem(
                                                                      product:
                                                                          cartitemQ
                                                                              .product);
                                                              cartProvider
                                                                  .removeFromCart(
                                                                      cartItem);
                                                            },
                                                            icon: Icon(
                                                              Icons.remove,
                                                              color:
                                                                  mainColorWhite,
                                                              size: getHeight(
                                                                  context, 2),
                                                            ),
                                                          ),
                                                        ),
                                                        Text(
                                                          cartitemQ.quantity
                                                                      .toString()
                                                                      .length ==
                                                                  1
                                                              ? "0" +
                                                                  cartitemQ
                                                                      .quantity
                                                                      .toString()
                                                                      .tr
                                                              : cartitemQ
                                                                  .quantity
                                                                  .toString()
                                                                  .tr,
                                                          style: TextStyle(
                                                              color:
                                                                  mainColorGrey,
                                                              fontFamily:
                                                                  mainFontnormal,
                                                              fontSize: 20),
                                                        ),
                                                        Container(
                                                          width: getHeight(
                                                              context, 4),
                                                          height: getHeight(
                                                              context, 4),
                                                          decoration: BoxDecoration(
                                                              color: checkProductStock(
                                                                          cartitem,
                                                                          cartitemQ
                                                                              .quantity) ||
                                                                      checkProductLimit(
                                                                          cartitem,
                                                                          cartitemQ
                                                                              .quantity)
                                                                  ? lightGrey
                                                                  : mainColorGrey,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          100)),
                                                          child: IconButton(
                                                            onPressed: checkProductStock(
                                                                        cartitem,
                                                                        cartitemQ
                                                                            .quantity) ||
                                                                    checkProductLimit(
                                                                        cartitem,
                                                                        cartitemQ
                                                                            .quantity)
                                                                ? null
                                                                : () {
                                                                    final cartItem =
                                                                        CartItem(
                                                                            product:
                                                                                cartitemQ.product);

                                                                    cartProvider
                                                                        .addToCart(
                                                                            cartItem);
                                                                  },
                                                            icon: Icon(
                                                              Icons.add,
                                                              color: checkProductStock(
                                                                          cartitem,
                                                                          cartitemQ
                                                                              .quantity) ||
                                                                      checkProductLimit(
                                                                          cartitem,
                                                                          cartitemQ
                                                                              .quantity)
                                                                  ? mainColorBlack
                                                                      .withOpacity(
                                                                          0.5)
                                                                  : mainColorWhite,
                                                              size: getHeight(
                                                                  context, 2),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            const Divider()
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                            )
                          : Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: getWidth(context, 100),
                                    height: getWidth(context, 100),
                                    child: Image.asset(
                                        "assets/Victors/cart_empty.png"),
                                  ),
                                  SizedBox(
                                    height: getHeight(context, 2),
                                  ),
                                  Text(
                                    "Your cart is empty".tr,
                                    style: TextStyle(
                                        fontFamily: mainFontnormal,
                                        fontSize: 18),
                                  ),
                                ],
                              ),
                            ),
              bottomNavigationBar: productrovider.nointernetCheck
                  ? noInternetWidget(context)
                  : !productrovider.show

                      // Shimmer
                      ? Skeletonizer(
                          effect: ShimmerEffect.raw(colors: [
                            mainColorGrey.withOpacity(0.1),
                            mainColorWhite,
                            // mainColorRed.withOpacity(0.1),
                          ]),
                          enabled: true,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: getWidth(context, 4),
                                vertical: getHeight(context, 2)),
                            child: TextButton(
                              onPressed: () async {},
                              style: TextButton.styleFrom(
                                fixedSize: Size(getWidth(context, 90),
                                    getHeight(context, 6)),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text("Total".tr +
                                      ": " +
                                      addCommasToPrice(2500)),
                                  Text(
                                    "Checkout".tr,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : cartProvider.cartItems.isNotEmpty && isLogin
                          ? Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: getWidth(context, 4),
                                  vertical: getHeight(context, 2)),
                              child: TextButton(
                                onPressed: () async {
                                  if (await noInternet(context)) {
                                    return;
                                  }
                                  if (cartProvider
                                          .calculateTotalPrice(CardItemshow) <
                                      productrovider.minimumOrder) {
                                    // ignore: use_build_context_synchronously
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          content: Directionality(
                                            textDirection: lang == "en"
                                                ? TextDirection.ltr
                                                : TextDirection.rtl,
                                            child: Stack(
                                              alignment: lang == "en"
                                                  ? Alignment.topLeft
                                                  : Alignment.topRight,
                                              children: [
                                                SizedBox(
                                                  width: getWidth(context, 70),
                                                  height:
                                                      getHeight(context, 45),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    //textcheck
                                                    children: <Widget>[
                                                      Image.asset(
                                                        "assets/Victors/minum.png",
                                                        width: getWidth(
                                                            context, 40),
                                                        height: getWidth(
                                                            context, 40),
                                                      ),
                                                      Text(
                                                        "min title".tr,
                                                        textAlign:
                                                            TextAlign.center,
                                                        maxLines: 1,
                                                        style: TextStyle(
                                                          color: mainColorBlack,
                                                          fontFamily:
                                                              mainFontbold,
                                                          fontSize: 22,
                                                        ),
                                                      ),
                                                      Text(
                                                        "min deatil"
                                                            .tr
                                                            .toString()
                                                            .replaceAll(
                                                                "temp",
                                                                addCommasToPrice(
                                                                        productrovider
                                                                            .minimumOrder)
                                                                    .replaceAll(
                                                                        "IQD",
                                                                        "")),
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: mainColorBlack,
                                                          fontFamily:
                                                              mainFontnormal,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 40),
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        style: TextButton
                                                            .styleFrom(
                                                          fixedSize: Size(
                                                              getWidth(
                                                                  context, 70),
                                                              getHeight(
                                                                  context, 5)),
                                                        ),
                                                        child: Text(
                                                          "OK".tr,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    icon:
                                                        const Icon(Icons.close))
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );

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
                                style: TextButton.styleFrom(
                                  fixedSize: Size(getWidth(context, 90),
                                      getHeight(context, 6)),
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text("Total".tr +
                                        ": " +
                                        addCommasToPrice(
                                            cartProvider.calculateTotalPrice(
                                                CardItemshow))),
                                    Text(
                                      "Checkout".tr,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : const SizedBox(),
            ),
          );
  }
}
