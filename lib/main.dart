import 'package:athome/Landing/splash_screen.dart';
import 'package:athome/landing/login_page.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
 
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const AtHomeApp());
}

class AtHomeApp extends StatelessWidget {
  const AtHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'AtHome Market',
      debugShowCheckedModeBanner: false,
      home: RegisterWithPhoneNumber(),
    );
  }
}
