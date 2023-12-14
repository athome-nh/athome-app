import 'package:DllyLas/Config/local_data.dart';
import 'package:DllyLas/Config/property.dart';
import 'package:DllyLas/Notifications/Notification.dart';
import 'package:DllyLas/Notifications/NotificationController.dart';
import 'package:DllyLas/controller/cartprovider.dart';
import 'package:DllyLas/controller/productprovider.dart';
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
  
  Future<void> a() async {
    //   await FirebaseMessaging.instance.getToken().then((value) {
    //   print(value);
    // });
  // await  FirebaseMessaging.instance.getAPNSToken().then((value) {
  //     print(value);
  //   });
  }



 Future getDeviceToken() async {
    //request user permission for push notification 
    FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging _firebaseMessage = FirebaseMessaging.instance;
    String? deviceToken = await _firebaseMessage.getToken();
    return (deviceToken == null) ? "" : deviceToken;
  }

prenttoken() async { 


  String deviceToken = await getDeviceToken();
    print("###### PRINT DEVICE TOKEN TO USE FOR PUSH NOTIFCIATION ######");
    print(deviceToken);
    print("############################################################");

}
  @override
  void initState() {
//      FCMNotification(context).config();
//    print(FCMNotification(context).getToken());
//  a();

 prenttoken();
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
        theme: ThemeData(
          dialogTheme: DialogTheme(
            backgroundColor:
                mainColorWhite, // Set the background color of AlertDialog
          ),
          popupMenuTheme: PopupMenuThemeData(color: mainColorWhite),
          dividerTheme:
              DividerThemeData(color: mainColorBlack.withOpacity(0.2)),
          buttonTheme: ButtonThemeData(buttonColor: mainColorGrey),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: TextStyle(
                  color: mainColorWhite,
                  fontFamily: mainFontnormal,
                  fontSize: 14),
              foregroundColor: mainColorWhite, // Text color of the button
              backgroundColor: mainColorGrey, // Background color of the button
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(5.0), // Border radius of the button
              ),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              textStyle: TextStyle(
                  color: mainColorWhite,
                  fontFamily: mainFontnormal,
                  fontSize: 14),
              foregroundColor: mainColorWhite, // Text color of the button
              backgroundColor: mainColorGrey, // Background color of the button
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(5.0), // Border radius of the button
              ),
            ),
          ),
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
              primary: mainColorGrey,
              secondary: mainColorRed,
              background: mainColorWhite,
              brightness: Brightness.light,
              seedColor: mainColorGrey),
          scaffoldBackgroundColor: mainColorWhite,
          appBarTheme: AppBarTheme(
            actionsIconTheme: IconThemeData(color: mainColorWhite, size: 25),
            iconTheme: IconThemeData(color: mainColorWhite),
            centerTitle: true,
            elevation: 0,
            titleTextStyle: TextStyle(
                color: mainColorWhite,
                fontSize: 20,
                fontFamily: mainFontnormal),
            backgroundColor: mainColorGrey,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            showUnselectedLabels: false,
            selectedItemColor: mainColorWhite,
            unselectedItemColor: mainColorWhite,
            backgroundColor: mainColorGrey,
            type: BottomNavigationBarType.fixed,
          ),
        ),
        translations: Translation(),
        locale: const Locale("en"),
        fallbackLocale: const Locale("en"),
        title: 'DLLY LAS Market',
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        navigatorKey: navigatorKey,
      ),
    );
  }
}
