import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Account/about_screen.dart';
import 'package:dllylas/Account/account_info_2.dart';
import 'package:dllylas/Account/all_gudide.dart';
import 'package:dllylas/Account/chatscreen.dart';
import 'package:dllylas/Account/reward.dart';
import 'package:dllylas/Account/voucher_code.dart';
import 'package:dllylas/Config/local_data.dart';
import 'package:dllylas/Config/property.dart';
import 'package:dllylas/Network/Network.dart';
import 'package:dllylas/Order/order_screen.dart';
import 'package:dllylas/Privacy.dart';
import 'package:dllylas/TermsandCondition.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/controller/productprovider.dart';
import 'package:dllylas/home/nav_switch.dart';
import 'package:dllylas/main.dart';
import 'package:dllylas/map/loction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../Config/my_widget.dart';
import '../Landing/login_page.dart';
import '../Landing/splash_screen.dart';
import 'account_setting.dart';
import 'help_screen.dart';
import 'invite_friend.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedItem = 'English';

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

  bool waiting = false;

  @override
  void initState() {
    selectedItem = lang == "en"
        ? "English"
        : lang == "ar"
            ? "Arabic"
            : "Kurdish";

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Provider.of<productProvider>(context, listen: true).nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
            child: Scaffold(
              // body
              body: !isLogin
                  ? _guestAccount(context)
                  : !Provider.of<productProvider>(context, listen: true)
                          .showuser
                      ? Skeletonizer(
                          effect: ShimmerEffect.raw(colors: [
                            mainColorGrey.withOpacity(0.1),
                            mainColorWhite,
                          ]),
                          enabled: true,
                          child: Column(
                            children: [
                              // top side for Shimmer
                              Container(
                                height: getHeight(context, 25),
                                color: mainColorlightGrey,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // image of shimmer
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        CircleAvatar(
                                          radius: getWidth(context, 16),
                                          backgroundColor: mainColorWhite,
                                          backgroundImage: AssetImage(
                                              "assets/Victors/guest.png"),
                                        ),
                                      ],
                                    ),

                                    SizedBox(width: getHeight(context, 4)),

                                    // Name and phone and point of shimmer
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: getHeight(context, 4)),

                                        // name of shimmer
                                        Row(
                                          children: [
                                            Image.asset(
                                              "assets/rank/IV.png",
                                              width: getWidth(context, 6),
                                              height: getWidth(context, 6),
                                            ),
                                            SizedBox(
                                                width: getHeight(context, 1)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: getHeight(context, 0.5)),
                                              child: Text(
                                                userdata["name"].toString(),
                                                style: TextStyle(
                                                  fontFamily: mainFontbold,
                                                  fontSize: 14,
                                                  color: mainColorBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: getHeight(context, 1)),

                                        // phone of shimmer
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.call,
                                              size: 20,
                                            ),
                                            SizedBox(
                                                width: getHeight(context, 1)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: getHeight(context, 0.5)),
                                              child: Text(
                                                userdata["phone"].toString(),
                                                style: TextStyle(
                                                  fontFamily: mainFontbold,
                                                  fontSize: 14,
                                                  color: mainColorBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),

                                        SizedBox(height: getHeight(context, 1)),

                                        // point of shimmer
                                        Row(
                                          children: [
                                            CircleAvatar(
                                              radius: 11,
                                              backgroundImage: AssetImage(
                                                "assets/images/star.png",
                                              ),
                                            ),
                                            SizedBox(
                                                width: getHeight(context, 1)),
                                            Padding(
                                              padding: EdgeInsets.only(
                                                  top: getHeight(context, 0.5)),
                                              child: Text(
                                                userdata["point"].toString(),
                                                style: TextStyle(
                                                  fontFamily: mainFontbold,
                                                  fontSize: 14,
                                                  color: mainColorBlack,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // all menu of shimmer
                              Expanded(
                                flex: 10,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // Title 1
                                      SizedBox(height: getHeight(context, 2)),
                                      _titles("Account & Security".tr),

                                      // Account Information
                                      _listTiles(
                                          Icons.person_outline,
                                          'Account Information'.tr,
                                          AccountInfo2()),

                                      // Orders
                                      _listTiles(Ionicons.bag_outline,
                                          'Orders'.tr, OrderScreen()),

                                      // Locations
                                      _listTiles(Ionicons.location_outline,
                                          'Locations'.tr, LocationScreen()),

                                      // Refer a friend
                                      _listTiles(Icons.person_add_outlined,
                                          'Invite a friend'.tr, InvitePage()),

                                      // Coin & Reward
                                      _listTiles(Icons.monetization_on_outlined,
                                          'Coin & Reward'.tr, coinReward()),

                                      // My Voucher
                                      _listTiles(Icons.card_giftcard,
                                          'My Voucher'.tr, VoucherCodePage()),

                                      // Account Settings
                                      _listTiles(
                                          Icons.settings_outlined,
                                          'Account Settings'.tr,
                                          AccountSetting()),

                                      // Title 2
                                      SizedBox(height: getHeight(context, 2)),
                                      _titles("General".tr),

                                      // Terms & Conditions
                                      _listTiles(
                                          Icons.description_outlined,
                                          "Terms & Conditions".tr,
                                          TermsandCondition()),

                                      // Privacy Policy
                                      _listTiles(Icons.privacy_tip_outlined,
                                          'Privacy Policy'.tr, PrivacyScreen()),

                                      // Customer Services
                                      _listTiles(Icons.support_agent,
                                          'Customer Services'.tr, ChatScreen()),

                                      // Logout
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 43, left: 15, right: 15),
                                        child: TextButton(
                                          onPressed: () {
                                            yesNoOption(context);
                                          },
                                          style: TextButton.styleFrom(
                                            minimumSize:
                                                Size(double.infinity, 50),
                                            side: BorderSide(
                                              color: grey.withOpacity(0.5),
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          child: Text('Logout'.tr),
                                        ),
                                      ),

                                      SizedBox(height: getHeight(context, 5)),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : Column(
                          children: [
                            // top side for user page
                            Container(
                              height: getHeight(context, 25),
                              color: mainColorlightGrey,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // image
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Skeleton.keep(
                                        child: CircleAvatar(
                                          radius: getWidth(context, 16),
                                          backgroundColor: mainColorWhite,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                            dotenv.env['imageUrlServer']! +
                                                userdata["img"],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(width: getHeight(context, 4)),

                                  // Name and phone and point
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: getHeight(context, 4)),

                                      // name
                                      Row(
                                        children: [
                                          Image.asset(
                                            "assets/rank/IV.png",
                                            width: getWidth(context, 6),
                                            height: getWidth(context, 6),
                                          ),
                                          SizedBox(
                                              width: getHeight(context, 1)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: getHeight(context, 0.5)),
                                            child: Text(
                                              userdata["name"].toString(),
                                              style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 14,
                                                color: mainColorBlack,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: getHeight(context, 1)),

                                      // phone
                                      Row(
                                        children: [
                                          Skeleton.keep(
                                            child: Icon(
                                              Icons.call,
                                              size: 20,
                                            ),
                                          ),
                                          SizedBox(
                                              width: getHeight(context, 1)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: getHeight(context, 0.5)),
                                            child: Text(
                                              userdata["phone"].toString(),
                                              style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 14,
                                                color: mainColorBlack,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: getHeight(context, 1)),

                                      // point
                                      Row(
                                        children: [
                                          Skeleton.keep(
                                            child: CircleAvatar(
                                              radius: 11,
                                              backgroundImage: AssetImage(
                                                "assets/images/star.png",
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                              width: getHeight(context, 1)),
                                          Padding(
                                            padding: EdgeInsets.only(
                                                top: getHeight(context, 0.5)),
                                            child: Text(
                                              userdata["point"].toString(),
                                              style: TextStyle(
                                                fontFamily: mainFontbold,
                                                fontSize: 14,
                                                color: mainColorBlack,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // all menu
                            Expanded(
                              flex: 10,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Title 1
                                    SizedBox(height: getHeight(context, 2)),
                                    _titles("Account & Security".tr),

                                    // Account Information
                                    _listTiles(
                                        Icons.person_outline,
                                        'Account Information'.tr,
                                        AccountInfo2()),

                                    // Orders
                                    _listTiles(Ionicons.bag_outline,
                                        'Orders'.tr, OrderScreen()),

                                    // Locations
                                    _listTiles(Ionicons.location_outline,
                                        'Locations'.tr, LocationScreen()),

                                    // Refer a friend
                                    _listTiles(Icons.person_add_outlined,
                                        'Invite a friend'.tr, InvitePage()),

                                    // Coin & Reward
                                    _listTiles(Icons.monetization_on_outlined,
                                        'Coin & Reward'.tr, coinReward()),

                                    // My Voucher
                                    _listTiles(Icons.card_giftcard,
                                        'My Voucher'.tr, VoucherCodePage()),

                                    // Account Settings
                                    _listTiles(
                                        Icons.settings_outlined,
                                        'Account Settings'.tr,
                                        AccountSetting()),

                                    // Title 2
                                    SizedBox(height: getHeight(context, 2)),
                                    _titles("General".tr),

                                    // Terms & Conditions
                                    _listTiles(
                                        Icons.description_outlined,
                                        "Terms & Conditions".tr,
                                        TermsandCondition()),

                                    // Privacy Policy
                                    _listTiles(Icons.privacy_tip_outlined,
                                        'Privacy Policy'.tr, PrivacyScreen()),

                                    // Customer Services
                                    _listTiles(Icons.support_agent,
                                        'Customer Services'.tr, ChatScreen()),

                                    // Logout
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 43, left: 15, right: 15),
                                      child: TextButton(
                                        onPressed: () {
                                          yesNoOption(context);
                                        },
                                        style: TextButton.styleFrom(
                                          minimumSize:
                                              Size(double.infinity, 50),
                                          side: BorderSide(
                                            color: grey.withOpacity(0.5),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text('Logout'.tr),
                                      ),
                                    ),

                                    SizedBox(height: getHeight(context, 5)),
                                  ],
                                ),
                              ),
                            ),
                          ],
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
              title.tr,
              style: TextStyle(
                fontFamily: mainFontnormal,
                color: mainColorGrey,
                fontSize: 16,
              ),
            ),
          ),
          trailing: Icon(lang == "en"
              ? Icons.keyboard_arrow_right_outlined
              : Icons.keyboard_arrow_left_outlined),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination,
              ),
            ).then(
              (value) {
                setState(() {});
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

  Widget _titles(String title) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Text(
        title.tr,
        style: TextStyle(
          fontFamily: mainFontbold,
          color: mainColorGrey,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget _guestAccount(context) {
    return Skeletonizer(
      effect: ShimmerEffect.raw(colors: [
        mainColorGrey.withOpacity(0.1),
        mainColorWhite,
        // mainColorRed.withOpacity(0.1),
      ]),
      enabled: productProvider().show,
      child: SingleChildScrollView(
        child: Column(
          children: [
            // top side in guest page
            Container(
              height: getHeight(context, 25),
              color: mainColorlightGrey,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // image
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Skeleton.keep(
                        child: CircleAvatar(
                          radius: getWidth(context, 16),
                          child: Image.asset(
                            "assets/Victors/guest.png",
                            width: getWidth(context, 40),
                          ),
                          backgroundColor: mainColorWhite,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: getHeight(context, 4)),

                  // Name and phone and point
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: getHeight(context, 4)),

                      // name
                      Row(
                        children: [
                          Image.asset(
                            "assets/rank/IV.png",
                            width: getWidth(context, 6),
                            height: getWidth(context, 6),
                          ),
                          SizedBox(width: getHeight(context, 1)),
                          Padding(
                            padding:
                                EdgeInsets.only(top: getHeight(context, 0.5)),
                            child: Text(
                              "Guest Account".tr,
                              style: TextStyle(
                                fontFamily: mainFontbold,
                                fontSize: 16,
                                color: mainColorBlack,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(context, 1)),
                      // phone
                      Row(
                        children: [
                          Icon(
                            Icons.call,
                            size: 20,
                          ),
                          SizedBox(width: getHeight(context, 1)),
                          Padding(
                            padding:
                                EdgeInsets.only(top: getHeight(context, 0.5)),
                            child: Text(
                              "+964 7-- --- ----",
                              style: TextStyle(
                                  fontFamily: mainFontbold,
                                  fontSize: 14,
                                  color: mainColorBlack),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: getHeight(context, 1)),
                      // point
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 11,
                            backgroundImage: AssetImage(
                              "assets/images/star.png",
                            ),
                          ),
                          SizedBox(width: getHeight(context, 1)),
                          Padding(
                            padding:
                                EdgeInsets.only(top: getHeight(context, 0.5)),
                            child: Text(
                              "0",
                              style: TextStyle(
                                  fontSize: 14,
                                  color: mainColorBlack,
                                  fontFamily: mainFontbold),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Title 1
            SizedBox(height: getHeight(context, 2)),
            _titles("General".tr),

            // Language
            _Language(Ionicons.globe_outline, 'Language'.tr),

            // Help center
            _listTiles(
                Icons.description_outlined, "Help center".tr, HelpScreen()),

            // About us
            _listTiles(Icons.privacy_tip_outlined, 'About us', AboutScreen()),

            // Guide
            _listTiles(Icons.support_agent, 'Guide', GuidePage()),

            // Terms & Conditions
            _listTiles(Icons.description_outlined, "Terms & Conditions",
                TermsandCondition()),

            // Privacy Policy
            _listTiles(
                Icons.privacy_tip_outlined, 'Privacy Policy', PrivacyScreen()),

            // Register
            Padding(
              padding: const EdgeInsets.only(top: 43, left: 15, right: 15),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegisterWithPhoneNumber()),
                  );
                },
                style: TextButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  side: BorderSide(
                    color: grey.withOpacity(0.5),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  "Register".tr,
                ),
              ),
            ),
          ],
        ),
      ),
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
          trailing: Icon(lang == "en"
              ? Icons.keyboard_arrow_right_outlined
              : Icons.keyboard_arrow_left_outlined),
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Directionality(
                  textDirection:
                      lang == "en" ? TextDirection.ltr : TextDirection.rtl,
                  child: AlertDialog(
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
                          groupValue: selectedItem,
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value!;
                              _updateLanguage(selectedItem);
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
                          groupValue: selectedItem,
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value!;
                              _updateLanguage(selectedItem);
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
                          groupValue: selectedItem,
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value!;
                              _updateLanguage(selectedItem);
                            });
                          },
                        ),
                      ],
                    ),
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

  Future<void> yesNoOption(
    BuildContext context,
  ) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, state) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ClipRect(
                child: Container(
                  width: getWidth(context, 90),
                  height: getHeight(context, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  padding: const EdgeInsets.all(10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: getHeight(context, 20),
                    ),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const SizedBox(),
                          Text(
                            "Are you sure Logout",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(),
                          const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              TextButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "No".tr,
                                ),
                              ),
                              TextButton(
                                onPressed: () {
                                  var data = {"id": userdata["id"].toString()};
                                  Network(false)
                                      .postData("logout", data, context)
                                      .then((value) {
                                    getStringPrefs("data").then((map) {
                                      Map<String, dynamic> myMap =
                                          json.decode(map);
                                      myMap["islogin"] = false;
                                      myMap["token"] = "";
                                      setStringPrefs(
                                          "data", json.encode(myMap));
                                    });
                                    clearPrifrences();
                                    final cartProvider =
                                        Provider.of<CartProvider>(context,
                                            listen: false);
                                    final product =
                                        Provider.of<productProvider>(context,
                                            listen: false);

                                    setState(() {
                                      userdata = {};
                                      token = "";
                                      isLogin = false;
                                    });
                                    product.Orderitems.clear();
                                    product.location.clear();
                                    product.Orders.clear();
                                    product.setshowuser(false);
                                    cartProvider.cartItems.clear();
                                    cartProvider.FavItems.clear();

                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => NavSwitch()),
                                    );
                                  });
                                },
                                style: TextButton.styleFrom(
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "Yes".tr,
                                ),
                              ),
                              const SizedBox(),
                            ],
                          ),
                        ]),
                  ),
                ),
              ),
            ),
          );
        });
      },
    );
  }
}
