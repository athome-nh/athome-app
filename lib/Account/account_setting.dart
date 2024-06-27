import 'dart:convert';
import 'package:dllylas/Account/about_screen.dart';
import 'package:dllylas/Account/all_gudide.dart';
import 'package:dllylas/Account/feedback.dart';
import 'package:dllylas/Account/help_screen.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Notifications/notification_page.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import '../Landing/splash_screen.dart';
import '../Network/Network.dart';
import '../controller/cartprovider.dart';
import '../home/nav_switch.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  bool waiting = false;
  String selectedLanguage = 'English';
  String selectedItem = 'English';

  @override
  void initState() {
    selectedItem = lang == "en"
        ? "English".tr
        : lang == "ar"
            ? "Arabic".tr
            : "Kurdish".tr;
    super.initState();
  }

  void _updateLanguage(String language) {
    selectedItem = language;
    if (selectedItem == 'English') {
      lang = "en";
      Get.updateLocale(const Locale("en"));
      setStringPrefs("lang", "en");
    } else if (selectedItem == 'Arabic') {
      lang = "ar";
      Get.updateLocale(const Locale("ar"));
      setStringPrefs("lang", "ar");
    } else if (selectedItem == 'Kurdish') {
      lang = "kur";
      Get.updateLocale(const Locale("kur"));
      setStringPrefs("lang", "kur");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<productProvider>(context, listen: true).nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              // AppBar
              appBar: AppBar(
                leading: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios,
                    )),
                title: Text(
                  "Account Settings".tr,
                ),
              ),

              // body
              body: !isLogin
                  ? loginFirstContainer(context)
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          // Title 1
                          SizedBox(height: getHeight(context, 2)),
                          _titles("Setting"),

                          // Notification Setting
                          _listTiles(Ionicons.notifications_outline,
                              'Notification Setting', NotificationPage()),

                          // Language
                          _Language(Ionicons.globe_outline, 'Language'),

                          // Title 2
                          SizedBox(height: getHeight(context, 2)),
                          _titles("Support"),

                          // Help center
                          _listTiles(Icons.description_outlined, "Help center",
                              HelpScreen()),

                          // About us
                          _listTiles(Icons.privacy_tip_outlined, 'About us',
                              AboutScreen()),

                          // Guide
                          _listTiles(
                              Icons.support_agent, 'Guide', GudidePage()),

                          // Feedback
                          _listTiles(Icons.feedback_outlined, 'Feedback',
                              FeedbackScreen()),

                          // Delete Account
                          _DeleteAccount(
                              Ionicons.trash_outline, 'Delete Account'),
                        ],
                      ),
                    ),
            ),
          );
  }

  Widget _titles(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: mainFontbold,
          color: mainColorGrey,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _listTiles(IconData icon, String title, Widget destination) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 24),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: mainFontnormal,
                color: mainColorGrey,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination,
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }

  Widget _Language(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(icon, size: 24),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: mainFontnormal,
                color: mainColorGrey,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Icon(Icons.keyboard_arrow_right_outlined),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('Select Language'),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      RadioListTile<String>(
                        title: Row(children: [
                          Image.asset(
                            "assets/images/uk.png",
                            width: 35,
                            height: 35,
                          ),
                          Container(
                            padding: EdgeInsets.only(
                              top: getWidth(context, 2),
                              left: getWidth(context, 2),
                              right: getWidth(context, 2),
                              bottom: getWidth(context, 1),
                            ),
                            child: Text(
                              "English".tr,
                            ),
                          ),
                        ]),
                        value: 'English',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                            _updateLanguage(selectedLanguage);
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Image.asset(
                              "assets/images/iraq.png",
                              width: 35,
                              height: 35,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: getWidth(context, 2),
                                left: getWidth(context, 2),
                                right: getWidth(context, 2),
                                bottom: getWidth(context, 1),
                              ),
                              child: Text(
                                "Arabic".tr,
                              ),
                            ),
                          ],
                        ),
                        value: 'Arabic',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                            _updateLanguage(selectedLanguage);
                          });
                        },
                      ),
                      RadioListTile<String>(
                        title: Row(
                          children: [
                            Image.asset(
                              "assets/images/flag.png",
                              width: 35,
                              height: 35,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                top: getWidth(context, 2),
                                left: getWidth(context, 2),
                                right: getWidth(context, 2),
                                bottom: getWidth(context, 1),
                              ),
                              child: Text(
                                "Kurdish".tr,
                              ),
                            ),
                          ],
                        ),
                        value: 'Kurdish',
                        groupValue: selectedLanguage,
                        onChanged: (value) {
                          setState(() {
                            selectedLanguage = value!;
                            _updateLanguage(selectedLanguage);
                          });
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }

  Widget _DeleteAccount(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading: Icon(
            icon,
            size: 24,
            color: mainColorRed,
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: mainFontnormal,
                color: mainColorRed,
                fontSize: 16,
              ),
            ),
          ),
          trailing:
              Icon(Icons.keyboard_arrow_right_outlined, color: mainColorRed),
          onTap: waiting
              ? null
              : () {
                  setState(() {
                    waiting = true;
                  });
                  var data = {
                    "id": userdata["id"].toString(),
                  };
                  Network(false)
                      .postData("delete", data, context)
                      .then((value) async {
                    if (value != "") {
                      if (value["code"] == "201") {
                        getStringPrefs("data").then((map) {
                          Map<String, dynamic> myMap = json.decode(map);
                          myMap["islogin"] = false;
                          myMap["token"] = "";
                          setStringPrefs("data", json.encode(myMap));
                        });

                        final cartProvider =
                            Provider.of<CartProvider>(context, listen: false);
                        final product = Provider.of<productProvider>(context,
                            listen: false);

                        setState(() {
                          userdata = {};
                          token = "";
                          isLogin = false;
                        });
                        product.Orderitems.clear();
                        product.location.clear();
                        product.Orders.clear();
                        cartProvider.cartItems.clear();
                        cartProvider.FavItems.clear();

                        Navigator.pop(context);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => NavSwitch()),
                        );
                      } else {
                        setState(() {
                          waiting = false;
                        });
                      }
                    } else {
                      setState(() {
                        waiting = false;
                      });
                    }
                  });
                },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(height: 1, thickness: 1),
        ),
      ],
    );
  }
}
