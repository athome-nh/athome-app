import 'dart:io';
import 'package:dllylas/Account/profilo.dart';
import 'package:dllylas/controller/cartprovider.dart';
import 'package:dllylas/home/favorite.dart';
import 'package:dllylas/home/my_cart.dart';
import 'package:dllylas/home/search_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:dllylas/Config/property.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {
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
        child: Scaffold(
          body: Center(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
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
                        backgroundColor: mainColorRed,
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
                        backgroundColor: mainColorRed,
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
            contentPadding: const EdgeInsets.all(0),
            content: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: ClipRect(
                child: Container(
                  width: getWidth(context, 90),
                  height: getHeight(context, 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(5)),
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
                          const SizedBox(),
                          // const SizedBox(),
                          // const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              const SizedBox(),
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
