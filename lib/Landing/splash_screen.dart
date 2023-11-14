import 'dart:async';
import 'dart:convert';
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
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          textshow = true;
        });
      } else {
        setState(() {
          textshow = false;
        });
        getStringPrefs("data").then((map) {
          if (map.isNotEmpty) {
            Map<String, dynamic> myMap = json.decode(map);
            seen = myMap["onbord"];
            isLogin = myMap.containsKey("islogin") ? myMap["islogin"] : false;
            token = myMap.containsKey("token") ? myMap["token"] : "";
          }

          Provider.of<productProvider>(context, listen: false)
              .updatePost(isLogin);
        });

        Timer(
          const Duration(seconds: 5),
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
    });
    super.initState();
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  Future<void> checkinternet() async {
    if (await noInternet(context)) {
      setState(() {
        textshow = true;
      });
      return;
    }

    getStringPrefs("data").then((map) {
      if (map.isNotEmpty) {
        Map<String, dynamic> myMap = json.decode(map);

        seen = myMap["onbord"];
        isLogin = myMap.containsKey("islogin") ? myMap["islogin"] : false;
        token = myMap.containsKey("token") ? myMap["token"] : "";
      }
      final productrovider =
          Provider.of<productProvider>(context, listen: false);
      productrovider.updatePost(isLogin);
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
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Opacity(
              opacity: 0.25,
              child: Image.asset(
                mainImagePattern,
                width: getWidth(context, 100),
                height: getHeight(context, 100),
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    mainImageLogo1,
                    width: getWidth(context, 100),
                  ),
                  textshow
                      ? Text(
                          'You\'re offline, connect to a network.'.tr,
                        )
                      : SizedBox(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
