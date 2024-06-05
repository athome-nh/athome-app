import 'package:dllylas/Account/about_screen.dart';
import 'package:dllylas/Account/account_info.dart';
import 'package:dllylas/Account/all_gudide.dart';
import 'package:dllylas/Account/feedback.dart';
import 'package:dllylas/Account/help_screen.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/my_widget.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/TermsandCondition.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';

import '../Notifications/notification_page.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  String selectedItem = 'English';
  void initState() {
    selectedItem = lang == "en"
        ? "English"
        : lang == "ar"
            ? "Arabic"
            : "Kurdish";
    super.initState();
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
                          _listTiles(Ionicons.globe_outline, 'Language',
                              LanguageSelectionTile()),

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

                          // Refer a friend
                          _listTiles(Icons.person_add_outlined,
                              'Refer a friend', TermsandCondition()),

                          // Delete Account
                          _listTiles(Ionicons.trash_outline, 'Delete Account',
                              TermsandCondition()),

                          // Logout
                          // Padding(
                          //   padding: const EdgeInsets.all(20.0),
                          //   child: ElevatedButton(
                          //     onPressed: () {
                          //       var data = {"id": userdata["id"].toString()};
                          //       Network(false)
                          //           .postData("logout", data, context)
                          //           .then((value) {
                          //         getStringPrefs("data").then((map) {
                          //           Map<String, dynamic> myMap =
                          //               json.decode(map);
                          //           myMap["islogin"] = false;
                          //           myMap["token"] = "";
                          //           setStringPrefs("data", json.encode(myMap));
                          //         });
                          //         final cartProvider =
                          //             Provider.of<CartProvider>(context,
                          //                 listen: false);
                          //         final product = Provider.of<productProvider>(
                          //             context,
                          //             listen: false);
                          //         setState(() {
                          //           userdata = {};
                          //           token = "";
                          //           isLogin = false;
                          //         });
                          //         product.Orderitems.clear();
                          //         product.location.clear();
                          //         product.Orders.clear();
                          //         cartProvider.cartItems.clear();
                          //         cartProvider.FavItems.clear();
                          //         Navigator.pushReplacement(
                          //           context,
                          //           MaterialPageRoute(
                          //               builder: (context) => NavSwitch()),
                          //         );
                          //       });
                          //     },
                          //     style: ElevatedButton.styleFrom(
                          //       foregroundColor: Colors.black,
                          //       backgroundColor: Colors.white,
                          //       minimumSize: Size(double.infinity, 50),
                          //       side: BorderSide(color: Colors.grey),
                          //     ),
                          //     child: Text('Logout'),
                          //   ),
                          // ),
                        ],
                      ),
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

  // Widget _listTile1(IconData icon, String title) {
  //   return Column(
  //     children: [
  //       ListTile(
  //         leading: Icon(icon, size: 24),
  //         title: Column(
  //           crossAxisAlignment: CrossAxisAlignment.start,
  //           children: [
  //             PopupMenuButton(
  //                 icon: selectedItem == 'English'
  //                     ? Text(
  //                         "English".tr,
  //                       )
  //                     : selectedItem == 'Arabic'
  //                         ? Text(
  //                             "Arabic".tr,
  //                           )
  //                         : Text(
  //                             "Kurdish".tr,
  //                           ),
  //                 itemBuilder: (context) {
  //                   return [
  //                     PopupMenuItem<int>(
  //                       value: 0,
  //                       child: Row(
  //                         children: [
  //                           Image.asset(
  //                             "assets/images/uk.png",
  //                             width: 35,
  //                             height: 35,
  //                           ),
  //                           Container(
  //                             padding: EdgeInsets.only(
  //                               top: getWidth(context, 2),
  //                               left: getWidth(context, 2),
  //                               right: getWidth(context, 2),
  //                               bottom: getWidth(context, 1),
  //                             ),
  //                             child: Text(
  //                               "English".tr,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     PopupMenuItem<int>(
  //                       value: 1,
  //                       child: Row(
  //                         children: [
  //                           Image.asset(
  //                             "assets/images/iraq.png",
  //                             width: 35,
  //                             height: 35,
  //                           ),
  //                           Container(
  //                             padding: EdgeInsets.only(
  //                               top: getWidth(context, 2),
  //                               left: getWidth(context, 2),
  //                               right: getWidth(context, 2),
  //                               bottom: getWidth(context, 1),
  //                             ),
  //                             child: Text(
  //                               "Arabic".tr,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                     PopupMenuItem<int>(
  //                       value: 2,
  //                       child: Row(
  //                         children: [
  //                           Image.asset(
  //                             "assets/images/flag.png",
  //                             width: 35,
  //                             height: 35,
  //                           ),
  //                           Container(
  //                             padding: EdgeInsets.only(
  //                               top: getWidth(context, 2),
  //                               left: getWidth(context, 2),
  //                               right: getWidth(context, 2),
  //                               bottom: getWidth(context, 1),
  //                             ),
  //                             child: Text(
  //                               "Kurdish".tr,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     ),
  //                   ];
  //                 },
  //                 onSelected: (value) {
  //                   selectedItem = value == 0
  //                       ? 'English'
  //                       : value == 1
  //                           ? 'Arabic'
  //                           : 'Kurdish';
  //                   if (selectedItem == 'English') {
  //                     lang = "en";
  //                     Get.updateLocale(const Locale("en"));
  //                     setStringPrefs("lang", "en");
  //                   } else if (selectedItem == 'Arabic') {
  //                     lang = "ar";
  //                     Get.updateLocale(const Locale("ar"));
  //                     setStringPrefs("lang", "ar");
  //                   } else {
  //                     lang = "kur";
  //                     Get.updateLocale(const Locale("kur"));
  //                     setStringPrefs("lang", "kur");
  //                   }
  //                 }),
  //           ],
  //         ),
  //         trailing: Icon(Icons.keyboard_arrow_right_outlined),
  //       ),
  //       Padding(
  //         padding: const EdgeInsets.symmetric(horizontal: 16.0),
  //         child: Divider(height: 1, thickness: 1),
  //       ),
  //     ],
  //   );
  // }

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
}






class LanguageSelectionTile extends StatefulWidget {
  @override
  _LanguageSelectionTileState createState() => _LanguageSelectionTileState();
}

class _LanguageSelectionTileState extends State<LanguageSelectionTile> {
  String selectedItem = 'English';
  String lang = 'en';

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LanguageSelectionDialog(
          selectedItem: selectedItem,
          onSelected: (value) {
            setState(() {
              selectedItem = value;
              lang = value == 'English' ? 'en' : value == 'Arabic' ? 'ar' : 'kur';
              Get.updateLocale(Locale(lang));
              setStringPrefs("lang", lang);
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        selectedItem == 'English'
            ? "English".tr
            : selectedItem == 'Arabic'
                ? "Arabic".tr
                : "Kurdish".tr,
      ),
      onTap: _showLanguageDialog,
    );
  }
}

class LanguageSelectionDialog extends StatelessWidget {
  final String selectedItem;
  final Function(String) onSelected;

  LanguageSelectionDialog({required this.selectedItem, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Select Language".tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RadioListTile<String>(
            title: Row(
              children: [
                Image.asset(
                  "assets/images/uk.png",
                  width: 35,
                  height: 35,
                ),
                SizedBox(width: 10),
                Text("English".tr),
              ],
            ),
            value: 'English',
            groupValue: selectedItem,
            onChanged: (value) {
              onSelected(value!);
              Navigator.of(context).pop();
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
                SizedBox(width: 10),
                Text("Arabic".tr),
              ],
            ),
            value: 'Arabic',
            groupValue: selectedItem,
            onChanged: (value) {
              onSelected(value!);
              Navigator.of(context).pop();
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
                SizedBox(width: 10),
                Text("Kurdish".tr),
              ],
            ),
            value: 'Kurdish',
            groupValue: selectedItem,
            onChanged: (value) {
              onSelected(value!);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Cancel".tr),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}


