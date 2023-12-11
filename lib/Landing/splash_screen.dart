import 'dart:async';
import 'dart:convert';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/my_widget.dart';
import 'package:athome/Landing/choose_lan.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../Config/property.dart';
import '../home/nav_switch.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

var userdata = {};
bool loaddata = false;

class _SplashScreenState extends State<SplashScreen> {
  bool seen = false;
  bool textshow = false;
  var subscription;
  @override
  void initState() {
    //
    checkinternet();

    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      final pro = Provider.of<productProvider>(context, listen: false);
      if (result == ConnectivityResult.none) {
        pro.setnointernetcheck(true);
        setState(() {
          textshow = true;
        });
      } else {
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
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>
                      seen ? const NavSwitch() : const ChooseLang(),
                ),
              );
            },
          );
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
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
      const Duration(seconds: 5),
      () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => seen ? const NavSwitch() : const ChooseLang(),
          ),
        );
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
