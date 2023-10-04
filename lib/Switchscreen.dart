// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';

// import 'package:athome/Config/athome_functions.dart';
// import 'package:athome/Config/local_data.dart';
// import 'package:athome/Config/property.dart';

// import 'package:athome/home/NavSwitch.dart';
// import 'package:athome/landing/welcome_screen.dart';
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';

// bool loadData = false;

// class Switchscreen extends StatefulWidget {
//   const Switchscreen({super.key});

//   @override
//   State<Switchscreen> createState() => _SwitchscreenState();
// }

// bool isLogin = false;
// var userData = {};

// class _SwitchscreenState extends State<Switchscreen> {
//   @override
//   void initState() {
//     loadData = true;
//     getBoolPrefs("islogin").then((value) {
//       if (value) {
//         getStringPrefs("userData").then((data2) {
//           var data = json.decode(decryptAES(data2));

//           setState(() {
//             userData = data;
//             isLogin = true;
//           });
//           Timer(
//             const Duration(seconds: 3),
//             () {
//               Navigator.pushReplacement(
//                 context,
//                 MaterialPageRoute(builder: (context) => const NavSwitch()),
//               );
//             },
//           );
//         });
//       } else {
//         getBoolPrefs("onbord").then((value2) {
//           setState(() {
//             isLogin = false;
//           });
//           Timer(
//             const Duration(seconds: 3),
//             () {
//               if (value2) {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(builder: (context) => const NavSwitch()),
//                 );
//               } else {
//                 Navigator.pushReplacement(
//                   context,
//                   MaterialPageRoute(
//                       builder: (context) => const WelcomeScreen()),
//                 );
//               }
//             },
//           );
//         });
//       }
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Stack(
//           children: [
//             Image.asset(
//               mainImagePattern,
//               width: getWidth(context, 100),
//               height: getHeight(context, 100),
//               fit: BoxFit.cover,
//             ),
//             Center(
//               child: Image.asset(
//                 mainImageLogo1,
//                 width: getWidth(context, 75),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
