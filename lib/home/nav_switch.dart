// Import necessary packages and libraries
import 'dart:io';
import 'package:dllylas/Account/profile.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/home/favorite.dart';
import 'package:dllylas/home/my_cart.dart';
import 'package:dllylas/home/newhomePage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:dllylas/Config/property.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:line_icons/line_icons.dart';

/// `NavSwitch` is a StatefulWidget that provides a bottom navigation bar
/// for switching between different pages in the app.
class NavSwitch extends StatefulWidget {
  // The index of the page to be displayed initially
  int pageNum = 0;

  /// Constructor for `NavSwitch`.
  ///
  /// The [pageNum] parameter sets the initial page index.
  NavSwitch({this.pageNum = 0, Key? key}) : super(key: key);

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

class _NavSwitchState extends State<NavSwitch> {
  // Index of the currently selected tab
  int selectedIndex = 0;

  // List of widgets to be displayed based on the selected tab
  static final List<Widget> _widgetOptions = <Widget>[
    const newhomePage(),
    MyCart(false),
    const Favorite(),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    // Set the initial selected index from the widget's pageNum
    setState(() {
      selectedIndex = widget.pageNum;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access the CartProvider to display cart items count
    final cartProvider = Provider.of<CartProvider>(context, listen: true);

    return Directionality(
      // Set text direction based on the language
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          // Show a dialog when attempting to exit the app
          yesNoOption(context);
        },
        child: Scaffold(
          body: Center(
            // Display the widget based on the selected tab index
            child: _widgetOptions.elementAt(selectedIndex),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 20,
                  color: Colors.black.withOpacity(.1),
                )
              ],
            ),
            child: SafeArea(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
                child: GNav(
                  rippleColor: mainColorGrey,
                  hoverColor: mainColorGrey,
                  gap: 6,
                  activeColor: mainColorWhite,
                  iconSize: 24,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  duration: Duration(milliseconds: 400),
                  tabBackgroundColor: mainColorGrey,
                  color: mainColorGrey,
                  tabs: [
                    GButton(
                      icon: LineIcons.home,
                      text: "Home".tr,
                    ),
                    GButton(
                      iconColor: mainColorGrey,
                      textColor: mainColorWhite,
                      rippleColor: mainColorGrey,
                      hoverColor: mainColorGrey,
                      backgroundColor: mainColorGrey,
                      gap: 6,
                      iconSize: 24,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      icon: LineIcons.shoppingCart,
                      text: 'Cart'.tr,
                      duration: Duration(milliseconds: 400),
                      leading: cartProvider.cartItems.isNotEmpty
                          ? Badge(
                              label: Text(
                                cartProvider.cartItems.length.toString(),
                              ),
                              backgroundColor: mainColorRed,
                              child: Icon(
                                LineIcons.shoppingCart,
                                color: selectedIndex == 1
                                    ? mainColorWhite
                                    : mainColorGrey,
                              ),
                            )
                          : Icon(
                              LineIcons.shoppingCart,
                              color: selectedIndex == 1
                                  ? mainColorWhite
                                  : mainColorGrey,
                            ),
                    ),
                    GButton(
                      icon: LineIcons.heart,
                      text: 'Favorite'.tr,
                    ),
                    GButton(
                      icon: LineIcons.user,
                      text: 'Account'.tr,
                    ),
                  ],
                  selectedIndex: selectedIndex,
                  onTabChange: (index) {
                    // Update the selected index when a tab is changed
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Displays a dialog box with Yes and No options for exiting the app.
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
                            "Are you sure exiting the app".tr,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              color: mainColorBlack,
                              fontFamily: mainFontnormal,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: mainColorRed,
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "No".tr,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  exit(0);
                                },
                                style: ElevatedButton.styleFrom(
                                    fixedSize: Size(getWidth(context, 30),
                                        getHeight(context, 4))),
                                child: Text(
                                  "Yes".tr,
                                ),
                              ),
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
