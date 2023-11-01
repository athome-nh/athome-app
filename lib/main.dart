import 'package:athome/Config/local_data.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:athome/map/mapScreen.dart';
import 'package:athome/map/maps.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'Landing/splash_screen.dart';
import 'Language/Translation.dart';
import 'firebase_options.dart';

final navigatorKey = GlobalKey<NavigatorState>();
Future<void> main() async {
  GeocodingPlatform.instance;
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AtHomeApp());
}

String lang = "";
String token = "";
bool isLogin = false;

class AtHomeApp extends StatefulWidget {
  const AtHomeApp({super.key});

  @override
  State<AtHomeApp> createState() => _AtHomeAppState();
}

class _AtHomeAppState extends State<AtHomeApp> {
  @override
  void initState() {
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
        home: const Map_screen(),
        //const Setting(),
      ),
    );
  }
}
