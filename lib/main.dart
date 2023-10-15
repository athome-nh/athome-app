import 'dart:convert';
import 'package:athome/Config/athome_functions.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Landing/splash_screen.dart';
import 'Landing/welcome_screen.dart';
import 'Language/Translation.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  GeocodingPlatform.instance;
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AtHomeApp());
}

String lang = "";

class AtHomeApp extends StatefulWidget {
  const AtHomeApp({super.key});

  @override
  State<AtHomeApp> createState() => _AtHomeAppState();
}

bool isLogin = false;
var userData = {};
bool loaddata = false;

class _AtHomeAppState extends State<AtHomeApp> {
  bool seen = true;
  @override
  void initState() {
    getBoolPrefs("onbord").then((value2) {
      seen = value2;
      getBoolPrefs("islogin").then((value) {
        if (value) {
          getStringPrefs("userData").then((data2) {
            userData = json.decode(decryptAES(data2));
            isLogin = true;
          });
        } else {
          isLogin = false;
        }
      });
    });

    getStringPrefs("lang").then((value) {
      setState(() {
        if (value != "") {
          lang = value;
          Get.updateLocale(Locale(value));
        } else {
          lang = "en";
          Get.updateLocale(const Locale("en"));
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => productProvider()),
      ],
      child: GetMaterialApp(
        translations: Translation(),
        locale: const Locale("en"),
        fallbackLocale: const Locale("en"),
        title: 'AtHome Market',
        debugShowCheckedModeBanner: false,
        home: seen ? const SplashScreen() : const WelcomeScreen(),
        //const Setting(), 
      ),
    );
  }
}
