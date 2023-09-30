import 'package:athome/Account/about_screen.dart';
import 'package:athome/Config/local_data.dart';
import 'package:athome/Switchscreen.dart';
import 'package:athome/landing/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Config/property.dart';
import 'profile_screen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainColorWhite,
      appBar: AppBar(
        title: Text(
          "Account",
          style: TextStyle(
              color: mainColorGrey,
              fontFamily: mainFontMontserrat4,
              fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: mainColorWhite,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (isLogin) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileScreen()),
                      );
                    } else {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => RegisterWithPhoneNumber()),
                      );
                    }
                  },
                  child: Container(
                    width: getWidth(context, 85),
                    height: getHeight(context, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: mainColorLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              isLogin
                                  ? CircleAvatar(
                                      radius: 30,
                                      backgroundImage: AssetImage(
                                          'assets/images/orange.png'),
                                    )
                                  : Container(
                                      width: getWidth(context, 20),
                                      height: getHeight(context, 15),
                                      padding: const EdgeInsets.all(5),
                                      child: Card(
                                        elevation: 5,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: CircleAvatar(
                                          backgroundColor: mainColorLightGrey,
                                          child: Icon(
                                            Icons.account_circle_outlined,
                                            size: getHeight(context, 4),
                                            color: mainColorRed,
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: getWidth(context, 3),
                              ),
                              Text(
                                isLogin
                                    ? "Profile Information"
                                    : "Create account",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: mainFontMontserrat4,
                                    color: mainColorGrey),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: mainColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 3),
                ),
                Container(
                  width: getWidth(context, 85),
                  height: getHeight(context, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: mainColorLightGrey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: getWidth(context, 20),
                              height: getHeight(context, 15),
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: mainColorLightGrey,
                                  child: Icon(
                                    Icons.discount,
                                    size: getHeight(context, 4),
                                    color: mainColorRed,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(context, 3),
                            ),
                            Text(
                              "My Offers",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: mainFontMontserrat4,
                                  color: mainColorGrey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: mainColorRed,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                Container(
                  width: getWidth(context, 85),
                  height: getHeight(context, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: mainColorLightGrey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: getWidth(context, 20),
                              height: getHeight(context, 15),
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: mainColorLightGrey,
                                  child: Icon(
                                    Icons.notifications,
                                    size: getHeight(context, 4),
                                    color: mainColorRed,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(context, 3),
                            ),
                            Text(
                              "Notifications",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: mainFontMontserrat4,
                                  color: mainColorGrey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: mainColorRed,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                Container(
                  width: getWidth(context, 85),
                  height: getHeight(context, 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                      color: mainColorLightGrey),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(context, 2),
                        ),
                        child: Row(
                          children: [
                            Container(
                              width: getWidth(context, 20),
                              height: getHeight(context, 15),
                              padding: const EdgeInsets.all(5),
                              child: Card(
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: CircleAvatar(
                                  backgroundColor: mainColorLightGrey,
                                  child: Icon(
                                    Icons.location_on,
                                    size: getHeight(context, 4),
                                    color: mainColorRed,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: getWidth(context, 3),
                            ),
                            Text(
                              "Address",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: mainFontMontserrat4,
                                  color: mainColorGrey),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: mainColorRed,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: getWidth(context, 85),
                    height: getHeight(context, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: mainColorLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: getWidth(context, 20),
                                height: getHeight(context, 15),
                                padding: const EdgeInsets.all(5),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: mainColorLightGrey,
                                    child: Icon(
                                      Icons.language_outlined,
                                      size: getHeight(context, 4),
                                      color: mainColorRed,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getWidth(context, 3),
                              ),
                              Text(
                                "Languages",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: mainFontMontserrat4,
                                    color: mainColorGrey),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: mainColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AboutScreen()),
                    );
                  },
                  child: Container(
                    width: getWidth(context, 85),
                    height: getHeight(context, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: mainColorLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: getWidth(context, 20),
                                height: getHeight(context, 15),
                                padding: const EdgeInsets.all(5),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: mainColorLightGrey,
                                    child: Icon(
                                      Icons.info_outline_rounded,
                                      size: getHeight(context, 4),
                                      color: mainColorRed,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getWidth(context, 3),
                              ),
                              Text(
                                "About Us",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: mainFontMontserrat4,
                                    color: mainColorGrey),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: mainColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: getHeight(context, 1),
                ),
                GestureDetector(
                  onTap: () {
                    FirebaseAuth.instance.signOut();
                    setBoolPrefs("islogin", false);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Switchscreen()),
                    );
                  },
                  child: Container(
                    width: getWidth(context, 85),
                    height: getHeight(context, 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(7),
                        color: mainColorLightGrey),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: getWidth(context, 2),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: getWidth(context, 20),
                                height: getHeight(context, 15),
                                padding: const EdgeInsets.all(5),
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: CircleAvatar(
                                    backgroundColor: mainColorLightGrey,
                                    child: Icon(
                                      Icons.logout,
                                      size: getHeight(context, 4),
                                      color: mainColorRed,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: getWidth(context, 3),
                              ),
                              Text(
                                "log Out",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: mainFontMontserrat4,
                                    color: mainColorGrey),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: mainColorRed,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
