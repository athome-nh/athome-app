// Import necessary packages and libraries
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dllylas/Account/about_screen.dart';
import 'package:dllylas/Account/account_info_2.dart';
import 'package:dllylas/Account/all_gudide.dart';
import 'package:dllylas/Account/chatscreen.dart';
import 'package:dllylas/Account/reward.dart';
import 'package:dllylas/Account/voucher_code.dart';
import 'package:dllylas/Config/athome_functions.dart';
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

// Stateful widget for the Profile Screen
class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String selectedItem = 'English'; // Default selected language

  /// Updates the language preference and saves it in shared preferences.
  ///
  /// [language] - The new language selected by the user.
  void _updateLanguage(String language) {
    setState(() {
      selectedItem = language; // Update the selected language
    });

    // Apply and save the selected language
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

  bool waiting = false; // Loading state, if needed

  @override
  void initState() {
    super.initState();

    // Set the initial language based on the saved language preference
    selectedItem = lang == "en"
        ? "English"
        : lang == "ar"
            ? "Arabic"
            : "Kurdish";
  }

  @override
  Widget build(BuildContext context) {
    // Check for internet connectivity, and display noInternetWidget if offline
    return Provider.of<productProvider>(context, listen: true).nointernetCheck
        ? noInternetWidget(context)
        : Directionality(
            textDirection: lang == "en"
                ? TextDirection.ltr
                : TextDirection.rtl, // Set text direction based on language
            child: Scaffold(
              body: !isLogin // Check if the user is logged in
                  ? _guestAccount(
                      context) // Display guest account UI if not logged in
                  : !Provider.of<productProvider>(context, listen: true)
                          .showuser
                      ? Skeletonizer(
                          // Show shimmer effect while loading user data
                          effect: ShimmerEffect.raw(colors: [
                            mainColorGrey.withOpacity(0.1),
                            mainColorWhite,
                          ]),
                          enabled: true,
                          child: Column(
                            children: [
                              // Top section with user's profile picture, name, and details
                              Container(
                                height: getHeight(context, 25),
                                color: mainColorlightGrey,
                                padding: EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 20),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    // Shimmer effect on the profile picture
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

                                    // Shimmer effect on the user's name, phone, and points
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(height: getHeight(context, 4)),

                                        // User's name with rank icon
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

                                        // User's phone number
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

                                        // User's points
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

                              // Displaying menu items with shimmer effect
                              Expanded(
                                flex: 10,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      // Account & Security section title
                                      SizedBox(height: getHeight(context, 2)),
                                      _titles("Account & Security".tr),

                                      // Account-related menu items
                                      _listTiles(
                                          Icons.person_outline,
                                          'Account Information'.tr,
                                          AccountInfo2()),
                                      _listTiles(Ionicons.bag_outline,
                                          'Orders'.tr, OrderScreen()),
                                      _listTiles(Ionicons.location_outline,
                                          'Locations'.tr, LocationScreen()),
                                      _listTiles(Icons.person_add_outlined,
                                          'Invite a friend'.tr, InvitePage()),
                                      _listTiles(Icons.monetization_on_outlined,
                                          'Coin & Reward'.tr, coinReward()),
                                      _listTiles(Icons.card_giftcard,
                                          'My Voucher'.tr, VoucherCodePage()),
                                      _listTiles(
                                          Icons.settings_outlined,
                                          'Account Settings'.tr,
                                          AccountSetting()),

                                      // General section title
                                      SizedBox(height: getHeight(context, 2)),
                                      _titles("General".tr),

                                      // General-related menu items
                                      _listTiles(
                                          Icons.description_outlined,
                                          "Terms & Conditions".tr,
                                          TermsandCondition()),
                                      _listTiles(Icons.privacy_tip_outlined,
                                          'Privacy Policy'.tr, PrivacyScreen()),
                                      _listTiles(Icons.support_agent,
                                          'Customer Services'.tr, ChatScreen()),

                                      // Logout button
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 43, left: 15, right: 15),
                                        child: TextButton(
                                          onPressed: () {
                                            yesNoOption(
                                                context); // Show logout confirmation dialog
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
                                          child: Text('Logout'
                                              .tr), // Logout text with translation
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
                          // If user data is loaded, display the actual user details
                          children: [
                            // User's profile with real data
                            Container(
                              height: getHeight(context, 25),
                              color: mainColorlightGrey,
                              padding: EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // User's profile picture
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

                                  // Displaying user's name, phone, and points
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(height: getHeight(context, 4)),

                                      // User's name
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

                                      // User's phone number
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

                                      // User's points
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

                            // All menu items for the logged-in user
                            Expanded(
                              flex: 10,
                              child: SingleChildScrollView(
                                child: Column(
                                  children: [
                                    // Account & Security section title
                                    SizedBox(height: getHeight(context, 2)),
                                    _titles("Account & Security".tr),

                                    // Menu items for account-related features
                                    _listTiles(
                                        Icons.person_outline,
                                        'Account Information'.tr,
                                        AccountInfo2()),
                                    _listTiles(Ionicons.bag_outline,
                                        'Orders'.tr, OrderScreen()),
                                    _listTiles(Ionicons.location_outline,
                                        'Locations'.tr, LocationScreen()),
                                    _listTiles(Icons.person_add_outlined,
                                        'Invite a friend'.tr, InvitePage()),
                                    _listTiles(Icons.monetization_on_outlined,
                                        'Coin & Reward'.tr, coinReward()),
                                    _listTiles(Icons.card_giftcard,
                                        'My Voucher'.tr, VoucherCodePage()),
                                    _listTiles(
                                        Icons.settings_outlined,
                                        'Account Settings'.tr,
                                        AccountSetting()),

                                    // General section title
                                    SizedBox(height: getHeight(context, 2)),
                                    _titles("General".tr),

                                    // General settings and logout option
                                    _listTiles(
                                        Icons.description_outlined,
                                        "Terms & Conditions".tr,
                                        TermsandCondition()),
                                    _listTiles(Icons.privacy_tip_outlined,
                                        'Privacy Policy'.tr, PrivacyScreen()),
                                    _listTiles(Icons.support_agent,
                                        'Customer Services'.tr, ChatScreen()),

                                    // Logout button
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

  /// Creates a ListTile widget with an icon, a title, and a trailing arrow icon
  /// to navigate to a different screen. It also includes a divider at the bottom.
  ///
  /// [icon] - The icon to display at the leading position of the ListTile.
  /// [title] - The title of the ListTile, which will be translated using the `.tr` method.
  /// [destination] - The widget that will be navigated to when the ListTile is tapped.
  Widget _listTiles(IconData icon, String title, Widget destination) {
    return Column(
      children: [
        // The main ListTile containing an icon, a title, and a trailing arrow
        ListTile(
          leading: Icon(
            icon, // Leading icon
            size: 24, // Icon size
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title.tr, // Translate the title based on the current locale
              style: TextStyle(
                fontFamily: mainFontnormal, // Custom font style
                color: mainColorGrey, // Title color
                fontSize: sizeSubtitle, // Font size for the title
              ),
            ),
          ),
          // Trailing arrow icon that adjusts based on the current language direction
          trailing: Icon(
            lang == "en"
                ? Icons
                    .keyboard_arrow_right_outlined // Arrow points to the right for English (LTR)
                : Icons
                    .keyboard_arrow_left_outlined, // Arrow points to the left for Arabic/Kurdish (RTL)
          ),

          // Action when the ListTile is tapped: navigate to the destination widget
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => destination, // Build the destination page
              ),
            ).then((value) {
              setState(
                  () {}); // Refresh the current screen when the user returns from the destination
            });
          },
        ),

        // Divider below the ListTile to separate the list items visually
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            height: 1, // Space around the divider
            thickness: 1, // Divider thickness
          ),
        ),
      ],
    );
  }

  /// Creates a styled title widget with padding and alignment.
  ///
  /// [title] - The text of the title, which will be translated using the `.tr` method.
  Widget _titles(String title) {
    return Container(
      // Adds vertical and horizontal padding around the title
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),

      // Aligns the title text to the left of the container
      alignment: Alignment.centerLeft,

      // Text widget displaying the title
      child: Text(
        title.tr, // Translate the title based on the current locale
        style: TextStyle(
          fontFamily: mainFontbold, // Applies a bold font style
          color: mainColorGrey, // Sets the color to a predefined grey color
          fontSize: sizeTitle, // Uses a predefined font size for titles
        ),
      ),
    );
  }

  /// Creates the guest account screen with a shimmer effect for loading state.
  ///
  /// This widget is displayed when the user is not logged in and represents
  /// the guest account view, providing options such as help center, about us,
  /// and registration.
  ///
  /// [context] - The BuildContext provided by Flutter for widget tree navigation and layout.
  Widget _guestAccount(context) {
    return Skeletonizer(
      effect: ShimmerEffect.raw(
        colors: [
          mainColorGrey.withOpacity(0.1),
          mainColorWhite,
        ],
      ),
      enabled: productProvider()
          .show, // Enables shimmer effect if productProvider shows loading
      child: SingleChildScrollView(
        child: Column(
          children: [
            // Guest account header with image, name, phone, and points
            Container(
              height: getHeight(context, 25),
              color: mainColorlightGrey,
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Guest image section
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

                  // Guest information: name, phone, and points
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: getHeight(context, 4)),

                      // Guest name row
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
                                fontSize: sizeSubtitle,
                                color: mainColorBlack,
                                fontFamily: mainFontnormal,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getHeight(context, 1)),

                      // Placeholder phone number row
                      Row(
                        children: [
                          Icon(Icons.call, size: 20),
                          SizedBox(width: getHeight(context, 1)),
                          Padding(
                            padding:
                                EdgeInsets.only(top: getHeight(context, 0.5)),
                            child: Text(
                              "+964 7-- --- ----", // Placeholder phone number for guest
                              style: TextStyle(
                                fontSize: sizeSubtitle,
                                color: mainColorBlack,
                                fontFamily: mainFontnormal,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: getHeight(context, 1)),

                      // Placeholder points row
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 11,
                            backgroundImage:
                                AssetImage("assets/images/star.png"),
                          ),
                          SizedBox(width: getHeight(context, 1)),
                          Padding(
                            padding:
                                EdgeInsets.only(top: getHeight(context, 0.5)),
                            child: Text(
                              "0", // Placeholder points for guest
                              style: TextStyle(
                                fontSize: sizeSubtitle,
                                color: mainColorBlack,
                                fontFamily: mainFontnormal,
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

            // General settings title
            SizedBox(height: getHeight(context, 2)),
            _titles("General".tr),

            // Guest options list: Language, Help Center, About Us, Guide, Terms & Privacy
            _Language(Ionicons.globe_outline, 'Language'.tr),
            _listTiles(
                Icons.description_outlined, "Help center".tr, HelpScreen()),
            _listTiles(Icons.privacy_tip_outlined, 'About us', AboutScreen()),
            _listTiles(Icons.support_agent, 'Guide', GuidePage()),
            _listTiles(Icons.description_outlined, "Terms & Conditions",
                TermsandCondition()),
            _listTiles(
                Icons.privacy_tip_outlined, 'Privacy Policy', PrivacyScreen()),

            // Register button
            Padding(
              padding: const EdgeInsets.only(top: 43, left: 15, right: 15),
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegisterWithPhoneNumber(),
                    ),
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
                  "Register".tr, // Translated register button text
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Creates a list tile for selecting a language.
  ///
  /// This widget provides a user interface for selecting a language, including
  /// displaying a dialog with radio options for different languages when tapped.
  ///
  /// [icon] - The icon to display on the leading side of the list tile.
  /// [title] - The title text to display in the list tile.
  Widget _Language(IconData icon, String title) {
    return Column(
      children: [
        ListTile(
          leading:
              Icon(icon, size: 24), // Icon displayed at the start of the tile
          title: Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Text(
              title,
              style: TextStyle(
                fontFamily: fontNormalChoose(), // Font style for the title
                color: mainColorGrey, // Color of the title text
                fontSize: sizeSubtitle, // Font size of the title text
              ),
            ),
          ),
          trailing: Icon(
            lang == "en"
                ? Icons
                    .keyboard_arrow_right_outlined // Right arrow if language is English
                : Icons
                    .keyboard_arrow_left_outlined, // Left arrow if language is not English
          ),
          onTap: () {
            // Shows a dialog when the list tile is tapped
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Directionality(
                  textDirection: lang == "en"
                      ? TextDirection
                          .ltr // Left-to-right text direction for English
                      : TextDirection
                          .rtl, // Right-to-left text direction for other languages
                  child: AlertDialog(
                    title: Text('Select Language'), // Dialog title
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        // English language option
                        RadioListTile<String>(
                          title: Row(
                            children: [
                              Image.asset(
                                "assets/images/uk.png", // English flag image
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
                                  "English".tr, // Translated English text
                                ),
                              ),
                            ],
                          ),
                          value: 'English',
                          groupValue:
                              selectedItem, // Currently selected language
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value!; // Update selected item
                              _updateLanguage(
                                  selectedItem); // Update the language setting
                            });
                          },
                        ),
                        // Arabic language option
                        RadioListTile<String>(
                          title: Row(
                            children: [
                              Image.asset(
                                "assets/images/iraq.png", // Arabic flag image
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
                                  "Arabic".tr, // Translated Arabic text
                                ),
                              ),
                            ],
                          ),
                          value: 'Arabic',
                          groupValue:
                              selectedItem, // Currently selected language
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value!; // Update selected item
                              _updateLanguage(
                                  selectedItem); // Update the language setting
                            });
                          },
                        ),
                        // Kurdish language option
                        RadioListTile<String>(
                          title: Row(
                            children: [
                              Image.asset(
                                "assets/images/flag.png", // Kurdish flag image
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
                                  "Kurdish".tr, // Translated Kurdish text
                                ),
                              ),
                            ],
                          ),
                          value: 'Kurdish',
                          groupValue:
                              selectedItem, // Currently selected language
                          onChanged: (value) {
                            setState(() {
                              selectedItem = value!; // Update selected item
                              _updateLanguage(
                                  selectedItem); // Update the language setting
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
          child: Divider(
              height: 1, thickness: 1), // Divider line below the list tile
        ),
      ],
    );
  }

  /// Displays a confirmation dialog asking if the user is sure they want to log out.
  ///
  /// This dialog presents two options: "Yes" and "No". If "Yes" is selected,
  /// it logs the user out and clears their data. If "No" is selected, it closes
  /// the dialog and does nothing.
  ///
  /// [context] - The BuildContext used to display the dialog.
  Future<void> yesNoOption(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, // Allows the dialog to be dismissed by tapping outside it
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context2, state) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            content: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: ClipRect(
                child: Container(
                  width:
                      getWidth(context, 90), // Sets the width of the container
                  height: getHeight(
                      context, 20), // Sets the height of the container
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        15), // Rounds the corners of the container
                  ),
                  padding: const EdgeInsets.all(10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: getHeight(
                          context, 20), // Sets the maximum height constraint
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const SizedBox(), // Empty space
                        Text(
                          "Are you sure Logout", // Text displayed in the dialog
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: mainColorBlack, // Color of the text
                            fontFamily: mainFontnormal, // Font of the text
                            fontSize: sizeTitle, // Font size of the text
                          ),
                        ),
                        const SizedBox(), // Empty space
                        const SizedBox(), // Empty space
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const SizedBox(), // Empty space
                            // "No" button
                            TextButton(
                              onPressed: () async {
                                Navigator.pop(context); // Closes the dialog
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    mainColorRed, // Background color of the button
                                fixedSize: Size(
                                    getWidth(context, 30),
                                    getHeight(
                                        context, 4)), // Size of the button
                              ),
                              child: Text(
                                "No".tr, // Translated text for "No"
                              ),
                            ),
                            // "Yes" button
                            TextButton(
                              onPressed: () {
                                // Data to be sent with the logout request
                                var data = {"id": userdata["id"].toString()};
                                Network(false)
                                    .postData("logout", data, context)
                                    .then((value) {
                                  // Clears user data from preferences
                                  getStringPrefs("data").then((map) {
                                    Map<String, dynamic> myMap =
                                        json.decode(map);
                                    myMap["islogin"] = false;
                                    myMap["token"] = "";
                                    setStringPrefs("data", json.encode(myMap));
                                  });
                                  clearPrifrences(); // Clears preferences

                                  // Resets user and cart data
                                  final cartProvider =
                                      Provider.of<CartProvider>(context,
                                          listen: false);
                                  final product = Provider.of<productProvider>(
                                      context,
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

                                  // Navigates to the main screen
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => NavSwitch()),
                                  );
                                });
                              },
                              style: TextButton.styleFrom(
                                fixedSize: Size(
                                    getWidth(context, 30),
                                    getHeight(
                                        context, 4)), // Size of the button
                              ),
                              child: Text(
                                "Yes".tr, // Translated text for "Yes"
                              ),
                            ),
                            const SizedBox(), // Empty space
                          ],
                        ),
                      ],
                    ),
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
