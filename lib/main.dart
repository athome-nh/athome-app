import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Notifications/Notification.dart';
import 'package:dllylas/Notifications/NotificationController.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/test.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
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
