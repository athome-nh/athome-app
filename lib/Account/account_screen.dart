import 'package:athome/Account/about_screen.dart';
import 'package:flutter/material.dart';

import '../Config/property.dart';
import 'language_screen.dart';
import 'order_screen.dart';
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
              color: mainColorGrey, fontFamily: mainFontMontserrat4, fontSize: 24),
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileScreen()),
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
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage('assets/images/orange.png'),
                              ),
                              SizedBox(
                                width: getWidth(context, 3),
                              ),
                              Text(
                                "Profile Information",
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
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const OrderScreen()),
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
                                      Icons.shopping_bag,
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
                                "My Order",
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
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LanguageScreen()),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
