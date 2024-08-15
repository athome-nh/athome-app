// Import necessary packages and libraries
import 'dart:async';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Notifications/Notification.dart';
import 'package:dllylas/Notifications/NotificationController.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/ThemeData.dart';
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

// Background message handler for Firebase Cloud Messaging
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Handle the incoming message data here
  if (message.data["type"]) {
  }
  // Initialize Firebase app
  await Firebase.initializeApp();
}

// Entry point of the application
Future<void> main() async {
  // Ensure the widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables from the .env file
  await dotenv.load(fileName: ".env");

  // Set the preferred device orientation to portrait mode
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Set up a background message handler for Firebase messaging
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Configure foreground notification presentation options
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    badge: true,
  );

  // Initialize local notifications
  NotificationController.instance.initLocalNotification();

  // Set Mapbox access token for map functionality
  MapboxOptions.setAccessToken(
      "sk.eyJ1IjoiYXRob21lYXBwIiwiYSI6ImNsbnZwZ2pucTAxZWQya24waWxseXJqbnUifQ.9U5OBq8TQGof3Jnop22Tsw");

  // Run the application
  runApp(const AtHomeApp());
}

// Global variables for language, token, and login status
String lang = "";
String token = "";
late DateTime datetimeS;
bool isLogin = false;

// Global key for navigation management
final navigatorKey = GlobalKey<NavigatorState>();

// Main application widget
class AtHomeApp extends StatefulWidget {
  const AtHomeApp({super.key});

  @override
  State<AtHomeApp> createState() => _AtHomeAppState();
}

class _AtHomeAppState extends State<AtHomeApp> {
  // Subscription to stream (used later)
  StreamSubscription? _sub;

  @override
  void initState() {
    // Configure Firebase Cloud Messaging notifications
    FCMNotification(context).config();

    // Retrieve stored language preference and update the app locale
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
    // Cancel the stream subscription if it exists
    _sub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // Provide CartProvider and ProductProvider to the widget tree
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => productProvider()),
      ],
      child: GetMaterialApp(
        // Set the theme of the app
        theme: AppThemes.lightTheme1,
        // Set translations and locales for internationalization
        translations: Translation(),
        locale: const Locale("ar"),
        fallbackLocale: const Locale("ar"),
        // Set the app title
        title: 'DLLY LAS Market',
        // Disable the debug banner
        debugShowCheckedModeBanner: false,
        // Set the initial route to the splash screen
        initialRoute: '/splash',
        // Use the global navigator key for navigation management
        navigatorKey: navigatorKey,
        // Define the pages for navigation
        getPages: [
          GetPage(name: '/splash', page: () => SplashScreen()),
          GetPage(name: '/home', page: () => NavSwitch()),
        ],
      ),
    );
  }
}
