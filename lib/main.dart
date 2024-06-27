import 'dart:async';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Notifications/Notification.dart';
import 'package:dllylas/Notifications/NotificationController.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/thim.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'Landing/splash_screen.dart';
import 'Language/Translation.dart';
import 'firebase_options.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.data["type"]) {
    //  Get.to(ChatScreen(message.data["roomid"], message.data["coName"]));
  }
  await Firebase.initializeApp();
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    badge: true,
  );
  NotificationController.instance.initLocalNotification();
  MapboxOptions.setAccessToken(
      "sk.eyJ1IjoiYXRob21lYXBwIiwiYSI6ImNsbnZwZ2pucTAxZWQya24waWxseXJqbnUifQ.9U5OBq8TQGof3Jnop22Tsw");
  runApp(const AtHomeApp());
}

String lang = "";
String token = "";

late DateTime datetimeS;
bool isLogin = false;
final navigatorKey = GlobalKey<NavigatorState>();

class AtHomeApp extends StatefulWidget {
  const AtHomeApp({super.key});

  @override
  State<AtHomeApp> createState() => _AtHomeAppState();
}

class _AtHomeAppState extends State<AtHomeApp> {
  StreamSubscription? _sub;
  @override
  void initState() {
    FCMNotification(context).config();

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
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => productProvider()),
      ],
      child: GetMaterialApp(
        theme: AppThemes.lightTheme1,
        translations: Translation(),
        locale: const Locale("en"),
        fallbackLocale: const Locale("en"),
        title: 'DLLY LAS Market',
        debugShowCheckedModeBanner: false,
        initialRoute: '/splash',
        navigatorKey: navigatorKey,
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/home', page: () => NavSwitch()),
        ],
      ),
    );
  }
}
