import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/home/NavSwitch.dart';
import 'package:athome/landing/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

bool loadData = false;

class Switchscreen extends StatefulWidget {
  const Switchscreen({super.key});

  @override
  State<Switchscreen> createState() => _SwitchscreenState();
}

bool isLogin = false;
var userData = {};
var userCard = [];

class _SwitchscreenState extends State<Switchscreen> {
  loadPostData() async {
    final directory = await getTemporaryDirectory();
    String path = "${directory.path}/user.json";
    File f = File(path);
    if (f.existsSync()) {
      final jsonData = f.readAsStringSync();
      var data = json.decode(decryptAES(jsonData));
      return data;
    } else {
      return {};
    }
  }

  @override
  void initState() {
    loadData = true;
    getBoolPrefs("islogin").then((value) {
      if (value) {
        loadPostData().then((data) {
          final cartProvider = Provider.of<CartProvider>(context, listen: true);
          cartProvider.loadCartFromPreferences();
          setState(() {
            userData = data;
            isLogin = true;
          });
          Timer(
            const Duration(seconds: 3),
            () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const NavSwitch()),
              );
            },
          );
        });
      } else {
        getBoolPrefs("onbord").then((value) {
          // setBoolPrefs("onbord", false);
          setState(() {
            isLogin = true;
          });
          Timer(
            const Duration(seconds: 3),
            () {
              if (value) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const NavSwitch()),
                );
              } else {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WelcomeScreen()),
                );
              }
            },
          );
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              mainImagePattern,
              width: getWidth(context, 100),
              height: getHeight(context, 100),
              fit: BoxFit.cover,
            ),
            Center(
              child: Image.asset(
                mainImageLogo1,
                width: getWidth(context, 75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
