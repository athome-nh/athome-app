import 'dart:async';
import 'dart:convert';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Landing/choose_lan.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/all_item.dart';
import 'package:dllylas/home/item_categories.dart';
import 'package:dllylas/home/oneitem.dart';
import 'package:dllylas/home/track_order.dart';
import 'package:dllylas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dllylas/model/order_model/order_model.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import '../Config/property.dart';
import '../home/nav_switch.dart';

class SplashScreen extends StatefulWidget {
  final RemoteMessage? message;

  SplashScreen({RemoteMessage? message, Key? key})
      : message = message ?? RemoteMessage(),
        super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

var userdata = {};
bool loaddata = false;

class _SplashScreenState extends State<SplashScreen> {
  bool seen = false;
  bool textshow = false;

  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  @override
  void initState() {
    checkinternet();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);

    super.initState();
  }

  Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (result[0] == ConnectivityResult.none) {
      pro.setnointernetcheck(true);
      setState(() {
        textshow = true;
      });
    } else {
      Provider.of<productProvider>(context, listen: false).getDataAll(false);
      if (pro.nointernetCheck) {
        setState(() {
          pro.setnointernetcheck(false);
          setState(() {
            textshow = false;
          });
        });

        getStringPrefs("data").then((map) {
          if (map.isNotEmpty) {
            Map<String, dynamic> myMap = json.decode(map);

            seen = myMap["onbord"];
            isLogin = myMap.containsKey("islogin") ? myMap["islogin"] : false;
            token =
                myMap.containsKey("token") ? decryptAES(myMap["token"]) : "";
          }

          pro.updatePost(isLogin);
        });

        Timer(
          const Duration(seconds: 6),
          () {
            navigator(context);
          },
        );
      }
    }
  }

  void navigator(BuildContext context) {
    final productrovider = Provider.of<productProvider>(context, listen: false);

    if (widget.message!.data.isEmpty) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => seen ? NavSwitch() : const ChooseLang(),
        ),
      );
    }
    if ('onItem' == widget.message!.data["type"]) {
      productrovider.setidItem(productrovider
          .getoneProductByBarcode(widget.message!.data["barcode"])
          .id!);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const Oneitem()),
      );
    } else if ('discount' == widget.message!.data["type"]) {
      productrovider.settype("discount");
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AllItem()),
      );
    } else if ('brand' == widget.message!.data["type"]) {
      productrovider.settype("brand");

      productrovider
          .setidbrand(int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const AllItem()),
      );
    } else if ('category' == widget.message!.data["type"]) {
      if (productrovider.categores.indexWhere((category) =>
              category.id ==
              int.parse(widget.message!.data["relationId"].toString())) ==
          -1) {
        return;
      }
      productrovider.setcatetype(
          int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(builder: (context) => itemCategories()),
      )
          .then((value) {
        productrovider.setsubcateSelect(0);
      });
    } else if ('subcategory' == widget.message!.data["type"]) {
      if (productrovider.categores.indexWhere((category) =>
                  category.id ==
                  int.parse(widget.message!.data["relationId"].toString())) ==
              -1 ||
          productrovider.subCategores.indexWhere((subCategory) =>
                  subCategory.id ==
                  int.parse(widget.message!.data["barcode"])) ==
              -1) {
        return;
      }
      productrovider.setcatetype(
          int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context)
          .pushReplacement(
        MaterialPageRoute(
            builder: (context) => itemCategories(
                  subcateID: int.parse(widget.message!.data["barcode"]),
                )),
      )
          .then((value) {
        productrovider.setsubcateSelect(0);
      });
    } else if ('order' == widget.message!.data["type"]) {
      OrderModel order = productrovider.Orders.firstWhere((element) =>
          element.id ==
          int.parse(widget.message!.data["relationId"].toString()));
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => TrackOrder(order.id.toString(),
                order.returnTotalPrice.toString(), order.createdAt.toString())),
      );
    } else if ('attention' == widget.message!.data["type"]) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => seen ? NavSwitch() : const ChooseLang(),
        ),
      );
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> checkinternet() async {
    final pro = Provider.of<productProvider>(context, listen: false);
    if (await noInternet(context)) {
      setState(() {
        pro.setnointernetcheck(true);
        textshow = true;
      });
      return;
    }

    setState(() {
      pro.setnointernetcheck(false);
      textshow = false;
    });
    getStringPrefs("data").then((map) {
      if (map.isNotEmpty) {
        Map<String, dynamic> myMap = json.decode(map);

        seen = myMap["onbord"];
        isLogin = myMap.containsKey("islogin") ? myMap["islogin"] : false;
        token = myMap.containsKey("token") ? decryptAES(myMap["token"]) : "";
      }

      pro.updatePost(isLogin);
    });

    Timer(
      const Duration(seconds: 6),
      () {
        navigator(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return textshow
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              body: Center(
                child: Image.asset(
                  mainImageLogo1,
                  width: getWidth(context, 100),
                ),
              ),
            ),
          );
  }
}
