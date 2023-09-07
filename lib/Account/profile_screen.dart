import 'package:flutter/material.dart';

import '../Config/property.dart';
import '../Landing/splash_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Profile Information",
          style: TextStyle(
              color: mainColorGrey, fontFamily: mainFontMontserrat4, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: mainColorWhite,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: mainColorRed,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: getHeight(context, 3),
            ),
            Container(
              width: getWidth(context, 25),
              height: getWidth(context, 25),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white, // Customize the border color
                  width: 2.0, // Customize the border width
                ),
              ),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/orange.png',
                  width: getWidth(context, 25),
                  height: getWidth(context, 25),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 5),
            ),
            const Text(
              "Hi there Brosli ! ",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.edit, color: mainColorRed),
                  Text(
                    'Edit',
                    style: TextStyle(color: mainColorRed),
                  ),
                ],
              ),
            ),
            Container(
              width: getWidth(context, 70),
              height: getHeight(context, 7),
              decoration: BoxDecoration(
                color: mainColorLightGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '   Full Name',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            Container(
              width: getWidth(context, 70),
              height: getHeight(context, 7),
              decoration: BoxDecoration(
                color: mainColorLightGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '   Phone Number',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            Container(
              width: getWidth(context, 70),
              height: getHeight(context, 7),
              decoration: BoxDecoration(
                color: mainColorLightGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '   City & Country',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            Container(
              width: getWidth(context, 70),
              height: getHeight(context, 7),
              decoration: BoxDecoration(
                color: mainColorLightGrey,
                shape: BoxShape.rectangle,
                borderRadius: BorderRadius.circular(50),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: '   Addres',
                  border: InputBorder.none,
                ),
              ),
            ),
            SizedBox(
              height: getHeight(context, 3),
            ),
            SizedBox(
              height: getHeight(context, 5),
            ),
            SizedBox(
              width: getWidth(context, 60),
              height: getHeight(context, 7),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: mainColorRed,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    )),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SplashScreen()),
                  );
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: getWidth(context, 5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
