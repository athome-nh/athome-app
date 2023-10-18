// ignore_for_file: sized_box_for_whitespace

import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/login_page.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cart.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:loading_indicator/loading_indicator.dart';

import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../home/oneitem.dart';

Widget listItemsShow(BuildContext context, var data) {
  final productPro = Provider.of<productProvider>(context, listen: true);
  final cartProvider = Provider.of<CartProvider>(context, listen: true);
  return Visibility(
    visible: productPro.show,
    replacement: Skeletonizer(
      enabled: true,
      child: Container(
        height: getHeight(context, 90),
        width: getWidth(context, 95),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: getWidth(context, 0.15),
          ),

          itemCount: 8, // Number of items in the grid
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
              child: Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: lang == "en"
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      children: [
                        Stack(
                          alignment: lang == "en"
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          children: [
                            Container(
                              width: getHeight(context, 20),
                              height: getHeight(context, 20),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: "",
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/002_logo_1.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/002_logo_1.png"),
                                  width: getHeight(context, 18),
                                  height: getHeight(context, 18),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(6.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: mainColorGrey.withOpacity(0.2)),
                                child: SizedBox(),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Stack(
                      alignment: lang == "en"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      children: [
                        Container(
                          width: getWidth(context, 100),
                          height: getHeight(context, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  "product.nameKu.toString()",
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: mainColorGrey,
                                      fontFamily: mainFontbold,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                "product.contentsKu.toString()",
                                maxLines: 1,
                                style: TextStyle(
                                    color: mainColorGrey.withOpacity(0.5),
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                addCommasToPrice(15000),
                                style: TextStyle(
                                    decoration: TextDecoration.none,
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            width: getWidth(context, 8),
                            height: getHeight(context, 3.5),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                border: Border.all(
                                    color: mainColorGrey.withOpacity(0.5)),
                                color: mainColorGrey),
                            child: SizedBox()),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    ),
    child: Container(
      height: getHeight(context, 90),
      width: getWidth(context, 95),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: getWidth(context, 0.15),
        ),

        itemCount: data.length, // Number of items in the grid
        itemBuilder: (BuildContext context, int index) {
          final product = data[index];
          final isItemInCart = cartProvider.itemExistsInCart(product);
          final isFavInCart = cartProvider.FavExistsInCart(product);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: getWidth(context, 2)),
            child: GestureDetector(
              onTap: () {
                productPro.setidItem(product.id!);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Oneitem()),
                );
              },
              child: Container(
                // decoration: BoxDecoration(border: Border.all()),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      alignment: lang == "en"
                          ? Alignment.bottomLeft
                          : Alignment.bottomRight,
                      children: [
                        Stack(
                          alignment: lang == "en"
                              ? Alignment.topRight
                              : Alignment.topLeft,
                          children: [
                            Container(
                              width: getHeight(context, 20),
                              height: getHeight(context, 20),
                              decoration: BoxDecoration(
                                  color: const Color(0xffF2F2F2),
                                  borderRadius: BorderRadius.circular(5)),
                              child: Center(
                                child: CachedNetworkImage(
                                  imageUrl: product.coverImg!,
                                  placeholder: (context, url) => Image.asset(
                                      "assets/images/002_logo_1.png"),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                          "assets/images/002_logo_1.png"),
                                  width: getHeight(context, 18),
                                  height: getHeight(context, 18),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                if (!isLogin) {
                                  AwesomeDialog(
                                          context: context,
                                          animType: AnimType.scale,
                                          dialogType: DialogType.info,
                                          showCloseIcon: true,
                                          title: 'Login Please',
                                          desc:
                                              "You need login to add item in cart",
                                          btnOkColor: mainColorRed,
                                          btnCancelOnPress: () {},
                                          btnOkText: "Login",
                                          btnOkOnPress: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const RegisterWithPhoneNumber()),
                                            );
                                          },
                                          btnCancelColor: mainColorGrey)
                                      .show();

                                  return;
                                }
                                final cartItem = CartItem(product: product.id!);
                                cartProvider.addFavToCart(cartItem);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color: isFavInCart
                                          ? mainColorRed.withOpacity(0.1)
                                          : mainColorGrey.withOpacity(0.2)),
                                  child: isFavInCart
                                      ? Icon(FontAwesomeIcons.heartCircleCheck,
                                          color: mainColorRed,
                                          size: getHeight(context, 2.5))
                                      : Icon(FontAwesomeIcons.heartCirclePlus,
                                          color: mainColorWhite,
                                          size: getHeight(context, 2.5)),
                                ),
                              ),
                            ),
                          ],
                        ),
                        product.offerPrice! > -1
                            ? Container(
                                width: getHeight(context, 8),
                                height: getHeight(context, 3),
                                decoration: BoxDecoration(
                                  borderRadius: lang == "en"
                                      ? const BorderRadius.only(
                                          //  topLeft: Radius.circular(20.0),
                                          topRight: Radius.circular(20.0),
                                          // bottomLeft: Radius.circular(0.0),
                                          bottomRight: Radius.circular(20.0),
                                        )
                                      : const BorderRadius.only(
                                          topLeft: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                        ),
                                  color: mainColorRed,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      calculatePercentageDiscount(
                                          double.parse(product.price2 > -1
                                              ? product.price2!.toString()
                                              : product.price!.toString()),
                                          double.parse(
                                              product.offerPrice!.toString())),
                                      style: TextStyle(
                                          color: mainColorWhite,
                                          fontFamily: mainFontnormal,
                                          fontSize: 12),
                                    ),
                                    Icon(Icons.discount_rounded,
                                        color: mainColorWhite, size: 12),
                                  ],
                                ))
                            : const SizedBox(),
                      ],
                    ),
                    Stack(
                      alignment: lang == "en"
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      children: [
                        Container(
                          width: getWidth(context, 100),
                          height: getHeight(context, 12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flexible(
                                child: Text(
                                  lang == "en"
                                      ? product.nameEn.toString()
                                      : lang == "ar"
                                          ? product.nameAr.toString()
                                          : product.nameKu.toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: mainColorGrey,
                                      fontFamily: mainFontbold,
                                      fontSize: 14),
                                ),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                lang == "en"
                                    ? product.contentsEn.toString()
                                    : lang == "ar"
                                        ? product.contentsAr.toString()
                                        : product.contentsKu.toString(),
                                maxLines: 1,
                                style: TextStyle(
                                    color: mainColorGrey.withOpacity(0.5),
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              Text(
                                addCommasToPrice(product.price2 > -1
                                    ? product.price2!
                                    : product.price!),
                                style: TextStyle(
                                    decoration: product.offerPrice! > -1
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none,
                                    color: mainColorGrey,
                                    fontFamily: mainFontnormal,
                                    fontSize: 14),
                              ),
                              product.offerPrice! > -1
                                  ? Text(
                                      addCommasToPrice(product.offerPrice!),
                                      style: TextStyle(
                                          color: mainColorRed,
                                          fontFamily: mainFontbold,
                                          fontSize: 14),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (!isLogin) {
                              AwesomeDialog(
                                      context: context,
                                      animType: AnimType.scale,
                                      dialogType: DialogType.info,
                                      showCloseIcon: true,
                                      title: 'Login Please',
                                      desc:
                                          "You need login to add item in cart",
                                      btnOkColor: mainColorRed,
                                      btnCancelOnPress: () {},
                                      btnOkText: "Login",
                                      btnOkOnPress: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const RegisterWithPhoneNumber()),
                                        );
                                      },
                                      btnCancelColor: mainColorGrey)
                                  .show();
                              return;
                            }
                            if (product.offerPrice! > -1 &&
                                product.orderLimit ==
                                    cartProvider.calculateQuantityForProduct(
                                        int.parse(product.id.toString()))) {
                              toastLong("you can not add more this item");
                              return;
                            }
                            final cartItem = CartItem(product: product.id!);
                            cartProvider.addToCart(cartItem);
                          },
                          child: Container(
                              width: getWidth(context, 8),
                              height: getHeight(context, 3.5),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  border: Border.all(
                                      color: mainColorGrey.withOpacity(0.5)),
                                  color: mainColorGrey),
                              child: isItemInCart
                                  ? Center(
                                      child: Text(
                                        cartProvider
                                            .calculateQuantityForProduct(
                                                int.parse(
                                                    product.id.toString()))
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            color: mainColorWhite),
                                      ),
                                    )
                                  : Icon(FontAwesomeIcons.cartShopping,
                                      color: mainColorWhite,
                                      size: getHeight(context, 2))),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}

///// here we check for internet availability
Future<bool> checkInternet(BuildContext context) async {
  bool retrive = false;
  var connectivityResult = await (Connectivity().checkConnectivity());
  if (connectivityResult == ConnectivityResult.mobile) {
    retrive = false;
  } else if (connectivityResult == ConnectivityResult.wifi) {
    retrive = false;
  } else {
    retrive = true;
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Container(
          child: Text(
            'No internet connection, check your connection',
            style: TextStyle(
              color: mainColorWhite,
              fontFamily: "RK",
            ),
          ),
        ),
        backgroundColor: mainColorGrey,
      ),
    );
  }
  return retrive;
}

Future noInternet(BuildContext context) {
  return checkInternet(context);
}

SnackBar noInternetSnackBar = SnackBar(
  duration: const Duration(seconds: 4),
  content: Text(
    'You\'re offline, connect to a network.'.tr,
    style: TextStyle(fontFamily: mainFontnormal),
  ),
  backgroundColor: mainColorGrey,
);
SnackBar internetBackSnackBar = SnackBar(
  duration: const Duration(seconds: 3),
  content: Text(
    'You\'re online ✅'.tr,
    style: TextStyle(fontFamily: mainFontnormal),
  ),
  backgroundColor: Colors.green,
);

Future toastShort(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

Future toastLong(
  String message,
) {
  return Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: mainColorRed.withOpacity(0.5),
      textColor: Colors.white,
      fontSize: 14.0);
}

Widget WaitingWiget(BuildContext context) {
  return Container(
    height: getWidth(context, 40),
    child: LoadingIndicator(
      indicatorType: Indicator.ballRotateChase,
      colors: [
        mainColorGrey,
        mainColorRed,
        mainColorSuger,
      ],

      // strokeWidth: 5,
    ),
  );
}

cartEmptyContainer(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: getHeight(context, 12),
          width: getWidth(context, 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColorRed,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Icon(
            Icons.warning_amber_outlined,
            size: 70,
            color: mainColorWhite,
          ),
        ),
        Container(
          height: getHeight(context, 30),
          width: getWidth(context, 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColorGrey,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Warning',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: mainFontbold,
                    color: mainColorWhite),
              ),
              const SizedBox(height: 20),
              Text(
                'Your cart is empty',
                style: TextStyle(
                    fontSize: 18,
                    fontFamily: mainFontnormal,
                    color: mainColorWhite),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

loginFirstContainer(BuildContext context) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: getHeight(context, 12),
          width: getWidth(context, 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColorRed,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          ),
          child: Icon(
            Icons.warning_amber_outlined,
            size: 70,
            color: mainColorWhite,
          ),
        ),
        Container(
          height: getHeight(context, 30),
          width: getWidth(context, 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColorGrey,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Confirm',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: mainFontbold,
                    color: mainColorWhite),
              ),
              const SizedBox(height: 20),
              Text(
                'You must login first',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: mainFontnormal,
                    color: mainColorWhite),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: getHeight(context, 5),
                width: getWidth(context, 60),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const RegisterWithPhoneNumber()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColorRed),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: mainColorWhite,
                        fontSize: 22,
                        fontFamily: mainFontnormal),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

nullContainer(BuildContext context, String title, String content) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: getHeight(context, 12),
          width: getWidth(context, 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColorRed,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
          ),
          child: Icon(
            Icons.warning_amber_outlined,
            size: 70,
            color: mainColorWhite,
          ),
        ),
        Container(
          height: getHeight(context, 30),
          width: getWidth(context, 80),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: mainColorLightGrey,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Confirm',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: mainFontbold,
                    color: mainColorGrey),
              ),
              const SizedBox(height: 20),
              Text(
                'You must login first',
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: mainFontnormal,
                    color: mainColorGrey),
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: getHeight(context, 5),
                width: getWidth(context, 60),
                child: TextButton(
                  onPressed: () {
                    print("jegr");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const RegisterWithPhoneNumber()),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(mainColorRed),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(
                        color: mainColorWhite,
                        fontSize: 22,
                        fontFamily: mainFontnormal),
                  ),
                ),
              )
            ],
          ),
        ),
      ],
    ),
  );
}
