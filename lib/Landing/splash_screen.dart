import 'dart:async';
import 'dart:convert';
import 'package:dllylas/Config/athome_functions.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Landing/choose_lan.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

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
