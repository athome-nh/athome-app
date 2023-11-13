import 'package:athome/Config/local_data.dart';
import 'package:athome/Notifications/NotificationController.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/controller/productprovider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
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

  FirebaseMessaging messaging = FirebaseMessaging.instance;
  messaging.getToken().then((value){

print(value);
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
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
