import 'dart:convert';
import 'dart:io';
import 'package:athome/Account/profilo.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:athome/Account/order_screen.dart';
import 'package:athome/Config/property.dart';
import 'package:athome/Home/MyCart.dart';
import 'package:athome/Home/Search.dart';
import 'package:provider/provider.dart';
import '../Config/local_data.dart';
import '../main.dart';
import 'home_page.dart';

class NavSwitch extends StatefulWidget {
  const NavSwitch({super.key});

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

Widget buildFAB(BuildContext context) {
  final cartProvider = Provider.of<CartProvider>(context, listen: true);
  return Visibility(
    visible: cartProvider.cartItems.isNotEmpty ? true : false,
    child: Badge(
      label: Text(cartProvider.cartItems.length.toString()),
      backgroundColor: mainColorWhite,
      textColor: mainColorRed,
      child: FloatingActionButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MyCart()),
          );
        },
        backgroundColor: mainColorRed,
        child: Icon(
          Ionicons.cart_sharp,
          size: getHeight(context, 5),
        ),
      ),
    ),
  );
}

class _NavSwitchState extends State<NavSwitch> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const HomeSreen(),
    const Search(),
    const OrderScreen(),
    const Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    getBoolPrefs("islogin").then((value) {
      if (value) {
        getStringPrefs("userData").then((data2) {
          userData = json.decode(data2);
          isLogin = true;
        });
      } else {
        isLogin = false;
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          yesNoOption(context);
          return false;
        },
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
            showUnselectedLabels: false,
            selectedFontSize: 12,
            unselectedFontSize: 12,
            selectedItemColor: mainColorWhite,
            unselectedItemColor: mainColorWhite,
            backgroundColor: mainColorRed,
            type: BottomNavigationBarType.fixed,
            items: <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  activeIcon: const Icon(
                    Ionicons.home,
                  ),
                  icon: const Icon(
                    Ionicons.home_outline,
                  ),
                  label: "Home".tr),
              BottomNavigationBarItem(
                icon: const Icon(
                  Ionicons.search_outline,
                ),
                activeIcon: const Icon(
                  Ionicons.search,
                ),
                label: 'Search'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Icons.shopping_bag_outlined,
                ),
                activeIcon: const Icon(
                  Icons.shopping_bag,
                ),
                label: 'My Orders'.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(
                  Ionicons.person_outline,
                ),
                activeIcon: const Icon(
                  Ionicons.person,
                ),
                label: 'Account'.tr,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,              
          ),
          floatingActionButton: buildFAB(context),
        ),
      ),
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
            backgroundColor: mainColorGrey,
            contentPadding: const EdgeInsets.all(0),
            content: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ClipRect(
                child: Container(
                  width: getWidth(context, 90),
                  height: getHeight(context, 25),
                  decoration: BoxDecoration(
                      color: mainColorGrey.withOpacity(0.1),
                      border:
                          Border.all(color: mainColorWhite.withOpacity(0.1)),
                      borderRadius: BorderRadius.circular(5)),
                  padding: const EdgeInsets.all(10),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: getHeight(context, 25),
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
                              color: mainColorWhite.withOpacity(0.7),
                              fontFamily: mainFontbold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(),
                          const SizedBox(),
                          const SizedBox(),
                          const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColorGrey,
                                  fixedSize: const Size(70, 35),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "No".tr,
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: mainFontbold),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  exit(0);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: mainColorRed,
                                  fixedSize: const Size(70, 35),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  "Yes".tr,
                                  style: TextStyle(
                                      fontSize: 18, fontFamily: mainFontbold),
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
