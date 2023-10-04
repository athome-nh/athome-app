import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/property.dart';

import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/landing/login_page.dart';
import 'package:athome/main.dart';
import 'package:athome/model/cart.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../home/NavSwitch.dart';
import '../home/oneitem.dart';

Widget listItemsShow(BuildContext context, var data) {
  final productPro = Provider.of<productProvider>(context, listen: true);
  final cartProvider = Provider.of<CartProvider>(context, listen: true);
  return Container(
    height: getHeight(context, 90),
    width: getWidth(context, 95),
    child: GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        childAspectRatio: getHeight(context, 0.073),
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
                MaterialPageRoute(builder: (context) => Oneitem()),
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
                                color: Color(0xffF2F2F2),
                                borderRadius: BorderRadius.circular(5)),
                            child: Center(
                              child: CachedNetworkImage(
                                imageUrl: product.coverImg!,
                                placeholder: (context, url) =>
                                    Image.asset("assets/images/002_logo_1.png"),
                                errorWidget: (context, url, error) =>
                                    Image.asset("assets/images/002_logo_1.png"),
                                width: getHeight(context, 18),
                                height: getHeight(context, 18),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              if (!isLogin) {
                                loginFirstModal(context);
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
                      product.offerPrice! > 0
                          ? Container(
                              width: getHeight(context, 8),
                              height: getHeight(context, 3),
                              decoration: BoxDecoration(
                                borderRadius: lang == "en"
                                    ? BorderRadius.only(
                                        //  topLeft: Radius.circular(20.0),
                                        topRight: Radius.circular(20.0),
                                        // bottomLeft: Radius.circular(0.0),
                                        bottomRight: Radius.circular(20.0),
                                      )
                                    : BorderRadius.only(
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
                                        double.parse(product.price!.toString()),
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
                          : SizedBox(),
                    ],
                  ),
                  Stack(
                    alignment: lang == "en"
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    children: [
                      Container(
                        width: getWidth(context, 100),
                        height: getHeight(context, 13),
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
                            SizedBox(
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
                            SizedBox(
                              height: 3,
                            ),
                            Text(
                              addCommasToPrice(product.price!),
                              style: TextStyle(
                                  decoration: product.offerPrice! > 0
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: mainColorGrey,
                                  fontFamily: mainFontnormal,
                                  fontSize: 14),
                            ),
                            product.offerPrice! > 0
                                ? Text(
                                    addCommasToPrice(product.offerPrice!),
                                    style: TextStyle(
                                        color: mainColorRed,
                                        fontFamily: mainFontbold,
                                        fontSize: 14),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (!isLogin) {
                            loginFirstModal(context);
                            return;
                          }
                          if (product.offerPrice! > 0 &&
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
                                              int.parse(product.id.toString()))
                                          .toString(),
                                      style: TextStyle(
                                          fontSize: 16, color: mainColorWhite),
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

// success Alert
Future<void> successAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.success,
    title: title,
    text: content,
  );
}

// error Alert
Future<void> errorAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.error,
    title: title,
    text: content,
  );
}

// warning Alert
Future<void> warningAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.warning,
    title: title,
    text: content,
  );
}

// info Alert
Future<void> infoAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    headerBackgroundColor: mainColorGrey,
    type: QuickAlertType.info,
    title: title,
    text: content,
  );
}

// confirm Alert
Future<void> confirmAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    confirmBtnColor: mainColorRed,
    type: QuickAlertType.confirm,
    title: title,
    text: content,
    confirmBtnText: 'Yes'.tr,
    cancelBtnText: 'No'.tr,
  );
}

// loading
Future<void> loadingAlertAthome(
    BuildContext context, String title, String content) {
  return QuickAlert.show(
    context: context,
    type: QuickAlertType.loading,
    title: title,
    text: content,
  );
}

Future<void> alert(BuildContext context, String title, String message) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: mainColorGrey,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          width: getWidth(context, 80),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: mainColorGrey,
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              )),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: getHeight(context, 6),
                decoration: BoxDecoration(
                    color: mainColorRed,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: mainFontnormal,
                        color: mainColorGrey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                margin: EdgeInsets.only(top: getHeight(context, 3), bottom: 0),
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: mainFontnormal,
                    color: mainColorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                  height: getHeight(context, 5),
                  width: getWidth(context, 25),
                  margin: EdgeInsets.only(
                      top: getHeight(context, 3),
                      bottom: getHeight(context, 1)),
                  decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: mainColorRed,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      "OK".tr,
                      style: TextStyle(
                          fontFamily: mainFontnormal,
                          color: mainColorWhite,
                          fontSize: 18,
                          fontWeight: FontWeight.normal),
                    ),
                  ))
            ],
          ),
        ),
      );
    },
  );
}

Future<void> yesNoOptrins(
    BuildContext context, String title, String message, double line) async {
  return showDialog<void>(
    context: context,
    // barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: mainColorRed,
        contentPadding: const EdgeInsets.all(0),
        content: Container(
          width: getWidth(context, 80),
          height: getHeight(context, 21 + line),
          decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: mainColorGrey,
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(10), topLeft: Radius.circular(10))),
          child: Stack(
            children: [
              Container(
                height: getHeight(context, 6),
                decoration: BoxDecoration(
                    color: mainColorRed,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        topLeft: Radius.circular(10))),
                child: Center(
                  child: Text(
                    title,
                    style: TextStyle(
                        fontFamily: mainFontnormal,
                        color: mainColorWhite,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.topCenter,
                padding: const EdgeInsets.all(8),
                margin: EdgeInsets.only(top: getHeight(context, 6), bottom: 0),
                child: Text(
                  message,
                  style: TextStyle(
                    fontFamily: mainFontnormal,
                    color: mainColorWhite,
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: (getHeight(context, 21 + line)) -
                          getHeight(context, 6),
                    ),
                    child: Container(
                        height: getHeight(context, 5),
                        width: getWidth(context, 18),
                        decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                              color: mainColorRed,
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {
                            // Get.back();
                          },
                          child: Text(
                            "Cancle".tr,
                            style: TextStyle(
                                fontFamily: mainFontnormal,
                                color: mainColorRed,
                                fontSize: getWidth(context, 4),
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                  SizedBox(
                    width: getWidth(context, 5),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                      top: (getHeight(context, 21 + line)) -
                          getHeight(context, 6),
                    ),
                    child: Container(
                        height: getHeight(context, 5),
                        width: getWidth(context, 18),
                        decoration: BoxDecoration(
                            color: mainColorRed,
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () {},
                          child: Text(
                            "OK".tr,
                            style: TextStyle(
                                fontFamily: mainFontnormal,
                                color: mainColorGrey,
                                fontSize: getWidth(context, 4),
                                fontWeight: FontWeight.normal),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}

loginFirstContainer(BuildContext context) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // margin: EdgeInsets.only(
            //   left: getWidth(context,5),
            //   right: getWidth(context,5),
            //   top: getHeight(context,21),
            //   bottom: getHeight(context,21),
            // ),
            width: getWidth(context, 90),
            height: getWidth(context, 100),
            decoration: BoxDecoration(
              border: Border.all(
                color: mainColorRed,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(5),
              color: mainColorGrey,
            ),
            child: Column(
              children: [
                Container(
                  width: getWidth(context, 90),
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                    color: mainColorRed,
                  ),
                  child: Center(
                    child: Text(
                      "Warning".tr,
                      style: TextStyle(
                        fontFamily: mainFontnormal,
                        color: mainColorWhite,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: getHeight(context, 2)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: getWidth(context, 4)),
                      width: getWidth(context, 30),
                      height: getWidth(context, 30),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: mainColorWhite,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(100),
                        color: mainColorGrey,
                      ),
                      child: Icon(
                        Icons.person_outline,
                        color: mainColorWhite,
                        size: getWidth(context, 27),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: getHeight(context, 4)),
                Text(
                  "You need to login first".tr,
                  style: TextStyle(
                      fontFamily: mainFontnormal,
                      color: mainColorWhite,
                      fontSize: 25,
                      fontWeight: FontWeight.normal),
                ),
                SizedBox(height: getHeight(context, 4)),
                Container(
                  margin: EdgeInsets.only(
                    top: getHeight(context, 2),
                  ),
                  height: 45,
                  width: getWidth(context, 50),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50.0),
                    color: mainColorRed,
                  ),
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterWithPhoneNumber()),
                      );
                    },
                    child: Text(
                      'Log in'.tr,
                      style: TextStyle(
                        fontFamily: mainFontnormal,
                        fontSize: 18,
                        color: mainColorWhite,
                        fontWeight: FontWeight.w800,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

loginFirstModal(BuildContext context) {
  showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  // margin: EdgeInsets.only(
                  //   left: getWidth(context,5),
                  //   right: getWidth(context,5),
                  //   top: getHeight(context,21),
                  //   bottom: getHeight(context,21),
                  // ),
                  width: getWidth(context, 90),
                  height: getWidth(context, 100),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: mainColorGrey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: mainColorGrey,
                  ),
                  child: Column(
                    children: [
                      Container(
                        width: getWidth(context, 90),
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                          ),
                          color: mainColorRed,
                        ),
                        child: Center(
                          child: Text(
                            "Warning".tr,
                            style: TextStyle(
                              fontFamily: mainFontnormal,
                              color: mainColorWhite,
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: getHeight(context, 2)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding:
                                EdgeInsets.only(bottom: getWidth(context, 4)),
                            width: getWidth(context, 30),
                            height: getWidth(context, 30),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: mainColorWhite,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(100),
                              color: mainColorGrey,
                            ),
                            child: Icon(
                              Icons.person_outline,
                              color: mainColorWhite,
                              size: getWidth(context, 27),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(context, 4)),
                      Text(
                        "You need to login first".tr,
                        style: TextStyle(
                            fontFamily: mainFontnormal,
                            color: mainColorRed,
                            fontSize: 25,
                            fontWeight: FontWeight.normal),
                      ),
                      SizedBox(height: getHeight(context, 4)),
                      Container(
                        margin: EdgeInsets.only(
                          top: getHeight(context, 2),
                        ),
                        height: 45,
                        width: getWidth(context, 50),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: mainColorRed,
                        ),
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const RegisterWithPhoneNumber()),
                            );
                          },
                          child: Text(
                            'Log in'.tr,
                            style: TextStyle(
                              fontFamily: mainFontnormal,
                              fontSize: 18,
                              color: mainColorWhite,
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        );
      });
}
