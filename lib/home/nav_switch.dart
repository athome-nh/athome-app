import 'dart:io';
import 'package:athome/Account/profilo.dart';
import 'package:athome/controller/cartprovider.dart';
import 'package:athome/home/favorite.dart';
import 'package:athome/home/my_cart.dart';
import 'package:athome/home/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:athome/Config/property.dart';
import 'package:provider/provider.dart';
import 'package:upgrader/upgrader.dart';
import '../main.dart';
import 'home_page.dart';

class NavSwitch extends StatefulWidget {
  const NavSwitch({super.key});

  @override
  State<NavSwitch> createState() => _NavSwitchState();
}

// Widget buildFAB(BuildContext context) {
//   final cartProvider = Provider.of<CartProvider>(context, listen: true);
//   return Visibility(
//     visible: Provider.of<productProvider>(context, listen: true).nointernetCheck
//         ? false
//         : cartProvider.cartItems.isNotEmpty
//             ? true
//             : false,
//     child: Badge(
//       label: Text(cartProvider.cartItems.length.toString()),
//       backgroundColor: mainColorWhite,
//       textColor: mainColorRed,
//       child: FloatingActionButton(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(5),
//         ),
//         onPressed: () {
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => const MyCart()),
//           );
//         },
//         backgroundColor: mainColorRed,
//         child: Icon(
//           Ionicons.cart_sharp,
//           size: getHeight(context, 5),
//         ),
//       ),
//     ),
//   );
// }

class _NavSwitchState extends State<NavSwitch> {
  int _selectedIndex = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    const HomeSreen(),
    const Search(),
    MyCart(false),
    const Favorite(),
    const Setting(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  checkUpdates() async {
await Upgrader.clearSavedSettings();

  }

 

  @override
  void initState() {
    checkUpdates();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context, listen: true);
    return Directionality(
      textDirection: lang == "en" ? TextDirection.ltr : TextDirection.rtl,
      child: WillPopScope(
        onWillPop: () async {
          yesNoOption(context);
          return false;
        },
        child: UpgradeAlert(
             upgrader: Upgrader(
              debugDisplayAlways: true,
             canDismissDialog: false,
              showIgnore: false,
              showLater: false,
              messages: UpgraderMessages( code: "ku",),
              debugLogging: true,
           //   dialogStyle: UpgradeDialogStyle.cupertino
               
             ),
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
                // Home
                BottomNavigationBarItem(
                    activeIcon: const Icon(
                      Ionicons.home,
                    ),
                    icon: const Icon(
                      Ionicons.home_outline,
                    ),
                    label: "Home".tr),
        
                // Search
                BottomNavigationBarItem(
                  icon: const Icon(
                    Ionicons.search_outline,
                  ),
                  activeIcon: const Icon(
                    Ionicons.search,
                  ),
                  label: 'Search'.tr,
                ),
        
                // Cart
                BottomNavigationBarItem(
                  icon: cartProvider.cartItems.isNotEmpty
                      ? Badge(
                          label: Text(
                            cartProvider.cartItems.length.toString(),
                          ),
                          backgroundColor: mainColorGrey,
                          child: const Icon(
                            Ionicons.cart_outline,
                          ),
                        )
                      : const Icon(
                          Ionicons.cart_outline,
                        ),
                  activeIcon: cartProvider.cartItems.isNotEmpty
                      ? Badge(
                          label: Text(
                            cartProvider.cartItems.length.toString(),
                          ),
                          backgroundColor: mainColorGrey,
                          child: const Icon(
                            Ionicons.cart_sharp,
                          ),
                        )
                      : const Icon(
                          Ionicons.cart_sharp,
                        ),
                  label: 'Cart'.tr,
                ),
        
                // Favorite
                BottomNavigationBarItem(
                  icon: const Icon(
                    FontAwesomeIcons.heart,
                  ),
                  activeIcon: const Icon(
                    FontAwesomeIcons.solidHeart,
                  ),
                  label: 'Favorite'.tr,
                ),
        
                // Account
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
          ),
        ),
      ),
    );
  }

  // Dialogbox ( yes and no )
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
